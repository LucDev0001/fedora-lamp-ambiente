# Ambiente de Desenvolvimento LAMP para Fedora

Este repositório contém scripts e instruções para configurar um ambiente de desenvolvimento web completo (Apache, MariaDB, PHP) em uma instalação do Fedora Workstation.

O setup inclui um gerenciador de serviços, um lançador gráfico e configurações de permissões para facilitar o desenvolvimento.

## 1. Pré-requisitos (Instalação dos Pacotes)

Primeiro, instale todos os pacotes necessários usando o gerenciador `dnf`.

```bash
sudo dnf install httpd mariadb-server php php-mysqlnd php-gd php-cli php-json php-mbstring phpmyadmin zenity
