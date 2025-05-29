#!/bin/bash

# Script para automatizar tareas post-instalación de Debian 12 con GNOME
# Incluye un menú interactivo para instalación/desinstalación de tareas
# Requiere privilegios de sudo y conexión a internet

# Función para verificar si un paquete está instalado
check_package() {
    dpkg -l "$1" &> /dev/null
    return $?
}

# Función para mostrar progreso
print_progress() {
    echo -e "\033[1;32m[INFO]\033[0m $1"
}

# Función para mostrar errores
print_error() {
    echo -e "\033[1;31m[ERROR]\033[0m $1"
}

# Función para instalar paquetes con validación
install_package() {
    local package=$1
    local description=$2
    if ! check_package "$package"; then
        print_progress "Instalando $description..."
        sudo apt install -y "$package" || { print_error "Fallo al instalar $description"; return 1; }
    else
        print_progress "$description ya está instalado."
    fi
}

# Función para desinstalar paquetes
uninstall_package() {
    local package=$1
    local description=$2
    if check_package "$package"; then
        print_progress "Desinstalando $description..."
        sudo apt remove -y "$package" && sudo apt autoremove -y || { print_error "Fallo al desinstalar $description"; return 1; }
    else
        print_progress "$description no está instalado."
    fi
}

# Función para mostrar el menú
show_menu() {
    clear
    echo "=== Script de Post-Instalación para Debian 12 con GNOME ==="
    echo "Selecciona una opción:"
    echo "1. Actualizar el sistema"
    echo "2. Habilitar repositorios contrib y non-free"
    echo "3. Instalar actualizaciones de firmware"
    echo "4. Instalar GNOME Tweaks"
    echo "5. Instalar extensiones de GNOME Shell"
    echo "6. Instalar Dash to Dock"
    echo "7. Habilitar Luz Nocturna (manual)"
    echo "8. Instalar códecs multimedia"
    echo "9. Instalar navegadores web"
    echo "10. Configurar cortafuegos (UFW)"
    echo "11. Instalar Synaptic Package Manager"
    echo "12. Instalar herramienta de respaldo (Déjà Dup)"
    echo "13. Optimizar ajustes de energía (manual)"
    echo "14. Instalar controladores adicionales (manual)"
    echo "15. Configurar sincronización de archivos (manual)"
    echo "16. Instalar software de productividad"
    echo "17. Configurar SSH"
    echo "18. Configurar VPN (OpenVPN)"
    echo "19. Personalizar tema de GNOME (manual)"
    echo "20. Limpiar paquetes no utilizados"
    echo "21. Instalar herramientas de monitoreo"
    echo "22. Instalar herramientas de compresión"
    echo "23. Instalar reproductor multimedia (VLC)"
    echo "24. Habilitar Flatpak"
    echo "25. Instalar fuentes Microsoft"
    echo "26. Actualizar .bashrc"
    echo "27. Ejecutar todas las tareas de instalación"
    echo "28. Desinstalar una tarea específica"
    echo "29. Salir"
    echo -n "Ingresa tu elección [1-29]: "
}

# Función para ejecutar todas las tareas
run_all_tasks() {
    print_progress "Iniciando la ejecución de todas las tareas de instalación..."
    for i in {1..26}; do
        print_progress "Ejecutando tarea $i..."
        run_task "$i" "install" || print_error "Error al ejecutar la tarea $i, continuando con la siguiente."
    done
    print_progress "Todas las tareas de instalación han sido procesadas."
}

