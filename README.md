# Enterprise Edge & Services Infrastructure 🛡️

Este repositório documenta a implementação de uma infraestrutura corporativa completa, abrangendo desde serviços tradicionais de rede até orquestração de contêineres e automação (IaC). O foco contínuo é manter a governança de acesso e o hardening em todas as camadas.

## Roadmap de Implementação e Arquitetura
O ecossistema está sendo construído de forma modular:

- [x] **Fase 1: Secure File Services** - Samba + SELinux Hardening.
- [x] **Fase 2: Relational Databases & Governance** - MariaDB + Auditoria Python.
- [x] **Fase 3: NoSQL & Scalability** - MongoDB 8.0 + XFS Storage.
- [x] **Fase 4: Containerization & Isolation** - Docker & RBAC.
- [x] **Fase 5: Infrastructure as Code & Cloud Scalability** - Terraform & AWS.
- [x] **Fase 6: Enterprise Automation & Configuration** - Ansible & Vault.
- [x] **Fase 7: Cloud-Native & Orchestration** - Kubernetes (K3s) & Auto-healing.
- [ ] **Fase 8: Web Services & Comms** - Apache Hardening & Asterisk (VoIP).
- [ ] **Fase 9: Enterprise Databases & Cache** - Oracle Database & Redis Cluster.

---

## 📁 Fase 1: Secure File Services (Samba & SELinux)

### Contexto do Problema
Isolamento de dados sensíveis entre grupos de usuários em ambiente Linux corporativo.

### Solução Aplicada
Implementação de permissões granulares e contextos do SELinux (`samba_share_t`) para garantir que o serviço opere sob o princípio do privilégio mínimo.

<details>
  <summary>📂 Ver Evidências</summary>

  ![Acesso Samba](./docs/assets/01_samba_access_success.png)
  ![Firewall](./docs/assets/02_firewall_config.png)
</details>

---

## 📁 Fase 2: Relational Databases & Governance (MariaDB)

### Troubleshooting e Resolução
Falha crítica de socket no MariaDB durante a automação de backup.
* **Causa Raiz:** Arquivos de log corrompidos impedindo o spawn do processo.
* **Solução:** Purge de arquivos temporários e normalização do schema via script Python.

<details>
  <summary>📂 Ver Evidências</summary>

  ![Integridade Python](./docs/assets/evidencia_ouro_integracao_python_mariadb.png)
  ![Recovery Log](./docs/assets/image_283ba4.png)
</details>

---

## 📁 Fase 5: Infrastructure as Code (Terraform & AWS)

### Contexto do Problema
Eliminação do "Cloud Drift" através de provisionamento imutável de rede (VPC, Subnets) e computação.

### Troubleshooting (AWS SRE)
* **Erro:** 503 Service Unavailable no Elastic Load Balancer.
* **Causa Raiz:** O Target Group falhava no Health Check devido ao tempo de provisionamento do Apache.
* **Solução:** Ajuste de `health_check_timeout` e `interval` via HCL.

<details>
  <summary>📂 Ver Evidências</summary>

  ![Terraform Plan](./docs/assets/05-terraform-plan-update.png)
  ![Terraform Apply](./docs/assets/06-terraform-apply-final.png)
</details>

---

## 📁 Fase 6: Enterprise Automation (Ansible Vault)

### Diferenciais de Engenharia
* **Ansible Vault:** Criptografia AES de senhas e arquivos de configuração sensíveis.
* **Automação de Hardening:** Playbooks para padronização de segurança em instâncias Ubuntu e Rocky Linux.

<details>
  <summary>📂 Ver Evidências</summary>

  ![Conexão Ansible](./docs/assets/Captura%20de%20tela%20de%202026-04-18%2010-38-02.png)
  ![Ansible Vault](./docs/assets/Captura%20de%20tela%20de%202026-04-18%2011-13-10.png)
</details>

---

## 📁 Fase 7: [GOLDEN EVIDENCE] Cloud-Native (Kubernetes K3s)

### Contexto do Problema
Garantir alta disponibilidade com recuperação automática de pods (Auto-healing).

### Troubleshooting de Sistema (Ubuntu Nativo)
* **Causa Raiz:** Atributos de imutabilidade (`chattr +i`) bloqueando escrita de manifestos.
* **Solução:** Investigação via `lsattr` e limpeza de permissões de baixo nível no sistema de arquivos.

<details>
  <summary>📂 Ver Evidências</summary>

  ![K8s Success](./docs/assets/Captura%20de%20tela%20de%202026-04-19%2013-05-43.png)
  ![Auto Healing](./docs/assets/Captura%20de%20tela%20de%202026-04-19%2013-14-30.png)
</details>

---

## 📁 Fase 8: Web Services & Comms (Hardening Apache)

### Proposta Técnica
Implementação de camadas de segurança no Apache (ModSecurity) e infraestrutura de comunicação IP via Asterisk, visando mensageria interna segura.

---

## 📁 Fase 9: Enterprise Databases & Cache (Oracle & Redis)

### Proposta Técnica
Persistência de dados em nível bancário com Oracle PL/SQL e otimização de performance de leitura via cache distribuído com Redis Cluster.

---

> [!IMPORTANT]
> **Lição Aprendida: VIM vs. IDE**
> Para manifestos Kubernetes (YAML) e Terraform (HCL), o uso de uma IDE com validação sintática é mandatória para evitar erros de indentação fatais que o VIM não detecta nativamente.

### Conclusão de Valor
Este ecossistema integra as melhores práticas de SRE e DevOps, unindo serviços legados otimizados com orquestração cloud-native moderna.
