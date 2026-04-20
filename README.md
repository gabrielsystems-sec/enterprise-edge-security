# Enterprise Edge & Services Infrastructure 🛡️

Este repositório documenta a implementação de uma infraestrutura corporativa completa, abrangendo desde serviços tradicionais de rede até orquestração de contêineres e automação (IaC). O foco contínuo é manter a governança de acesso e o hardening em todas as camadas.

## Roadmap de Implementação e Arquitetura
O ecossistema está sendo construído de forma modular, com as seguintes fases de implantação:

- [x] **Fase 1: Secure File Services** - Servidor Samba com permissões granulares e isolamento de rede.
- [x] **Fase 2: Relational Databases & Governance** - MariaDB (Atlas Server) com auditoria e automação Python.
- [x] **Fase 3: NoSQL & Scalability** - MongoDB 8.0 (XFS) + Ciclo de Vida (TTL) + Transações Atômicas.
- [x] **Fase 4: Containerization & Isolation** - Docker + Troubleshooting de Portas + RBAC.
- [x] **Fase 5: Infrastructure as Code & Cloud Scalability** - Automação com Terraform, provisionamento na AWS.
- [x] **Fase 6: Enterprise Automation & Configuration** - Gerenciamento de configuração com Ansible.
- [x] **Fase 7: Cloud-Native & Orchestration** - Orquestração via Kubernetes (K3s).
- [ ] **Fase 8: Web Services & Comms** - Hardening de Apache (Seção 40) e VoIP com Asterisk.
- [ ] **Fase 9: Enterprise Databases & Cache** - Administração de Oracle/PL-SQL e Cache com Redis.

## Ambiente de Desenvolvimento
Para a orquestração e gerenciamento da infraestrutura, foi utilizada uma arquitetura híbrida:

* **OS Nativo (Ubuntu 24.04 LTS):** Estação principal para ferramentas CLI (Terraform, AWS CLI) e Orquestração (K3s).
* **Virtualization (Rocky Linux 9):** Servidor de serviços críticos (Samba, MongoDB, MariaDB) para simular ambientes corporativos.
* **IaC Engine:** Terraform v1.x para automação multi-cloud.
* **Interface:** VS Code com extensões HCL e YAML para validação de sintaxe.

---

## 📁 Fase 1: Samba Secure Storage (Concluído)

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

### Evidência Técnica
**1. Autenticação e Operações em Lote:**
<details>
  <summary>📂 Clique para ver a autenticação Docker e BulkWrite</summary>

  ![Autenticação Docker](./docs/assets/mongo-docker-container-auth.png)
  ![Bulk Write Operations](./docs/assets/mongo-docker-crud-bulk-ops.png)
</details>

---

## 📁 Fase 5: Infrastructure as Code & Cloud Scalability (Concluído)

### Evidência Técnica
**1. Orquestração Terraform:**
<details>
  <summary>📂 Clique para ver o Plan e Apply</summary>

  ![Terraform Plan](./docs/assets/05-terraform-plan-update.png)
  ![Terraform Apply](./docs/assets/06-terraform-apply-final.png)
</details>

---

## 📁 Fase 6: Enterprise Automation & Configuration (Concluído)

### Evidência Técnica
**1. Gestão de Configuração e Conectividade:**
<details>
  <summary>📂 Clique para ver o Setup e Conexão Ansible</summary>

  ![Conexão Ansible](./docs/assets/Captura%20de%20tela%20de%202026-04-18%2010-38-02.png)
  ![Setup Base](./docs/assets/Captura%20de%20tela%20de%202026-04-18%2010-48-26.png)
</details>

**2. Segurança e Auditoria Final:**
<details>
  <summary>📂 Clique para ver o Hardening com Vault e Relatórios</summary>

  ![Ansible Vault](./docs/assets/Captura%20de%20tela%20de%202026-04-18%2011-13-10.png)
  ![Auditoria Final](./docs/assets/Captura%20de%20tela%20de%202026-04-18%2011-16-17.png)
</details>

---

## 📁 Fase 7: Cloud-Native & Orchestration (Concluído)

### Evidência Técnica
**1. Deploy e Resiliência:**
<details>
  <summary>📂 Clique para ver o Cluster e Auto-Healing</summary>

  ![K8s Success](./docs/assets/Captura%20de%20tela%20de%202026-04-19%2013-05-43.png)
  ![Auto Healing](./docs/assets/Captura%20de%20tela%20de%202026-04-19%2013-14-30.png)
</details>

**2. Investigação e Troubleshooting:**
<details>
  <summary>📂 Clique para ver a resolução de bloqueios de sistema</summary>

  ![Filesystem Lock](./docs/assets/Captura%20de%20tela%20de%202026-04-19%2012-32-13.png)
  ![APT Sanitization](./docs/assets/Captura%20de%20tela%20de%202026-04-19%2012-45-42.png)
</details>

> [!IMPORTANT]
> **Lição Aprendida: VIM vs. IDE**
> Embora o VIM seja vital para ajustes rápidos, para manifestos Kubernetes (YAML) e Terraform, a IDE (VS Code) é mandatória para evitar erros de indentação fatais ao deploy.

---

## 📁 Segurança de Identidade & Hardening de Sistema (Concluído)

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
A integração de IaC (Terraform), Automação (Ansible) e Orquestração (Kubernetes) garante uma infraestrutura resiliente, escalável e auditável para operações críticas.
