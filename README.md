# Enterprise Edge & Services Infrastructure 🛡️

Este repositório documenta a implementação de uma infraestrutura corporativa completa, abrangendo desde serviços tradicionais de rede até orquestração de contêineres e automação (IaC). O foco contínuo é manter a governança de acesso e o hardening em todas as camadas.

## Roadmap de Implementação e Arquitetura

O ecossistema está sendo construído de forma modular, com as seguintes fases de implantação:

- [x] **Fase 1: Secure File Services** - Servidor Samba com permissões granulares e isolamento de rede.
- [x] **Fase 2: Database Systems & Data Governance** - Implantação de MariaDB (Atlas Server), criptografia AES, auditoria e automação Python.
- [ ] **Fase 3: NoSQL & Scalability** - Implementação de MongoDB para documentos e alta disponibilidade.
- [ ] **Fase 4: Containerization & Orchestration** - Empacotamento via Docker e gestão de microsserviços.
- [ ] **Fase 5: Web & Comms** - Hospedagem Apache e infraestrutura VoIP com Asterisk.
- [ ] **Fase 6: Infrastructure as Code - IaC** - Automação com Ansible e Terraform.

---

## 📁 Fase 1: Samba Secure Storage (Concluído)

### Contexto do Problema
O ambiente corporativo demandava um servidor de arquivos centralizado capaz de isolar dados sensíveis entre grupos de usuários. A premissa técnica era garantir o serviço operando estritamente dentro das políticas ativas do SELinux (Permissive) e do Firewall corporativo.

### Troubleshooting e Resolução
Durante a homologação, identificou-se o erro `NT_STATUS_IO_TIMEOUT`.
* **Causa Raiz:** Host e VM em sub-redes distintas via NAT, causando descarte de pacotes.
* **Solução Aplicada:** Migração para modo Bridge, whitelisting no firewalld e ajuste de booleanos do SELinux.

### Evidência Técnica
**1. Acesso Efetivo e Permissões:**
![Acesso Samba](./docs/assets/01_samba_access_success.png)

**2. Hardening de Rede e Kernel:**
![Configuração de Firewall](./docs/assets/02_firewall_config.png)
![Configuração SELinux](./docs/assets/03_selinux_configuration.png)

---

## 📁 Fase 2: Database Systems & Data Governance (Concluído)

### Contexto do Problema
A infraestrutura necessitava de uma camada de persistência para dados sensíveis sob conformidade (LGPD/GDPR). O desafio era garantir proteção Data-at-Rest e rastreabilidade total de operações, impedindo acessos não autorizados mesmo por usuários com privilégios de sistema.

### Troubleshooting e Resolução (Integração Python)
Na automação do middleware, identificou-se o erro `Table doesn't exist` no script Python.
* **Causa Raiz:** Divergência de schema no Atlas Server após migração de tabelas criptografadas.
* **Solução Aplicada:** Hotfix via CLI do MariaDB para normalização do schema e implementação de blocos try/except no Python para garantir resiliência e logs de erro limpos.

### Evidência Técnica

**1. Proteção de Dados (Criptografia AES):**
Uso de AES_ENCRYPT e VARBINARY para garantir que dados sensíveis permaneçam ilegíveis sem a chave mestra.
![Criptografia Avançada](./docs/assets/criptografia_avancada_sha512_aes.png)

**2. Observabilidade (Auditoria em Tempo Real):**
Configuração do log de auditoria do MariaDB no Rocky Linux para monitoramento de todas as transações.
![Auditoria em Tempo Real](./docs/assets/auditoria_tempo_real.png)

**3. Automação e Resiliência (Python Integration):**
Script final executando o ciclo: registro de log de acesso, consulta e descriptografia de dados em tempo real.
![Integração Python](./docs/assets/evidencia_ouro_integracao_python_mariadb.png)

### Conclusão de Valor
A arquitetura do Atlas Server assegura integridade e confidencialidade. A integração com Python permite escalar processos automatizados mantendo o rigor de segurança exigido em infraestruturas corporativas modernas.

---

## 📁 Fase 3: NoSQL & Scalability (Em Breve)
*(Aguardando implementação do MongoDB)*

---

## 📁 Fase 4: Containerization (Em Breve)
*(Aguardando implementação do Docker)*
