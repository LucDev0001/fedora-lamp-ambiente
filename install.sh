#!/bin/bash

# ==============================================================================
#  Instalador Automático de Ambiente de Desenvolvimento LAMP para Fedora
# ==============================================================================

# --- Verificação de Root ---
if [ "$EUID" -ne 0 ]; then
  echo "ERRO: Por favor, execute este script como root (usando sudo)."
  exit 1
fi

# --- Variáveis ---
# Pega o nome e o diretório home do usuário que chamou o sudo
ORIGINAL_USER=${SUDO_USER:-$(whoami)}
USER_HOME=$(getent passwd "$ORIGINAL_USER" | cut -d: -f6)

echo "======================================================"
echo "Iniciando a Instalação Automática do Ambiente DEV"
echo "Usuário detectado: $ORIGINAL_USER"
echo "Diretório Home: $USER_HOME"
echo "======================================================"
sleep 3

# --- Passo 1: Instalar Pacotes ---
echo ""
echo "--> Passo 1 de 5: Instalando pacotes necessários com DNF..."
dnf install -y httpd mariadb-server php php-mysqlnd php-gd php-cli php-json php-mbstring phpmyadmin zenity wget

# --- Passo 2: Configurar MariaDB ---
echo ""
echo "--> Passo 2 de 5: Habilitando e iniciando o serviço MariaDB..."
systemctl enable --now mariadb

# --- Passo 3: Instalar Scripts de Gerenciamento ---
echo ""
echo "--> Passo 3 de 5: Instalando scripts 'dev' e 'dev-launcher'..."
chmod +x dev dev-launcher preparar_ambiente.sh
cp dev /usr/local/bin/
cp dev-launcher /usr/local/bin/

# --- Passo 4: Configurar Permissões do Diretório Web ---
echo ""
echo "--> Passo 4 de 5: Executando script de preparação de permissões..."
# A variável SUDO_USER é usada dentro do script 'preparar_ambiente.sh'
./preparar_ambiente.sh

# --- Passo 5: Criar Lançador de Aplicativos ---
echo ""
echo "--> Passo 5 de 5: Criando o ícone no menu de aplicativos..."
ICON_DIR="$USER_HOME/.local/share/icons"
APPS_DIR="$USER_HOME/.local/share/applications"

mkdir -p "$ICON_DIR"
mkdir -p "$APPS_DIR"

wget -O "$ICON_DIR/dev-icon.png" https://i.imgur.com/g2y6MAJ.png

# Cria o arquivo .desktop
tee "$APPS_DIR/dev-ambiente.desktop" > /dev/null <<EOF
[Desktop Entry]
Version=1.0
Name=Ambiente DEV
Comment=Gerenciar servidor Apache e MariaDB
Exec=/usr/local/bin/dev-launcher
Icon=$USER_HOME/.local/share/icons/dev-icon.png
Terminal=false
Type=Application
Categories=Development;
EOF

# Garante que o usuário seja o dono dos arquivos criados em seu diretório home
chown -R "$ORIGINAL_USER":"$ORIGINAL_USER" "$USER_HOME/.local"

echo ""
echo "========================================================================"
echo "✅ Instalação Automática Concluída!"
echo ""
echo "FALTAM APENAS 2 PASSOS MANUAIS IMPORTANTES:"
echo ""
echo "1. CONFIGURE A SENHA DO BANCO DE DADOS:"
echo "   Execute o comando abaixo e siga as instruções:"
echo "   sudo mysql_secure_installation"
echo ""
echo "2. REINICIE SUA SESSÃO:"
echo "   Faça LOGOUT e LOGIN novamente para que as permissões de grupo"
echo "   tenham efeito e o ícone do menu de aplicativos apareça."
echo "========================================================================"

exit 0
