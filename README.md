# Enterprise Edge & Services Infrastructure 🛡️

Laboratório de infraestrutura corporativa que reúne serviços de rede, bancos de dados, automação, IaC e workloads Cloud-Native. O projeto documenta implementações práticas, falhas encontradas durante os testes e os processos de troubleshooting aplicados para restaurar os serviços.

## Foco do Laboratório

- Automação e infraestrutura como código
- Serviços corporativos e bancos de dados
- Containers e Kubernetes
- Segurança e controle de acesso
- Troubleshooting e investigação de falhas
- Resiliência e recuperação de serviços

---

## Stack Tecnológica

**Cloud & IaC:** AWS, Terraform, Ansible  
**Containers & Orquestração:** Docker, K3s (Kubernetes)  
**Sistemas:** Ubuntu 24.04 LTS, Rocky Linux 9  
**Bancos & Cache:** MariaDB, MongoDB, Redis, Oracle Database 19c  
**Segurança:** SELinux, Ansible Vault, ModSecurity, RBAC  
**Serviços:** Samba, Asterisk  

---

# 1. Serviços e Dados

## Secure File Services — Samba & SELinux

Implementação de um servidor de arquivos com permissões granulares, controle via Firewalld e integração com contextos do SELinux.

**Tecnologias:** Samba, SELinux, Firewalld

<details>
<summary>Ver evidências técnicas</summary>

![Samba Config](./docs/assets/06_samba_config_validation.png)

![Samba Access](./docs/assets/01_samba_access_success.png)

</details>

---

## MariaDB — Troubleshooting, Auditoria & Recovery

Durante testes de resiliência, o banco apresentou falha com `exit-code=1`.

**Causa raiz:** PIDs corrompidos e um socket `mysql.sock` órfão após um crash do sistema.

**Resolução:** Limpeza dos arquivos residuais em `/var/lib/mysql`, remoção do socket e reinicialização controlada do serviço.

Também foram realizados testes de criptografia, auditoria, integração com Python e recuperação do banco.

<details>
<summary>Ver evidências técnicas</summary>

![Resolucao Socket](./docs/assets/04_resolucao_conflito_porta_causa_raiz.png)

![Criptografia](./docs/assets/criptografia_avancada_sha512_aes.png)

![Automação Python](./docs/assets/evidencia_ouro_integracao_python_mariadb.png)

![Recovery](./docs/assets/08_recovery_sucesso_database.png)

</details>

---

## MongoDB 8.0 — Storage, TTL & SELinux

Implementação de MongoDB com foco em armazenamento XFS, ciclo de vida de dados temporários e troubleshooting em ambiente com SELinux `Enforcing`.

O daemon sofreu bloqueios relacionados às políticas de segurança. A investigação utilizou `audit.log` e `ausearch`, seguida da criação de um módulo específico com `audit2allow`.

Também foi implementado TTL Index para expiração automática de dados temporários.

<details>
<summary>Ver evidências técnicas</summary>

![SELinux](./docs/assets/ausearch-denied-selinux-mongod.png)

![XFS](./docs/assets/mongo-storage-wiredtiger-xfs.png)

![TTL](./docs/assets/m5-mongo-ttl-create-index-and-expired-validation-02.png)

</details>

---

## Redis — RBAC, Performance & Persistência

Implementação de Redis com substituição da senha global por ACLs, seguindo o princípio do menor privilégio.

A persistência foi configurada utilizando o modelo híbrido RDB + AOF, com testes de benchmark e recuperação.

<details>
<summary>Ver evidências técnicas</summary>

![Redis RBAC](./docs/assets/redis_rbac_security_validation.png)

![Redis Performance](./docs/assets/redis_final_performance_and_dr.png)

</details>

---

## Oracle Database 19c — Kernel & Storage Tuning

Preparação de ambiente para Oracle Database com ajustes de kernel, memória compartilhada, descritores de arquivos e armazenamento dedicado.

A configuração foi automatizada com scripts de ambiente e parâmetros persistentes via `sysctl.conf`.

<details>
<summary>Ver evidências técnicas</summary>

![Oracle Prep](./docs/assets/01_infra_prep_oracle_env_automation.png)

![Kernel Tuning](./docs/assets/03_kernel_tuning_verification.png)

</details>

