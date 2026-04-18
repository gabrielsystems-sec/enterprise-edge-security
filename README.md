# Enterprise Edge & Services Infrastructure 🛡️

Este repositório documenta a implementação de uma infraestrutura corporativa completa, abrangendo desde serviços tradicionais de rede até orquestração de contêineres e automação (IaC). O foco contínuo é manter a governança de acesso e o hardening em todas as camadas.

## Roadmap de Implementação e Arquitetura
O ecossistema está sendo construído de forma modular, com as seguintes fases de implantação:

- [x] **Fase 1: Secure File Services** - Servidor Samba com permissões granulares e isolamento de rede.
- [x] **Fase 2: Relational Databases & Governance** - MariaDB (Atlas Server) com auditoria e automação Python.
- [x] **Fase 3: NoSQL & Scalability** - MongoDB 8.0 (XFS) + Ciclo de Vida (TTL) + Transações Atômicas.
- [x] **Fase 4: Containerization & Isolation** - Docker + Troubleshooting de Portas + RBAC.
- [x] **Fase 5: Infrastructure as Code & Cloud Scalability** - Automação com Terraform, provisionamento de Clusters e Load Balancers na AWS.
- [ ] **Fase 6: Enterprise Automation & Configuration** - Gerenciamento de configuração com Ansible.
- [ ] **Fase 7: Cloud-Native & Orchestration** - Orquestração de microsserviços via Kubernetes.
- [ ] **Fase 8: Web Services & Comms** - Hardening de Apache (Seção 40) e VoIP com Asterisk.
- [ ] **Fase 9: Enterprise Databases & Cache** - Administração de Oracle/PL-SQL (Seções 45/46) e Cache com Redis.

## Ambiente de Desenvolvimento
Para a orquestração e gerenciamento de toda a infraestrutura deste repositório, foi utilizada uma estação de trabalho dedicada com foco em performance e segurança:

* **OS:** Ubuntu 24.04 LTS (Argos) - Ambiente nativo para execução de ferramentas CLI.
* **IaC Engine:** Terraform v1.x (HashiCorp) para automação multi-cloud.
* **Interface:** VS Code com extensões HCL para validação de sintaxe.
* **Connectivity:** AWS CLI v2 configurado com políticas de acesso restrito (IAM).

---

## 📁 Fase 1: Samba Secure Storage (Concluído)

### Contexto do Problema
O ambiente corporativo demandava um servidor de arquivos centralizado capaz de isolar dados sensíveis entre grupos de usuários. A premissa técnica era garantir o serviço operando estritamente dentro das políticas ativas do SELinux e do Firewall corporativo.

### Troubleshooting e Resolução
Durante a homologação, identificou-se o erro `NT_STATUS_IO_TIMEOUT`.
* **Causa Raiz:** Host e VM em sub-redes distintas via NAT, causando descarte de pacotes.
* **Solução Aplicada:** Migração para modo Bridge, whitelisting no firewalld e ajuste de booleanos do SELinux.

### Evidência Técnica

**1. Acesso Efetivo e Permissões:**
<details>
  <summary>📂 Clique para ver a validação de acesso Samba</summary>

  ![Acesso Samba](./docs/assets/01_samba_access_success.png)
</details>

**2. Hardening de Rede e Kernel:**
<details>
  <summary>📂 Clique para ver a configuração de Firewall e SELinux</summary>

  ![Configuração de Firewall](./docs/assets/02_firewall_config.png)
  ![Configuração SELinux](./docs/assets/03_selinux_configuration.png)
</details>

---

## 📁 Fase 2: Relational Databases & Governance (Concluído)

### Contexto do Problema
A infraestrutura necessitava de uma camada de persistência para dados sensíveis sob conformidade. O desafio era garantir proteção Data-at-Rest e rastreabilidade total de operações.

### Troubleshooting e Resolução (Critical Recovery)
Identificou-se uma falha crítica de inicialização do serviço MariaDB (socket error) e divergência de schema na automação Python.
* **Solução Aplicada:** Intervenção manual via CLI para limpeza de arquivos temporários de log, reset de permissões no diretório `/var/lib/mysql` e normalização do schema via hotfix Python com blocos try/except.

### Evidência Técnica

**1. Proteção de Dados e Automação:**
<details>
  <summary>📂 Clique para ver a criptografia AES e Integração Python</summary>

  ![Criptografia Avançada](./docs/assets/criptografia_avancada_sha512_aes.png)
  ![Integração Python](./docs/assets/evidencia_ouro_integracao_python_mariadb.png)