# Función para ejecutar/desinstalar tareas individuales
run_task() {
    local task=$1
    local mode=$2
    case $task in
        1)
            if [ "$mode" = "install" ]; then
                print_progress "Actualizando el sistema..."
                sudo apt update && sudo apt full-upgrade -y || { print_error "Fallo al actualizar el sistema"; return 1; }
            else
                print_progress "No se puede desinstalar la actualización del sistema."
            fi
            ;;
        2)
            if [ "$mode" = "install" ]; then
                print_progress "Habilitando repositorios contrib y non-free..."
                if ! grep -q "contrib non-free" /etc/apt/sources.list; then
                    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
                    sudo sed -i 's/main/main contrib non-free/' /etc/apt/sources.list
                    sudo apt update || { print_error "Fallo al actualizar tras modificar repositorios"; return 1; }
                else
                    print_progress "Repositorios contrib y non-free ya habilitados."
                fi
            else
                print_progress "Restaurando repositorios originales..."
                if [ -f /etc/apt/sources.list.bak ]; then
                    sudo mv /etc/apt/sources.list.bak /etc/apt/sources.list
                    sudo apt update || { print_error "Fallo al restaurar repositorios"; return 1; }
                else
                    print_progress "No se encontró respaldo de sources.list."
                fi
            fi
            ;;
        3)
            if [ "$mode" = "install" ]; then
                install_package "firmware-linux firmware-linux-nonfree" "actualizaciones de firmware"
            else
                uninstall_package "firmware-linux firmware-linux-nonfree" "actualizaciones de firmware"
            fi
            ;;
        4)
            if [ "$mode" = "install" ]; then
                install_package "gnome-tweaks" "GNOME Tweaks"
            else
                uninstall_package "gnome-tweaks" "GNOME Tweaks"
            fi
            ;;
        5)
            if [ "$mode" = "install" ]; then
                install_package "gnome-shell-extensions" "extensiones de GNOME Shell"
                print_progress "Instala manualmente la extensión del navegador para extensions.gnome.org."
            else
                uninstall_package "gnome-shell-extensions" "extensiones de GNOME Shell"
            fi
            ;;
        6)
            if [ "$mode" = "install" ]; then
                if ! gnome-extensions list | grep -q "dash-to-dock"; then
                    install_package "gnome-shell-extension-dashtodock" "Dash to Dock"
                    gnome-extensions enable dash-to-dock@micxgx.gmail.com
                else
                    print_progress "Dash to Dock ya está instalado."
                fi
            else
                if gnome-extensions list | grep -q "dash-to-dock"; then
                    gnome-extensions disable dash-to-dock@micxgx.gmail.com
                    uninstall_package "gnome-shell-extension-dashtodock" "Dash to Dock"
                else
                    print_progress "Dash to Dock no está instalado."
                fi
            fi
            ;;
        7)
            if [ "$mode" = "install" ]; then
                print_progress "Habilita Luz Nocturna manualmente en Configuración de GNOME > Pantallas > Luz Nocturna."
            else
                print_progress "Deshabilita Luz Nocturna manualmente en Configuración de GNOME > Pantallas > Luz Nocturna."
            fi
            ;;
        8)
            if [ "$mode" = "install" ]; then
                install_package "gstreamer1.0-libav gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly" "códecs multimedia"
            else
                uninstall_package "gstreamer1.0-libav gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly" "códecs multimedia"
            fi
            ;;
        9)
            if [ "$mode" = "install" ]; then
                print_progress "Instalando navegadores web..."
                install_package "firefox-esr" "Firefox ESR"
                install_package "chromium" "Chromium"
                if ! check_package "google-chrome-stable"; then
                    print_progress "Instalando Google Chrome..."
                    wget -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
                    sudo apt install -y /tmp/google-chrome.deb || { print_error "Fallo al instalar Google Chrome"; return 1; }
                    rm /tmp/google-chrome.deb
                else
                    print_progress "Google Chrome ya está instalado."
                fi
                if ! check_package "mullvad-browser"; then
                    print_progress "Instalando Mullvad Browser..."
                    wget -O /tmp/mullvad-browser.deb https://mullvad.net/media/mullvad-browser/mullvad-browser-12.5.7_amd64.deb
                    sudo apt install -y /tmp/mullvad-browser.deb || { print_error "Fallo al instalar Mullvad Browser"; return 1; }
                    rm /tmp/mullvad-browser.deb
                else
                    print_progress "Mullvad Browser ya está instalado."
                fi
                print_progress "Tor Browser requiere instalación manual desde https://www.torproject.org/download/"
                install_package "epiphany-browser" "Epiphany (GNOME Web)"
                install_package "midori" "Midori"
                install_package "falkon" "Falkon"
                install_package "qutebrowser" "Qutebrowser"
                install_package "surf" "Surf"
                install_package "lynx" "Lynx"
            else
                print_progress "Desinstalando navegadores web..."
                uninstall_package "firefox-esr" "Firefox ESR"
                uninstall_package "chromium" "Chromium"
                uninstall_package "google-chrome-stable" "Google Chrome"
                uninstall_package "mullvad-browser" "Mullvad Browser"
                print_progress "Desinstala Tor Browser manualmente si está instalado."
                uninstall_package "epiphany-browser" "Epiphany (GNOME Web)"
                uninstall_package "midori" "Midori"
                uninstall_package "falkon" "Falkon"
                uninstall_package "qutebrowser" "Qutebrowser"
                uninstall_package "surf" "Surf"
                uninstall_package "lynx" "Lynx"
            fi
            ;;
        10)
            if [ "$mode" = "install" ]; then
                if ! check_package "ufw"; then
                    print_progress "Configurando cortafuegos UFW..."
                    sudo apt install -y ufw && sudo ufw enable || { print_error "Fallo al configurar UFW"; return 1; }
                else
                    print_progress "UFW ya está instalado y habilitado."
                fi
            else
                if check_package "ufw"; then
                    print_progress "Deshabilitando y desinstalando UFW..."
                    sudo ufw disable
                    uninstall_package "ufw" "UFW"
                else
                    print_progress "UFW no está instalado."
                fi
            fi
            ;;
        11)
            if [ "$mode" = "install" ]; then
                install_package "synaptic" "Synaptic Package Manager"
            else
                uninstall_package "synaptic" "Synaptic Package Manager"
            fi
            ;;
        12)
            if [ "$mode" = "install" ]; then
                install_package "deja-dup" "Déjà Dup"
            else
                uninstall_package "deja-dup" "Déjà Dup"
            fi
            ;;
        13)
            if [ "$mode" = "install" ]; then
                print_progress "Optimiza los ajustes de energía manualmente en Configuración de GNOME > Energía."
            else
                print_progress "Restaura los ajustes de energía manualmente en Configuración de GNOME > Energía."
            fi
            ;;
        14)
            if [ "$mode" = "install" ]; then
                print_progress "Verifica controladores propietarios (e.g., NVIDIA, AMD) en Software de GNOME o ejecuta 'sudo apt install nvidia-driver' si es necesario."
            else
                print_progress "Desinstala controladores propietarios manualmente si están instalados."
            fi
            ;;
        15)
            if [ "$mode" = "install" ]; then
                print_progress "Instala Nextcloud o Dropbox manualmente desde sus paquetes .deb oficiales."
            else
                print_progress "Desinstala Nextcloud o Dropbox manualmente si están instalados."
            fi
            ;;
        16)
            if [ "$mode" = "install" ]; then
                install_package "libreoffice gimp" "LibreOffice y GIMP"
            else
                uninstall_package "libreoffice gimp" "LibreOffice y GIMP"
            fi
            ;;
        17)
            if [ "$mode" = "install" ]; then
                if ! check_package "openssh-server"; then
                    print_progress "Configurando SSH..."
                    sudo apt install -y openssh-server && sudo systemctl enable ssh || { print_error "Fallo al configurar SSH"; return 1; }
                else
                    print_progress "Servidor SSH ya instalado."
                fi
            else
                if check_package "openssh-server"; then
                    print_progress "Deshabilitando y desinstalando SSH..."
                    sudo systemctl disable ssh
                    uninstall_package "openssh-server" "SSH"
                else
                    print_progress "SSH no está instalado."
                fi
            fi
            ;;
        18)
            if [ "$mode" = "install" ]; then
                install_package "openvpn network-manager-openvpn-gnome" "OpenVPN"
            else
                uninstall_package "openvpn network-manager-openvpn-gnome" "OpenVPN"
            fi
            ;;
        19)
            if [ "$mode" = "install" ]; then
                print_progress "Personaliza el tema de GNOME manualmente en GNOME Tweaks > Apariencia."
            else
                print_progress "Restaura el tema predeterminado de GNOME manualmente en GNOME Tweaks > Apariencia."
            fi
            ;;
        20)
            if [ "$mode" = "install" ]; then
                print_progress "Limpiando paquetes no utilizados..."
                sudo apt autoremove -y && sudo apt autoclean || { print_error "Fallo al limpiar paquetes"; return 1; }
            else
                print_progress "No se puede deshacer la limpieza de paquetes."
            fi
            ;;
        21)
            if [ "$mode" = "install" ]; then
                install_package "htop gnome-system-monitor" "herramientas de monitoreo"
            else
                uninstall_package "htop gnome-system-monitor" "herramientas de monitoreo"
            fi
            ;;
        22)
            if [ "$mode" = "install" ]; then
                install_package "unrar p7zip-full" "herramientas de compresión"
            else
                uninstall_package "unrar p7zip-full" "herramientas de compresión"
            fi
            ;;
        23)
            if [ "$mode" = "install" ]; then
                install_package "vlc" "VLC"
            else
                uninstall_package "vlc" "VLC"
            fi
            ;;
        24)
            if [ "$mode" = "install" ]; then
                if ! check_package "flatpak"; then
                    print_progress "Habilitando Flatpak..."
                    sudo apt install -y flatpak
                    flatpak install -y flathub org.spotify.Client || { print_error "Fallo al instalar Flatpak o Spotify"; return 1; }
                else
                    print_progress "Flatpak ya está instalado."
                fi
            else
                if check_package "flatpak"; then
                    print_progress "Desinstalando Flatpak y Spotify..."
                    flatpak uninstall -y org.spotify.Client
                    uninstall_package "flatpak" "Flatpak"
                else
                    print_progress "Flatpak no está instalado."
                fi
            fi
            ;;
        25)
            if [ "$mode" = "install" ]; then
                install_package "ttf-mscorefonts-installer" "fuentes Microsoft"
            else
                uninstall_package "ttf-mscorefonts-installer" "fuentes Microsoft"
            fi
            ;;
        26)
            if [ "$mode" = "install" ]; then
                print_progress "Actualizando .bashrc..."
                cp ~/.bashrc ~/.bashrc.bak
                cat >> ~/.bashrc << 'EOF'
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    prompt_color='\[\033[;32m\]'
    info_color='\[\033[1;34m\]'
    prompt_symbol=㉿
    if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
        prompt_color='\[\033[;94m\]'
        info_color='\[\033[1;31m\]'
        # Skull emoji for root terminal
        #prompt_symbol=💀
    fi
    case "$PROMPT_ALTERNATIVE" in
        twoline)
            PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}('$info_color'\u'$prompt_symbol'\h'$prompt_color')-[\[\033[0;1m\]\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$\[\033[0m\] ';;
        oneline)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}'$info_color'\u@\h\[\033[00m\]:'$prompt_color'\[\033[01m\]\w\[\033[00m\]\$ ';;
        backtrack)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ';;
    esac
    unset prompt_color
    unset info_color
    unset prompt_symbol
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

[ "$NEWLINE_BEFORE_PROMPT" = yes ] && PROMPT_COMMAND="PROMPT_COMMAND=echo"

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF
            else
                print_progress "Restaurando .bashrc..."
                if [ -f ~/.bashrc.bak ]; then
                    mv ~/.bashrc.bak ~/.bashrc
                else
                    print_progress "No se encontró respaldo de .bashrc."
                fi
            fi
            ;;
    esac
}

# Bucle principal del menú
while true; do
    show_menu
    read -r choice
    case $choice in
        1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26)
            run_task "$choice" "install"
            ;;
        27)
            run_all_tasks
            ;;
        28)
            echo -n "Ingresa el número de la tarea a desinstalar [1-26]: "
            read -r uninstall_choice
            if [[ "$uninstall_choice" =~ ^[0-9]+$ ]] && [ "$uninstall_choice" -ge 1 ] && [ "$uninstall_choice" -le 26 ]; then
                run_task "$uninstall_choice" "uninstall"
            else
                print_error "Opción inválida para desinstalación."
            fi
            ;;
        29)
            print_progress "Saliendo del script."
            exit 0
            ;;
        *)
            print_error "Por favor, ingresa un número entre 1 y 29."
            ;;
    esac
    echo -n "Presiona Enter para continuar..."
    read -r
done