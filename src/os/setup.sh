#!/bin/bash

# Variables

GITHUB_REPOSITORY="reinanhs/dotfiles"
AUTHOR_REPOSITORY="Reinan Gabriel"

MINIMUM_MACOS_VERSION="10.10"
MINIMUM_UBUNTU_VERSION="20.04"

DIR_INSTALL="/home/reinan/.dotfiles"

# Color
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

init() {
    echo "Thanks for installing my repository $BIBlue$GITHUB_REPOSITORY$Color_Off"
    echo "Author: $BIBlue$AUTHOR_REPOSITORY$Color_Off"
    echo "Version: 1.0.0"
    echo "Supported systems: "
    echo " - Ubuntu 22.04"

    doctor_check

    echo "\nDo you really want to install the repository $BIBlue$GITHUB_REPOSITORY$Color_Off"
    read -p "Continue (y/n)?" choice
    case "$choice" in 
    y|Y ) install;;
    n|N ) echo "${Yellow}The installation was interrupted$Color_Off";;
    * )   echo "${Red}Invalid option$Color_Off";;
    esac
}

install() {
    cd ~
    git clone https://github.com/ReinanHS/dotfiles.git $DIR_INSTALL
    bash "$DIR_INSTALL/src/os/linux/install-packages.sh"
    bash "$DIR_INSTALL/install"
}

doctor_check() {
    echo "For you to perform the $BIYellow installation$Color_Off, you need to have the following components:"

    if [ ! -d "$DIR_INSTALL" ]; then
        echo "${Green}[✓] Installation directory ($DIR_INSTALL)$Color_Off"
    else
        echo "${Red}[x] Installation directory ( Need installation directory is empty)$Color_Off"
        echo "${Red}run: rm -rf $DIR_INSTALL  $Color_Off"
        exit 1 
    fi

    git --version 2>&1 >/dev/null
    GIT_IS_AVAILABLE=$?

    if [ $GIT_IS_AVAILABLE -eq 0 ]; then
        echo "${Green}[✓] Git (The git verification was successful)$Color_Off"
    else
        echo "${Red}[x] Git (To continue the installation, you must have git installed)$Color_Off"
        echo "${Red}run: sudo apt update && sudo apt install git $Color_Off"
        exit 1    
    fi

    python3 --version 2>&1 >/dev/null
    PYTHON_IS_AVAILABLE=$?

    if [ $PYTHON_IS_AVAILABLE -eq 0 ]; then
        echo "${Green}[✓] Python 3 (The python verification was successful)$Color_Off"
    else
        echo "${Red}[x] Python 3 (To continue the installation, you must have python 3 installed)$Color_Off"
        exit 1    
    fi

    info_system="$(cat /etc/issue | sed -e 's/\\l//g' | sed -e 's/\\n//g' | sed -e 's/  //g')"
    echo "${Yellow}[?] Operational system ($info_system)$Color_Off"
}

init