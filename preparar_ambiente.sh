#!/bin/bash

# --- Script de Preparação de Permissões para Ambiente de Desenvolvimento Apache ---
# --- Executar este script apenas UMA VEZ com sudo ---

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]
  then echo "ERRO: Por favor, execute este script como root (usando sudo)."
  exit
fi

# Variável com o seu usuário (dono da sessão atual)
CURRENT_USER=${SUDO_USER:-$(whoami)}

echo "Configurando permissões para o usuário: $CURRENT_USER"

# 1. Adiciona o usuário atual ao grupo 'apache'
echo "--> Adicionando usuário '$CURRENT_USER' ao grupo 'apache'..."
usermod -aG apache $CURRENT_USER

# 2. Muda o dono do diretório web para seu usuário e o grupo para 'apache'
echo "--> Alterando dono de /var/www/html para '$CURRENT_USER:apache'..."
chown -R $CURRENT_USER:apache /var/www/html

# 3. Ajusta as permissões de diretórios para 775 (dono e grupo podem escrever)
echo "--> Ajustando permissões de diretórios para 775..."
find /var/www/html -type d -exec chmod 775 {} \;

# 4. Ajusta as permissões de arquivos para 664 (dono e grupo podem escrever)
echo "--> Ajustando permissões de arquivos para 664..."
find /var/www/html -type f -exec chmod 664 {} \;

# 5. (Mágica Opcional) Garante que novos arquivos/pastas herdem o grupo 'apache'
echo "--> Configurando 'setgid' para herança de grupo em novos arquivos..."
chmod g+s /var/www/html

echo ""
echo "------------------------------------------------------------------"
echo "!!! IMPORTANTE !!!"
echo "Permissões configuradas com sucesso."
echo "Para que a mudança de grupo tenha efeito, você precisa"
echo "FAZER LOGOUT E LOGIN NOVAMENTE na sua sessão."
echo "------------------------------------------------------------------"
