# Enterprise Edge & Services Infrastructure 🛡️

Repositório dedicado à construção, orquestração e administração de uma infraestrutura corporativa completa (Híbrida/Cloud). Este laboratório documenta a transição de serviços tradicionais de rede e armazenamento para um ecossistema **Cloud-Native**, focado em **IaC, Automação, Alta Disponibilidade e Cultura SRE**.

## 🎯 Business Value & Segurança
O objetivo principal deste projeto é garantir que **dados corporativos estejam seguros (Data-at-Rest Encryption)**, que a infraestrutura seja **mutável apenas via código (Terraform/Ansible)**, e que os serviços críticos tenham **recuperação automática (Auto-healing)** contra falhas operacionais.

---

## Stack Tecnológica & Matriz de Arquitetura
* **Cloud & Orquestração:** AWS, Terraform, Kubernetes (K3s), Docker.
* **Sistemas Operacionais:** Ubuntu 24.04 LTS (Control Plane) & Rocky Linux 9 (Data Nodes).
* **Governança & Automação:** Ansible Vault, Python Scripts, SELinux, ModSecurity.

### Matriz de Serviços Corporativos
| Camada | Tecnologia Principal | Estratégia de Persistência/Segurança | Função no Ecossistema |
| :--- | :--- | :--- | :--- |
| **Infra as Code** | Terraform & AWS | State Lock / IAM Roles | Provisionamento Declarativo Multi-Cloud |
| **Automação** | Ansible Vault | AES-256 Encryption | Padronização de Servidores e Segredos |
| **Orquestração** | K3s (Kubernetes)| Auto-Healing / RBAC | Alta Disponibilidade de Microsserviços |
| **NoSQL Storage** | MongoDB 8.0 | XFS Storage / TTL Indexes | Cache, Alta Volumetria e Logs Temporários |
| **SQL Database** | MariaDB | Data-at-Rest (SHA512/AES) | Dados Estruturados e Auditoria Financeira |
| **File Services** | Samba Share | SELinux Contexts (`samba_share_t`) | Compartilhamento Corporativo Isolado |

---

## 📁 1. Secure File Services (Samba & SELinux)

### Contexto do Problema
O ecossistema demandava um servidor de arquivos capaz de isolar dados sensíveis entre setores, operando estritamente dentro das políticas de acesso do SO.

### Troubleshooting e Resolução
* **Solução Aplicada:** Configuração de diretórios com permissões granulares (`0770`), bloqueio via Firewall nativo (Firewalld) e implementação de contextos do **SELinux** para mitigar acessos não autorizados por processos não catalogados.

### Evidência Técnica
<details>
  <summary>📂 Clique para ver a Configuração e Validação de Acesso</summary>

  * **Hardening no smb.conf:** ![Samba Config](./docs/assets/06_samba_config_validation.png)
  * **Acesso Efetivo:** ![Samba Access](./docs/assets/01_samba_access_success.png)
</details>

---

## 📁 2. Relational Databases & Governance (MariaDB)

### Contexto do Problema
Garantir integridade, rastreabilidade total (Auditoria) e capacidade de recuperação (Disaster Recovery) em um banco de dados relacional crítico.

### Troubleshooting (Post-Mortem: Systemd & Socket)
Durante testes de resiliência, o banco apresentou falha crítica (`exit-code=1`).
* **Causa Raiz:** Crash do sistema gerou PIDs corrompidos e um socket órfão (`mysql.sock`).
* **Resolução:** Limpeza manual profunda em `/var/lib/mysql`, expurgo do socket, reset de propriedades de usuário e restart limpo do daemon via `systemctl`.

### Evidência Técnica
<details>
  <summary>📂 Clique para ver Resolução, Auditoria e Criptografia</summary>

  * **O Incidente (Socket SRE):** ![Resolucao Socket](./docs/assets/04_resolucao_conflito_porta_causa_raiz.png)
  * **Criptografia AES/SHA512:** ![Criptografia](./docs/assets/criptografia_avancada_sha512_aes.png)
  * **Integração Python:** ![Automação Python](./docs/assets/evidencia_ouro_integracao_python_mariadb.png)
  * **Auditoria em Tempo Real:** ![Log Auditoria](./docs/assets/auditoria_tempo_real.png)
  * **Disaster Recovery (Success):** ![Recovery](./docs/assets/08_recovery_sucesso_database.png)
</details>

---

## 📁 3. NoSQL & Scalability (MongoDB 8.0)

### Contexto do Problema
Necessidade de gravação ultrarrápida no nível do SO (XFS) e expiração automática de dados temporários para evitar saturação de disco.

### Troubleshooting (SELinux Enforcing)
O daemon `mongod` sofria bloqueios silenciosos do sistema.
* **Causa Raiz:** O SELinux em modo `Enforcing` bloqueava operações de rede e gravação não padrão.
* **Mitigação:** Análise do `audit.log` com `ausearch` e compilação de um módulo customizado de liberação via `audit2allow -M`.

### Evidência Técnica
<details>
  <summary>📂 Clique para ver Troubleshooting, Storage e TTL</summary>

  * **Bloqueio SELinux:** ![Ausearch](./docs/assets/ausearch-denied-selinux-mongod.png)
  * **Criação de Módulo:** ![Audit2Allow](./docs/assets/systemctl-status-failed-retry.png)
  * **Performance XFS:** ![Storage XFS](./docs/assets/mongo-storage-wiredtiger-xfs.png)
  * **Ciclo de Vida (TTL):** ![TTL Index](./docs/assets/m5-mongo-ttl-create-index-and-expired-validation-02.png)
