#!/bin/bash

# ==========================================================
# Script: db_security_integrity.sh
# Objetivo: Automação de Backup e Check de Integridade
# Integração: Repos 01-04 (Infra) + Repo 05 (Security)
# ==========================================================

# 1. Configurações (Conceito de Variáveis do Repo 01)
DATA=$(date +%Y-%m-%d_%H-%M)
DIR_BACKUP="../docs/backups" # Salva na pasta docs do seu repo
LOG_SEGURANCA="../docs/security_audit.log"
BANCO="banco_seguro"

# Garante que as pastas existam
mkdir -p $DIR_BACKUP

echo "[$(date)] --- Iniciando Auditoria de Disponibilidade ---" >> $LOG_SEGURANCA

# 2. Check de Serviço (Conceito de Observabilidade do Repo 04)
if systemctl is-active --quiet mariadb; then
    echo "[OK] MariaDB ativo. Iniciando Backup Lógico (Repo 05)..." >> $LOG_SEGURANCA
    
    # 3. Backup com Redirecionamento
    # Nota: Use o arquivo .my.cnf para não expor senha ou digite quando pedir
    mysqldump --defaults-extra-file=/root/.my.cnf banco_seguro > $DIR_BACKUP/backup_$DATA.sql
    
    if [ $? -eq 0 ]; then
        echo "[SUCESSO] Backup gerado em $DIR_BACKUP" >> $LOG_SEGURANCA
    else
        echo "[ERRO] Falha crítica ao gerar backup!" >> $LOG_SEGURANCA
    fi
else
    echo "[FALHA] Banco de dados offline. Alerta de Segurança disparado!" >> $LOG_SEGURANCA
fi

echo "--- Auditoria Finalizada ---" >> $LOG_SEGURANCA
