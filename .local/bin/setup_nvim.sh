!#/bin/bash

# setting XDG vars
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

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

print_red() {
    echo -e "${COLORS[RED]}${1}${COLORS[OFF]}\n"
    sleep 2
}

print_yellow () {
    echo -e "${COLORS[YELLOW]}${1}${COLORS[OFF]}\n";
}

print_green() {
    echo -e "${COLORS[GREEN]}${1}${COLORS[OFF]}\n";
}

print_cyan() {
    echo -e "${COLORS[CYAN]}${1}${COLORS[OFF]}\n";
}

print_cyan "Checking if Neovim is installed"
if [[ ! -f /usr/bin/nvim ]]; then
    print_cyan "nvim not found on /usr/bin/..."
    
    sudo curl -o /usr/bin/nvim -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage &&
    sudo chmod a+x /usr/bin/nvim
    print_green "done!"
fi

print_cyan "Cloning my configs..."
git clone https://github.com/pedromarquetti/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
print_green "Cloned! running nvim..."

nvim






