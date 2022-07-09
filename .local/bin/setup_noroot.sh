#!/bin/bash

set -e

declare -rA COLORS=(
    [RED]=$'\033[0;31m'
    [GREEN]=$'\033[0;32m'
    [BLUE]=$'\033[0;34m'
    [PURPLE]=$'\033[0;35m'
    [CYAN]=$'\033[0;36m'
    [WHITE]=$'\033[0;37m'
    [YELLOW]=$'\033[0;33m'
    [BOLD]=$'\033[1m'
    [OFF]=$'\033[0m'
)

print_red () {
    echo -e "${COLORS[RED]}${1}${COLORS[OFF]}\n"
}

print_yellow () {
    echo -e "${COLORS[YELLOW]}${1}${COLORS[OFF]}\n"
    sleep 1
}

print_green () {
    echo -e "${COLORS[GREEN]}${1}${COLORS[OFF]}\n"
    sleep 1
}

print_cyan () {
    echo -e "${COLORS[CYAN]}${1}${COLORS[OFF]}\n"
}

function setup_git(){
    if [[ ! -f /usr/bin/git || ! -f /bin/git ]]; then
        print_red "git not found, you'll need sudo to 'apt install git'"
        exit 1
    fi
    
}

function setup_zsh(){
    if [[ ! -f /bin/zsh || ! -f /usr/bin/zsh ]]; then
        print_red "zsh not found! you'll need sudo to 'apt install' it"
        exit 1
    fi
}

function check_code(){
    if [[ ! -f /bin/code || ! -f /usr/bin/code ]]; then
        print_red "VSCode not found! you'll need sudo to 'apt install' it"
        exit 1
    fi
}

setup_env(){
    print_cyan "creating backup of zshrc and .config"
    
    mkdir -p $HOME/.dot-backup/.config-bckp
    [[ -f $HOME/.zshrc ]] &&
        print_cyan "moving old zshrc from HOME"
        mv $HOME/.zshrc $HOME/.dot-backup 
    [[ -d $HOME/.config ]] &&
        print_cyan "copying .config folder" 
        cp -r $HOME/.config $HOME/.dot-backup/.config-bckp 
    sleep 5
}

config(){ # alias used to make it easier to work with these files
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

main(){
    print_cyan "Hi $(whoami), how are you?"
    print_cyan "This script is meant to be used by users that can't sudo..."
    print_cyan "You need to have git installed and apt up to date..."
    print_cyan "Maybe run setup.sh first?"
    print_cyan "Let's check if you have git first..."
    setup_git &&
    print_green "git installed"
    print_cyan "now, checking if zsh is installed... "
    setup_zsh &&
    print_green "zsh installed"
    print_cyan "and let's check vscode now"
    check_code && 
    print_green "vscode installed... yayyyy"
    print_red "----------"
    print_red "This script WILL override some dotfiles and .config files, make sure you know what you're doing!!!\n\n\nyou have 20 secs to ^C and exit!!!"
    print_red "----------"
    sleep 20
    print_green "ok, continuing..."
    setup_env 
    print_cyan "ok, getting my config files"
    git clone --bare https://github.com/PedroMarquetti/cfg_files.git $HOME/.cfg 
    print_green "Done"
    config checkout 
    config config status.showUntrackedFiles no 
    [[ $SHELL != /bin/zsh ]] &&
        print_red "SHELL is not zsh... changing"
        chsh -s $(which zsh) $(whoami)
    /bin/zsh
}

main
