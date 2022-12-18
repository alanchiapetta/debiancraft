#!/bin/bash
#Alan Chiapetta

file_directory=$(dirname -- $(readlink -fn -- "$0"))

# Habilitar suporte ao Flatpak.
enable_flatpak(){ #OK
    
    echo "É recomendado reiniciar o computador depois de instalar estes pacotes."
    echo "Os serviços do Flatpak necessitam que a máquina seja reiniciada para funcionar corretamente!"
    sleep 1
    sudo apt install flatpak -y && sudo apt install --reinstall ca-certificates -y
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    echo
    echo "Flatpak instalado e habilitado."
    start_function
}


# Função responsável por instalar os programas flatpak.. 
# Será lido e instalado cada pacote linha por linha.
flatpak_packages(){
    
    echo "Essa opção instala os programas Flapak que está na lista."
    sleep 1
    while IFS= read -r line || [[ -n "$line" ]]; do
        sudo flatpak install -y "$line"
    done < "$flatpak_programs"
    echo
    echo "Programas em Flatpak instalados"
    start_function
}

# Função responsável por instalar os programas apt (Debian Sid).. 
# Será lido e instalado cada pacote linha por linha.
apt_packages(){ #OK

    echo "Essa opção instala os programas essenciais para funcionar adequadamente a personalização do Debiancraft."
    sleep 1
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
    start_function   
}

# Função responsável por instalar os programas essenciais que não estão nos repositórios.. 
extra_packages(){ 
    
    echo "Esses pacotes não estão nos repositórios do Debian Sid, mas são essenciais para o bom funcionamento do DebianCraft."
    echo "Você pode ver os programas no arquivo pacotes/pacotes-extra.txt"
    echo "Prepare um café. Pode ser que demore um pouco dependendo da sua conexão com a internet :)"
    sleep 1
    echo
    echo "Ksuperkey"
    sleep 1
    echo "Ksuperkey - Instalando dependências"
    sudo apt install git gcc make libx11-dev libxtst-dev pkg-config -y
    echo "Clonando repositórios de: github.com/hanschen/ksuperkey.git"
    git clone https://github.com/hanschen/ksuperkey.git
    cd ksuperkey
    echo "Ksuperkey Instalando pacotes"
    sudo make
    sudo make install
    cd ..
    rm -rf ksuperkey
    echo "Ksuperkey Instalado"
    sleep 1
	echo
    echo "i3lock-color"
    sleep 1
    echo "i3lock-color - Instalando dependências"
    sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev -y
    echo "Clonando repositórios de: https://github.com/Raymo111/i3lock-color.git"
    git clone https://github.com/Raymo111/i3lock-color.git
    cd i3lock-color
    chmod +x install-i3lock-color.sh
    sudo sh install-i3lock-color.sh
    cd ..
    sudo rm -rf i3lock-color
    echo "i3lock-color Instalado"
    sleep 1
    echo
    echo "Betterlockscreen - Instalando da fonte: github.com/betterlockscreen/betterlockscreen"
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
    sleep 1
    echo
    echo "Pywal (criador de temas desktop randomicos) - fonte: github.com/dylanaraps/pywal"
    sleep 1
    echo "Pywal - Instalando Dependências"
	sudo apt install python3.9 imagemagick feh nitrogen hsetroot python3-pip -y
	echo "Pywal - Instalando pacote"
	sudo pip3 install pywal
	echo "Pywal instalado"
    sleep 1
	echo
	echo "Ranger"
    sleep 1
	echo "Ranger - Instalando dependências"
	sudo python3-pip ueberzug -y
    sleep 1
	echo "Ranger - Instalando pacote"
	sudo pip3 install ranger-fm
	echo "Ranger instalado."
    sleep 1
	echo
	echo "Youtube Music (com adblock +plugins) - fonte: github.com/th-ch/youtube-music"
    sleep 1
	echo "Youtube Music - Instalando dependẽncias"
	sudo apt install gdebi wget -y
	echo "Youtube Music Instalando pacote"
	wget -v https://github.com/th-ch/youtube-music/releases/download/v1.18.0/youtube-music_1.18.0_amd64.deb -O youtube-music.deb
	sudo gdebi youtube-music.deb
	rm -v youtube-music.deb
	echo "Youtube Music Instalado"
    sleep 1
	echo
	echo "Todos os pacotes extras foram instalados"
    sleep 1
    start_function
}

# Copiar configurações do sistema.
copy_configs(){ 
    
    echo "Aqui serão copiados todos os arquivos de configuração necessários para o sistema funcionar de acordo"
    sleep 1
    echo "A copiar arquivos para $USER/home"
    sleep 1
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
    sleep 1
    echo
    echo "A copiar arquivos para /usr"
    sudo cp -rv $file_directory/raiz/usr/local/* /usr/local/
    sudo cp -rv $file_directory/raiz/usr/share/* /usr/share/
    echo "Arquivos de configuração copiados"
    sleep 1
    start_function
}

# Exibe as opções para o usuário. 
start_function(){
echo
echo "Selecione a opção desejada."
echo
echo "1  - APT - Pacotes gerais e essenciais do repositório Debian-Sid"
echo "2  - FLATPAK - Instalar e habilitar suporte ao Flatpak"
echo "3  - FLATPAK - Instalar programas Flatpak"
echo "4  - Extras - Pacotes essenciais para Debiancraft"
echo "5  - Copiar arquivos de configuração para o sistema (Faça por último)"
echo "6  - Sair do script" 
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
    
    6)	exit
    
  esac
done
}

start_function