</details>

---

## 📁 4. Containerization & Isolation (Docker)

### Contexto do Problema
Isolamento rigoroso de dependências (Python + DB) para pipelines de CI/CD, garantindo portabilidade.

### Evidência Técnica
<details>
  <summary>📂 Clique para ver Deploy de Contêineres</summary>

  * **Isolamento de DB:** ![Docker Auth](./docs/assets/mongo-docker-container-auth.png)
  * **Rede Blue Team (Compose):** ![Docker Compose](./docs/assets/lab-docker-compose-multi-service-python-mongo.png)
</details>

---

## 📁 5. Infrastructure as Code (Terraform na AWS)

### Contexto do Problema
A eliminação do "Cloud Drift" (mudanças manuais em produção) exigia que a topologia (EC2, VPC, ELB) fosse declarada em HCL.

### Troubleshooting (API AWS)
* **Incidente:** Erro de provisionamento `InvalidParameterCombination`.
* **Causa Raiz:** Solicitação de uma classe de instância incompatível com as restrições de sub-rede e Free Tier da AWS.
* **Resolução:** Refatoração do `main.tf` adaptando os requisitos do Cloud Provider.

### Evidência Técnica
<details>
  <summary>📂 Clique para ver o Ciclo IaC e Validação</summary>

  * **AWS API Log Error:** ![Free Tier Error](./docs/assets/error-aws-free-tier-validation.png)
  * **Terraform Plan:** ![Plan](./docs/assets/05-terraform-plan-update.png)
  * **Terraform Apply:** ![Apply](./docs/assets/06-terraform-apply-final.png)
</details>

---

## 📁 6. Enterprise Automation (Ansible Vault)

### Diferenciais de Engenharia
* **Idempotência:** Playbooks garantem que os servidores atinjam o "estado desejado" de hardening sem retrabalho.
* **Ansible Vault:** Proteção de nível militar para não expor credenciais em texto plano nos repositórios.

### Evidência Técnica
<details>
  <summary>📂 Clique para ver Automação e Auditoria</summary>

  * **Conexão Base:** ![Ping](./docs/assets/ansible-conexao-sucesso.png)
  * **Execução Segura (Vault):** ![Vault Run](./docs/assets/ansible_hardening_vault_success.png)
  * **Auditoria Pós-Automação:** ![Audit Report](./docs/assets/ansible-final-audit-report-success.png)
</details>

---

## 📁 7. [GOLDEN EVIDENCE] Cloud-Native (Kubernetes SRE)

### Contexto do Problema
Garantir alta disponibilidade e recuperação autônoma de pods.

### Troubleshooting (Filesystem Lock no Bare Metal)
Deploy do K3s apresentando falhas crônicas de "Operation not permitted" em sistema operando como root.
* **Investigação SRE:** Uso de análise avançada de SO (`lsattr`) para detectar atributos ocultos no FS.
* **Causa Raiz:** O arquivo `sources.list` possuía atributo de imutabilidade (`+i`), resquício de hardening prévio.
* **Resolução:** Remoção manual da imutabilidade com `chattr -i` e sanitização de repositórios.

### Evidência Técnica
<details>
  <summary>📂 Clique para ver Troubleshooting e Cluster Ativo</summary>

  * **Investigação FS (chattr):** ![Chattr Lock](./docs/assets/filesystem-lock-investigation.png)
  * **Cluster Subindo:** ![K3s Setup](./docs/assets/k8s-cluster-deployment-success.png)
  * **Teste de Resiliência:** ![Auto Healing](./docs/assets/k8s-auto-healing-test.png)
</details>

---

## 📁 SRE Deep Dive: Monitoramento de Kernel (OOM-Killer)

A confiabilidade não termina na aplicação; ela se estende ao SO subjacente.
* **O Incidente:** Serviços sofrendo *kill* súbito sem logs de aplicação.
* **Investigação SRE:** Leitura do ring buffer do kernel via `dmesg`, identificando o **Out of Memory (OOM) Killer** agindo sobre processos pesados.
* **Ação Corretiva:** Alocação de arquivo `swap` emergencial de 8GB a quente (`fallocate` + `mkswap`) para salvar a estabilidade do nó.

<details>
  <summary>📂 Clique para ver os Logs de Kernel e Ação a Quente</summary>

  * **Log do Kernel (OOM):** ![OOM Killer](./docs/assets/linux-kernel-log-oom-killer-hytale.png)
  * **Swap Resize A Quente:** ![Swap 8GB](./docs/assets/ubuntu-swap-resize-8gb-active.png)
</details>

---

## ⏳ Em Andamento (Próximas Fases)
* **Fase 8: Web Services & Comms** - Apache Hardening (ModSecurity/SSL) & Asterisk (Tráfego VoIP Corporativo).
* **Fase 9: Enterprise Databases & Cache** - Deploy de Oracle Database/PL-SQL e Redis Cluster para cache distribuído.

> [!IMPORTANT]
> **Lição Aprendida SRE: VIM vs. IDE**
> Embora o VIM seja a ferramenta definitiva para "estancar sangramentos" de madrugada dentro do servidor, a escrita de infraestrutura (Terraform HCL) e manifestos Kubernetes (YAML) exige ferramentas de linting. Erros silenciosos de indentação custam janelas de deploy.
