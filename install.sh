#!/bin/bash
#Alan Chiapetta

file_directory=$(dirname -- $(readlink -fn -- "$0"))

# Habilitar suporte ao Flatpak.
enable_flatpak(){ #OK
    
    echo "É recomendado reiniciar o computador depois de instalar estes pacotes."
    echo "Os serviços do Flatpak necessitam que a máquina seja reiniciada para funcionar corretamente!"
    sleep 8
    sudo apt install flatpak -y && sudo apt install --reinstall ca-certificates -y
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    echo
    sleep 2
    echo "Flatpak instalado e habilitado."
    start_function
}


# Função responsável por instalar os programas flatpak.. 
# Será lido e instalado cada pacote linha por linha.
flatpak_packages(){
    
    echo "Essa opção instala os programas Flapak que está na lista."
    sleep 2
    while IFS= read -r line || [[ -n "$line" ]]; do
        sudo flatpak install -y "$line"
    done < "$flatpak_programs"
    echo
    sleep 2
    echo "Programas em Flatpak instalados"
    start_function
}

# Função responsável por instalar os programas apt (Debian Sid).. 
# Será lido e instalado cada pacote linha por linha.
apt_packages(){ #OK

    echo "Essa opção instala os programas essenciais para funcionar adequadamente a personalização do Debiancraft."
    sleep 3
    sudo apt update
    sudo apt full-upgrade -y
    sudo apt remove apt-listbugs -y
    while IFS= read -r line || [[ -n "$line" ]]; do
        sudo apt install $line -y
    done < "$apt_programs"
    sudo apt autoremove -y
    sudo apt install apt-listbugs -y 
    xdg-user-dirs-update
    xdg-user-dirs-gtk-update   
    echo
    echo "Pacotes instalados"
    sleep 2
    start_function   
}

# Função responsável por instalar os programas essenciais que não estão nos repositórios.. 
extra_packages(){ 
    
    echo "Esses pacotes não estão nos repositórios do Debian Sid, mas são essenciais para o bom funcionamento do DebianCraft."
    echo "Você pode ver os programas no arquivo pacotes/pacotes-extra.txt"
    echo "Prepare um café. Pode ser que demore um pouco dependendo da sua conexão com a internet :)"
    sleep 8
    echo
    echo "Ksuperkey"
    sleep 3
    echo "Ksuperkey - Instalando dependências"
    sleep 2
    sudo apt install git gcc make libx11-dev libxtst-dev pkg-config -y
    echo "Clonando repositórios de: github.com/hanschen/ksuperkey.git"
    sleep 2
    git clone https://github.com/hanschen/ksuperkey.git
    cd ksuperkey
    echo "Ksuperkey Instalando pacotes"
    sleep 2
    sudo make
    sudo make install
    cd ..
    rm -rf ksuperkey
    echo "Ksuperkey Instalado"
    sleep 3
	echo
    echo "i3lock-color"
    sleep 3
    echo "i3lock-color - Instalando dependências"
    sleep 2
    sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev -y
    echo "Clonando repositórios de: https://github.com/Raymo111/i3lock-color.git"
    sleep 2
    git clone https://github.com/Raymo111/i3lock-color.git
    cd i3lock-color
    chmod +x install-i3lock-color.sh
    sudo sh install-i3lock-color.sh
    cd ..
    sudo rm -rf i3lock-color
    echo "i3lock-color Instalado"
    sleep 3
    echo
    echo "Betterlockscreen - Instalando da fonte: github.com/betterlockscreen/betterlockscreen"
    sleep 4
    wget https://github.com/betterlockscreen/betterlockscreen/archive/refs/heads/main.zip
    unzip main.zip
    cd betterlockscreen-main/
    chmod u+c betterlockscreen
    sudo cp betterlockscreen /usr/local/bin
    sudo cp system/betterlockscreen@.service /usr/lib/systemd/system/
    systemctl enable betterlockscreen@$USER
    cd ..
    rm -rf betterlockscreen-main
    rm -rf main.zip
    echo "Betterlockscreen Instalado"
    sleep 3
    echo
    echo "Pywal (criador de temas desktop randomicos) - fonte: github.com/dylanaraps/pywal"
    sleep 3
    echo "Pywal - Instalando Dependências"
    sleep 2
	sudo apt install python3.9 imagemagick feh nitrogen hsetroot python3-pip -y
	echo "Pywal - Instalando pacote"
	sleep 2
	sudo pip3 install pywal
	echo "Pywal instalado"
    sleep 3
	echo
	echo "Ranger"
    sleep 3
	echo "Ranger - Instalando dependências"
    sleep 2
	sudo python3-pip ueberzug -y
    echo
	echo "Ranger - Instalando pacote"
	sleep 2
	sudo pip3 install ranger-fm
	echo "Ranger instalado."
    sleep 3
	echo
	echo "Youtube Music (com adblock +plugins) - fonte: github.com/th-ch/youtube-music"
    sleep 2
	echo "Youtube Music - Instalando dependẽncias"
	slep 2
	sudo apt install gdebi wget -y
	echo "Youtube Music Instalando pacote"
	sleep 2
	wget -v https://github.com/th-ch/youtube-music/releases/download/v1.18.0/youtube-music_1.18.0_amd64.deb -O youtube-music.deb
	sudo gdebi youtube-music.deb
	rm -v youtube-music.deb
	echo "Youtube Music Instalado"
    sleep 3
	echo
	echo "Todos os pacotes extras foram instalados"
    sleep 2
    start_function
}