---

# 2. Automação e Infraestrutura como Código

## Docker — Containerização e Isolamento

Laboratório de isolamento de serviços e dependências utilizando containers e Docker Compose para integração entre Python e MongoDB.

<details>
<summary>Ver evidências técnicas</summary>

![Docker Auth](./docs/assets/mongo-docker-container-auth.png)

![Docker Compose](./docs/assets/lab-docker-compose-multi-service-python-mongo.png)

</details>

---

## Terraform — AWS Infrastructure as Code

Provisionamento declarativo de recursos AWS utilizando Terraform.

Durante o provisionamento, foi identificado o erro `InvalidParameterCombination`.

**Causa raiz:** Incompatibilidade entre a classe da instância solicitada e as restrições do ambiente AWS.

**Resolução:** Ajuste do `main.tf` e revalidação do plano antes da aplicação da infraestrutura.

<details>
<summary>Ver evidências técnicas</summary>

![Terraform Error](./docs/assets/error-aws-free-tier-validation.png)

![Terraform Plan](./docs/assets/05-terraform-plan-update.png)

![Terraform Apply](./docs/assets/06-terraform-apply-final.png)

</details>

---

## Ansible — Automação e Vault

Automação da configuração e hardening de servidores utilizando playbooks idempotentes.

Credenciais e informações sensíveis foram protegidas com Ansible Vault.

<details>
<summary>Ver evidências técnicas</summary>

![Ansible Ping](./docs/assets/ansible-conexao-sucesso.png)

![Vault](./docs/assets/ansible_hardening_vault_success.png)

![Audit](./docs/assets/ansible-final-audit-report-success.png)

</details>

---

# 3. Cloud-Native

## K3s — Kubernetes & Auto-Healing

Implementação de um cluster K3s com testes de recuperação automática de workloads.

Durante o deployment, ocorreu uma falha de permissões no sistema de arquivos.

**Investigação:** `lsattr` identificou que um arquivo possuía o atributo de imutabilidade `+i`.

**Resolução:** Remoção controlada do atributo com `chattr -i`, saneamento dos repositórios e conclusão da instalação.

<details>
<summary>Ver evidências técnicas</summary>

![Filesystem Investigation](./docs/assets/filesystem-lock-investigation.png)

![K3s Setup](./docs/assets/k8s-cluster-deployment-success.png)

![Auto Healing](./docs/assets/k8s-auto-healing-test.png)

</details>

---

# 4. Comunicação Corporativa

## Asterisk — SIP, URA & Gravação

Implementação de uma central telefônica IP com filas, URA interativa e gravação de chamadas.

Durante os testes, o serviço apresentou falha no boot e problemas relacionados ao DTMF.

A resolução envolveu a migração para gerenciamento nativo via Systemd e ajustes no `dtmf_mode` para RFC 2833.

<details>
<summary>Ver evidências técnicas</summary>

![Asterisk CLI](./docs/assets/asterisk_cli_installation_success.png)

![Asterisk Troubleshooting](./docs/assets/asterisk_troubleshooting_journalctl.png)

![Call Flow](./docs/assets/02_asterisk_fluxo_ura_monitoramento.png)

</details>

---

# 5. SRE Incident — OOM Killer

Durante os testes, serviços apresentaram encerramento súbito sem registros claros na aplicação.

A investigação foi realizada no ring buffer do kernel com `dmesg`, identificando a atuação do **OOM Killer**.

**Ação corretiva:** criação de um arquivo Swap emergencial de 8 GB sem reinicialização do sistema.

<details>
<summary>Ver evidências técnicas</summary>

![OOM Killer](./docs/assets/linux-kernel-log-oom-killer-hytale.png)

![Swap](./docs/assets/ubuntu-swap-resize-8gb-active.png)

</details>

---

## Principais Aprendizados

Este laboratório reúne implementações e incidentes que exigiram análise de logs, investigação de causa raiz, automação e recuperação de serviços.

Os principais temas trabalhados foram:

- Troubleshooting de serviços Linux
- SELinux e controle de acesso
- Bancos de dados relacionais e NoSQL
- Terraform e Ansible
- Containers e Kubernetes
- RBAC e persistência de dados
- Kernel tuning e análise do OOM Killer
- Recuperação e resiliência de serviços
