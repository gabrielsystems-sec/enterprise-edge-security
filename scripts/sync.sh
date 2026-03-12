#!/bin/bash

# Script para automatizar o workflow do Git
echo "🚀 Iniciando sincronização com o GitHub..."

# Adiciona todas as mudanças
git add .

# Pede a mensagem do commit
echo "📝 Digite a mensagem do commit:"
read message

# Commita com a mensagem lida
git commit -m "$message"

# Envia para o repositório remoto
git push origin main

echo "✅ Sincronização concluída com sucesso!"