# Copiar configurações do sistema.
copy_configs(){ 
    
    echo "Aqui serão copiados todos os arquivos de configuração necessários para o sistema funcionar de acordo"
    sleep 5
    echo "A copiar arquivos para $USER/home"
    sleep 3
    xdg-user-dirs-update
    xdg-user-dirs-gtk-update
    mkdir -p ~/Music
    mkdir -p ~/.cache
    mkdir -p ~/.config
    mkdir -p ~/.icons
    mkdir -p ~/Imagens
    mkdir -p ~/Imagens/screenshots
    mkdir -p ~/.mpd
    mkdir -p ~/.ncmpcpp
    mkdir -p ~/.oh-my-zsh
    mkdir -p ~/.subversion
    mkdir -p ~/.vim_runtime
    cp -rv $file_directory/raiz/home/cache/* ~/.cache/
    cp -rv $file_directory/raiz/home/config/* ~/.config/
    cp -rv $file_directory/raiz/home/icons/* ~/.icons/
    cp -rv $file_directory/raiz/home/Imagens/* ~/Imagens/
    cp -rv $file_directory/raiz/home/mpd/* ~/.mpd/
    cp -rv $file_directory/raiz/home/Music/* ~/Music/
    cp -rv $file_directory/raiz/home/ncmpcpp/* ~/.ncmpcpp/
    cp -rv $file_directory/raiz/home/oh-my-zsh/* ~/.oh-my-zsh/
    cp -rv $file_directory/raiz/home/subversion/* ~/.subversion/
    cp -rv $file_directory/raiz/home/vim_runtime/* ~/.vim_runtime/
    cp -rv $file_directory/raiz/home/bashrc ~/.bashrc
    cp -rv $file_directory/raiz/home/face ~/.face
    cp -rv $file_directory/raiz/home/gtkrc-2.0 ~/.gtkrc-2.0
    cp -rv $file_directory/raiz/home/viminfo ~/.viminfo
    cp -rv $file_directory/raiz/home/vimrc ~/.vimrc
    cp -rv $file_directory/raiz/home/xinitrc ~/.xinitrc
    cp -rv $file_directory/raiz/home/zshrc ~/.zshrc
    sleep 3
    echo
    echo "A copiar arquivos para /usr"
    sleep 2
    sudo cp -rv $file_directory/raiz/usr/local/* /usr/local/
    sudo cp -rv $file_directory/raiz/usr/share/* /usr/share/
    echo "Arquivos de configuração copiados"
    sleep 3
    start_function
}

# Função reponsável por instalar o gerenciador de login LightDM
install_lightdm(){
    echo "A instalar o gerenciador de login LightDM"
    sleep 2
    sudo apt update
    sudo apt full-upgrade -y
    sudo apt install lightdm lightdm-gtk-greeter -y
    echo
    echo "Pacotes instalados"
    sleep 2
    echo
    echo "Ativando LightDM"
    sleep 2
    sudo systemctl enable lightdm
    echo
    echo "LightDM ativado"
    echo
    sleep 2
    echo "Reinicie o computador para efetivar as mudanças"
    sleep 5
    start_function
}


# Exibe as opções para o usuário. 
start_function(){
echo
echo "Selecione a opção desejada."
echo
echo "1  - APT - Pacotes gerais e essenciais do repositório Debian-Sid"
echo "2  - FLATPAK - Instalar e habilitar suporte ao Flatpak (opcional)"
echo "3  - FLATPAK - Instalar programas Flatpak (opcional)"
echo "4  - Extras - Pacotes essenciais para Debiancraft" 
echo "5  - Copiar arquivos de configuração para o sistema (Faça por último)"
echo "6  - Instalar gerenciador de login LightDM (opcional)"
echo "7  - Sair do script" 
echo

# Recebe a escolha do usuário e carregas os asquivos .txt
# Chama a função responsável por ler o arquivo .txt e interagirá linha por linha para instalar os pacotes.
while :
do
  read select_option
  case $select_option in
	
	1)	apt_programs="$file_directory/pacotes/pacotes-apt.txt"
        apt_packages;;
	
    2)  enable_flatpak;;

    3)  flatpak_programs="$file_directory/pacotes/pacotes-flatpak.txt"
        flatpak_packages;;
    
    4)	extra_packages;;
    
    5)  copy_configs;;

    6)   install_lightdm;;
    
    7)	exit
    
  esac
done
}

start_function

