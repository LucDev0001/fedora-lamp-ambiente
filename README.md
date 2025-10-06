

````markdown
# Ambiente de Desenvolvimento LAMP para Fedora

Este repositório contém scripts e instruções para configurar um ambiente de desenvolvimento web completo (Apache, MariaDB, PHP) em uma instalação do Fedora Workstation.

O setup inclui um gerenciador de serviços, um lançador gráfico e configurações de permissões para facilitar o desenvolvimento diário.

## Como Instalar

Siga estes passos em ordem para configurar todo o ambiente a partir de uma instalação limpa do Fedora.

### Passo 1: Instalar os Pacotes (Pré-requisitos)

Primeiro, instale todos os pacotes necessários a partir dos repositórios oficiais do Fedora usando o gerenciador `dnf`.

```bash
sudo dnf install httpd mariadb-server php php-mysqlnd php-gd php-cli php-json php-mbstring phpmyadmin zenity
````

### Passo 2: Configurar o Banco de Dados

Após instalar os pacotes, é crucial configurar e proteger o servidor MariaDB.

1.  Inicie e habilite o serviço MariaDB para iniciar com o sistema:
    ```bash
    sudo systemctl enable --now mariadb
    ```
2.  Execute o script de instalação segura para definir a senha do usuário `root` do banco de dados e aplicar configurações de segurança recomendadas:
    ```bash
    sudo mysql_secure_installation
    ```

### Passo 3: Configurar os Scripts de Gerenciamento

Os scripts deste repositório automatizam o gerenciamento do ambiente.

1.  **Torne os scripts deste repositório executáveis:**

    ```bash
    chmod +x dev dev-launcher preparar_ambiente.sh
    ```

2.  **Copie os scripts de gerenciamento para um diretório do seu PATH**, para que possam ser chamados de qualquer lugar no terminal:

    ```bash
    sudo cp dev /usr/local/bin/
    sudo cp dev-launcher /usr/local/bin/
    ```

3.  **Execute o script de preparação de permissões (APENAS UMA VEZ):**
    Este script configura as permissões da pasta `/var/www/html` para que você possa criar e editar arquivos sem precisar de `sudo` constantemente.

    ```bash
    sudo ./preparar_ambiente.sh
    ```

    **IMPORTANTE:** Após executar, você precisa **fazer logout e login novamente** na sua sessão para que as mudanças de grupo tenham efeito.

### Passo 4: Configurar o Lançador Gráfico (Ícone no Menu)

Para ter um ícone no menu de aplicativos e gerenciar o ambiente de forma gráfica:

1.  **Baixe um ícone (opcional):**

    ```bash
    mkdir -p ~/.local/share/icons
    wget -O ~/.local/share/icons/dev-icon.png [https://i.imgur.com/g2y6MAJ.png](https://i.imgur.com/g2y6MAJ.png)
    ```

2.  **Crie o arquivo `.desktop`:**
    Crie o arquivo `~/.local/share/applications/dev-ambiente.desktop` com o seguinte conteúdo:

    ```ini
    [Desktop Entry]
    Version=1.0
    Name=Ambiente DEV
    Comment=Gerenciar servidor Apache e MariaDB
    Exec=/usr/local/bin/dev-launcher
    Icon=/home/SEU_USUARIO/.local/share/icons/dev-icon.png
    Terminal=false
    Type=Application
    Categories=Development;
    ```

    **Atenção:** Na linha `Icon=`, substitua `SEU_USUARIO` pelo seu nome de usuário.

## Como Usar

Depois de tudo instalado e configurado, você pode gerenciar seu ambiente das seguintes formas:

### Pelo Terminal

  - **Iniciar serviços:** `sudo dev start`
  - **Parar serviços:** `sudo dev stop`
  - **Ver Status:** `sudo dev status`

### Pela Interface Gráfica

  - Procure por **"Ambiente DEV"** no seu menu de aplicativos e clique para abrir o menu de gerenciamento.

## Informações de Acesso

  - **Servidor Web:** `http://localhost`
  - **Gerenciador de Banco de Dados:** `http://localhost/phpmyadmin`
  - **Pasta Raiz para Projetos:** `/var/www/html/`

<!-- end list -->

```
```