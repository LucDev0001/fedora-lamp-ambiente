
4.  **Copie os scripts que fizemos para esta pasta:**
    Nós criamos três scripts principais. Vamos copiá-los para o seu novo diretório de projeto.

    ```bash
    # Script de gerenciamento (start/stop/status)
    cp /usr/local/bin/dev ./

    # Script do lançador gráfico (que o ícone usa)
    cp /usr/local/bin/dev-launcher ./

    # Script de preparação de permissões (que rodamos uma vez)
    cp ~/Documentos/preparar_ambiente.sh ./ 
    ```

    *(Estou assumindo que o `preparar_ambiente.sh` ainda está na sua pasta Documentos. Se estiver em outro lugar, ajuste o caminho).*

-----

### Passo 3: Escrever o Arquivo `README.md`

Este é o manual de instruções do seu projeto. Abra o arquivo `README.md` que está na sua pasta `fedora-lamp-ambiente` com o VS Code ou outro editor.

Apague o conteúdo padrão e **cole o texto abaixo**. Ele contém todas as instruções baseadas no que fizemos.

````markdown
# Ambiente de Desenvolvimento LAMP para Fedora

Este repositório contém scripts e instruções para configurar um ambiente de desenvolvimento web completo (Apache, MariaDB, PHP) em uma instalação do Fedora Workstation.

O setup inclui um gerenciador de serviços, um lançador gráfico e configurações de permissões para facilitar o desenvolvimento.

## 1. Pré-requisitos (Instalação dos Pacotes)

Primeiro, instale todos os pacotes necessários usando o gerenciador `dnf`.

```bash
sudo dnf install httpd mariadb-server php php-mysqlnd php-gd php-cli php-json php-mbstring phpmyadmin zenity
````

## 2\. Configuração Inicial do Banco de Dados

Após instalar os pacotes, é crucial configurar e proteger o servidor MariaDB.

1.  Inicie o serviço MariaDB:
    ```bash
    sudo systemctl enable --now mariadb
    ```
2.  Execute o script de instalação segura para definir a senha do usuário `root` do banco de dados:
    ```bash
    sudo mysql_secure_installation
    ```

## 3\. Instalação dos Scripts

Os scripts deste repositório automatizam o gerenciamento do ambiente.

1.  **Torne os scripts executáveis:**

    ```bash
    chmod +x dev dev-launcher preparar_ambiente.sh
    ```

2.  **Copie os scripts de gerenciamento para o seu PATH:**

    ```bash
    sudo cp dev /usr/local/bin/
    sudo cp dev-launcher /usr/local/bin/
    ```

3.  **Execute o script de preparação de permissões (APENAS UMA VEZ):**
    Este script configura as permissões da pasta `/var/www/html` para que você possa editar arquivos sem precisar de `sudo` constantemente.

    ```bash
    sudo ./preparar_ambiente.sh
    ```

    **IMPORTANTE:** Após executar, você precisa **fazer logout e login novamente** na sua sessão para que as mudanças de grupo tenham efeito.

## 4\. Configuração do Lançador Gráfico (Ícone no Menu)

Para ter um ícone no menu de aplicativos, siga estes passos:

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

    **Atenção:** Substitua `SEU_USUARIO` pelo seu nome de usuário.

## Como Usar

### Pelo Terminal

  - **Iniciar:** `sudo dev start`
  - **Parar:** `sudo dev stop`
  - **Ver Status:** `sudo dev status`

### Pela Interface Gráfica

  - Procure por **"Ambiente DEV"** no seu menu de aplicativos e clique para abrir o menu de gerenciamento.

## Acesso

  - **Servidor Web:** `http://localhost`
  - **phpMyAdmin:** `http://localhost/phpmyadmin`
  - **Pasta de Projetos:** `/var/www/html/`

<!-- end list -->

````
