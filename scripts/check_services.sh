#!/bin/bash

echo "🔍 Verificando status dos serviços..."

# Verifica o Samba
if systemctl is-active --quiet smb; then
    echo "✅ Samba (SMB): Ativo"
else
    echo "❌ Samba (SMB): Parado"
fi

# Verifica o Firewall (Porta 445 do Samba)
if sudo firewall-cmd --list-services | grep -q "samba"; then
    echo "✅ Firewall: Porta Samba aberta"
else
    echo "❌ Firewall: Porta Samba fechada"
fi
