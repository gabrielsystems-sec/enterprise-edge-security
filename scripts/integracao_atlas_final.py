#!/usr/bin/env python3
import MySQLdb
import sys

# Configurações do Atlas Server
config = {
    'host': 'localhost',
    'user': 'root',
    'passwd': 'SUA_SENHA_AQUI',
    'db': 'milestone_ouro'
}

def executar_automacao():
    try:
        # 1. CONEXAO (Aula 290)
        db = MySQLdb.connect(**config)
        cursor = db.cursor()
        print("[INFO] Conexao estabelecida com o servidor Atlas.")

        # 2. INSERCAO DE LOG (Aula 291)
        # Registrando a operacao no banco para auditoria futura
        sql_insert = "INSERT INTO logs_acesso (usuario, acao) VALUES ('python_service', 'automated_data_retrieval');"
        cursor.execute(sql_insert)
        db.commit() 
        print("[SUCCESS] Log de acesso registrado via Python.")

        # 3. CONSULTA E DESCRIPTOGRAFIA (Aula 292/293)
        # Recuperando dados sensiveis usando a chave mestra definida no banco
        sql_select = "SELECT nome, AES_DECRYPT(cpf, 'chave_mestra_atlas') FROM usuarios_seguros;"
        cursor.execute(sql_select)
        
        print("\n--- RELATORIO DE DADOS SEGUROS ---")
        for (nome, cpf) in cursor.fetchall():
            # Convertendo bytes para string (padrao MariaDB)
            cpf_limpo = cpf.decode() if cpf else "DATA_ERROR"
            print(f"USER: {nome} | CPF_DECRYPTED: {cpf_limpo}")
        
        # 4. ENCERRAMENTO (Aula 290)
        db.close()
        print("\n[INFO] Sessao finalizada e conexao encerrada.")

    except MySQLdb.Error as e:
        # 5. TRATAMENTO DE EXCECOES (Aula 294)
        print(f"[ERROR] Falha na operacao de banco de dados: {e}")
        sys.exit(1)
    except Exception as ex:
        print(f"[CRITICAL] Erro inesperado no script: {ex}")
        sys.exit(1)

if __name__ == "__main__":
    executar_automacao()