</details>

**2. Recuperação Crítica e Auditoria:**
<details>
  <summary>📂 Clique para ver o log de comandos de recovery e auditoria</summary>

  ![MariaDB Recovery](./docs/assets/image_283ba4.png)
  ![Auditoria em Tempo Real](./docs/assets/auditoria_tempo_real.png)
  ![Automação Auditoria](./docs/assets/09_automacao_auditoria_seguranca.png)
</details>

---

## 📁 Fase 3: NoSQL & Scalability (Concluído)

### Contexto do Problema
Instalação do MongoDB 7.0/8.0 no Rocky Linux sob sistema de arquivos XFS e autenticação RBAC.

### Evidência Técnica

**1. Tuning de Storage & Performance:**
<details>
  <summary>📂 Clique para ver a arquitetura XFS e Índices</summary>

  ![Storage WiredTiger](./docs/assets/mongo-storage-wiredtiger-xfs.png)
  ![MongoDB Indexes](./docs/assets/m5-mongo-advanced-indexes-text-and-partial-validation.png)
</details>

**2. Governança e Ciclo de Vida:**
<details>
  <summary>📂 Clique para ver TTL e Agregações</summary>

  ![MongoDB TTL](./docs/assets/m5-mongo-ttl-create-index-and-expired-validation-02.png)
  ![MongoDB lookup SRE](./docs/assets/mongodb-advanced-lookup-sre.png)
</details>

---

## 📁 Fase 4: Containerization & Isolation (Concluído)

### Contexto do Problema
Conteinerização da stack MongoDB para isolamento de ambiente, garantindo que o pull da imagem oficial ocorra via repositórios comunitários compatíveis com Rocky Linux.

### Evidência Técnica

**1. Autenticação e Operações em Lote:**
<details>
  <summary>📂 Clique para ver a autenticação Docker e BulkWrite</summary>

  ![Autenticação Docker](./docs/assets/mongo-docker-container-auth.png)
  ![Bulk Write Operations](./docs/assets/mongo-docker-crud-bulk-ops.png)
</details>

---

## 📁 Fase 5: Infrastructure as Code & Cloud Scalability (Concluído)

### Contexto do Problema
Padronização do provisionamento de recursos na AWS (us-east-1) via Terraform, garantindo infraestrutura declarativa e resiliente.

### Troubleshooting e Resolução
Identificou-se o erro `503 Service Unavailable` no Load Balancer durante o deploy inicial.
* **Causa Raiz:** Latência no Health Check enquanto o script de User Data instalava o Apache.
* **Solução Aplicada:** Refatoração do script de provisionamento e ajuste de Security Groups para permitir o tráfego interno do ELB.

### Evidência Técnica

**1. Orquestração Terraform:**
<details>
  <summary>📂 Clique para ver o Plan e Apply</summary>

  ![Terraform Plan](./docs/assets/05-terraform-plan-update.png)
  ![Terraform Apply](./docs/assets/06-terraform-apply-final.png)
</details>

---

## 📁 Segurança de Identidade & Hardening de Sistema (Concluído)

### Contexto do Problema
Aplicação de hardening rigoroso na instância **Rocky Linux (VM)** e na workstation **Ubuntu** para mitigar escalada de privilégios.

### Evidência Técnica

**1. Gestão de Identidades e RBAC:**
<details>
  <summary>📂 Clique para ver as políticas de segurança</summary>

  ![Politica de Senhas](./docs/assets/politica_senhas_e_seguranca_acesso.png)
  ![RBAC Final](./docs/assets/evidencia-rbac-final.png)
</details>

**2. Resiliência e Auditoria Root:**
<details>
  <summary>📂 Clique para ver auditoria e hardening</summary>

  ![HTTPD SSL](./docs/assets/httpd-ssl-hardening-success.png)
  ![Auditoria Root](./docs/assets/05_auditoria_privilegios_root_final.png)
  ![Ubuntu Swap](./docs/assets/ubuntu-swap-resize-8gb-active.png)
</details>

---

### Conclusão de Valor
A automação via Terraform aliada a políticas rigorosas de Hardening e governança de dados garante uma infraestrutura resiliente e auditável. A união de serviços nativos otimizados com instâncias conteinerizadas fornece a elasticidade necessária para operações críticas modernas.
