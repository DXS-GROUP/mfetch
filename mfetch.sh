#!/bin/bash

CPU=""
RAM=""
GPU=""
OS=""
DISK=""
SHELL_ICO=""
WM=""
UPTIME=""
KERNEL=""
USER=""
HELP=""
PKGS=""
IP_ICO=""
RESOL_ICO=""
MUSIC=""


RESET="\e[0m"
BLACK="\e[1;30m"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
MAGENTA="\e[1;35m"
CYAN="\e[1;36m"
WHITE="\e[1;37m"

RESET_BG="\e[7;0m"
BLACK_BG="\e[7;30m"
RED_BG="\e[7;31m"
GREEN_BG="\e[7;32m"
YELLOW_BG="\e[7;33m"
BLUE_BG="\e[7;34m"
MAGENTA_BG="\e[7;35m"
CYAN_BG="\e[7;36m"
WHITE_BG="\e[7;37m"

show_labels=false

clear

function get_terminal_size() {
    local width
    local height
    width=$(tput cols)
    height=$(tput lines)
    echo "$width $height"
}

function center_text() {
    text=$@

    cols=`tput cols`

    IFS=$'\n'$'\r'
    for line in $(echo -e $text); do

        line_length=`echo $line | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | wc -c`
        half_of_line_length=`expr $line_length / 2`
        is_odd=`expr $line_length % 2 == 1`
        half_of_line_length=`expr $half_of_line_length + $is_odd`
        center=`expr \( $cols / 2 \) - $half_of_line_length`

        spaces=""
        for ((i=0; i < $center; i++)) {
            spaces+=" "
        }
        printf "${spaces}${line}"
        echo

    done
}

function vertical_center_text() {
    text=$@

    rows=`tput lines`

    text_length=`echo -e $text | wc -l`
    half_of_text_length=`expr $text_length / 6`

    center=`expr \( $rows / 6 \) - $half_of_text_length`

    lines=""

    for ((i=0; i < $center; i++)) {
        lines+="\n"
    }

    echo -e "$lines$text$lines"
}

vertical_center_text

function ascii_art() {
    os_name="$(lsb_release -d | cut -f2)"

    case "$os_name" in
        "openSUSE Linux" | "openSUSE Tumbleweed" | "openSUSE")
            center_text "${GREEN_BG}                ${RESET_BG}"
            center_text "${GREEN_BG}      ,___      ${RESET_BG}"
            center_text "${GREEN_BG}    _| () \     ${RESET_BG}"
            center_text "${GREEN_BG}   /    --'     ${RESET_BG}"
            center_text "${GREEN_BG}   \ ___^/      ${RESET_BG}"
            center_text "${GREEN_BG}                ${RESET_BG}";;
        "Arch Linux")
            center_text "${CYAN_BG}                ${RESET_BG}"
            center_text "${CYAN_BG}                ${RESET_BG}"
            center_text "${CYAN_BG}       /\       ${RESET_BG}"
            center_text "${CYAN_BG}      /  \      ${RESET_BG}"
            center_text "${CYAN_BG}     /_/\_\     ${RESET_BG}"
            center_text "${CYAN_BG}                ${RESET_BG}";;
        "Alpine Linux")
            center_text "${BLUE_BG}                ${RESET_BG}"
            center_text "${BLUE_BG}                ${RESET_BG}"
            center_text "${BLUE_BG}      /\        ${RESET_BG}"
            center_text "${BLUE_BG}     // \/\     ${RESET_BG}"
            center_text "${BLUE_BG}    //   \ \    ${RESET_BG}"
            center_text "${BLUE_BG}                ${RESET_BG}";;
        "Bedrock Linux")
            center_text "${WHITE_BG}                ${RESET_BG}"
            center_text "${WHITE_BG}    __          ${RESET_BG}"
            center_text "${WHITE_BG}    \ \___      ${RESET_BG}"
            center_text "${WHITE_BG}     \  _ \     ${RESET_BG}"
            center_text "${WHITE_BG}      \___/     ${RESET_BG}"
            center_text "${WHITE_BG}                ${RESET_BG}";;
        "Debian Linux")
            center_text "${RED_BG}                ${RESET_BG}"
            center_text "${RED_BG}        __      ${RESET_BG}"
            center_text "${RED_BG}     '/  .\'    ${RESET_BG}"
            center_text "${RED_BG}     |  (_'     ${RESET_BG}"
            center_text "${RED_BG}      \         ${RESET_BG}"
            center_text "${RED_BG}                ${RESET_BG}";;
        "Endeavouros Linux")
            center_text "${MAGENTA_BG}                ${RESET_BG}"
            center_text "${MAGENTA_BG}        __      ${RESET_BG}"
            center_text "${MAGENTA_BG}       /  \     ${RESET_BG}"
            center_text "${MAGENTA_BG}     /     |    ${RESET_BG}"
            center_text "${MAGENTA_BG}    '_____/     ${RESET_BG}"
            center_text "${MAGENTA_BG}                ${RESET_BG}";;
        "Manjaro Linux")
            center_text "${GREEN_BG}                ${RESET_BG}"
            center_text "${GREEN_BG}    ,___,,_,    ${RESET_BG}"
            center_text "${GREEN_BG}    | ,_|| |    ${RESET_BG}"
            center_text "${GREEN_BG}    | |  | |    ${RESET_BG}"
            center_text "${GREEN_BG}    |_|__|_|    ${RESET_BG}"
            center_text "${GREEN_BG}                ${RESET_BG}";;
        "Ubuntu Linux")
            center_text "${RED_BG}                ${RESET_BG}"
            center_text "${RED_BG}       __       ${RESET_BG}"
            center_text "${RED_BG}    () -- ()    ${RESET_BG}"
            center_text "${RED_BG}    | |  | |    ${RESET_BG}"
            center_text "${RED_BG}     \ -- /     ${RESET_BG}"
            center_text "${RED_BG}       ''       ${RESET_BG}";;
        "MacOS Big Sur" | "MacOS Monterey" | "MacOS catalina" | "macOS high-sierra" | "macOS Mojave" | "macOS mountain lion" | "macOS mojave" | "macOS big sur" | "macOS catalina" | "macOS mojave" | "macOS yosemite")
            center_text "${GREEN_BG}                ${RESET_BG}"
            center_text "${GREEN_BG}     _//_      ${RESET_BG}"
            center_text "${GREEN_BG}   /  '' \     ${RESET_BG}"
            center_text "${GREEN_BG}   |    (      ${RESET_BG}"
            center_text "${GREEN_BG}    \____/     ${RESET_BG}"
            center_text "${GREEN_BG}               ${RESET_BG}";;
        *)
            center_text "${WHITE_BG}                ${RESET_BG}"
            center_text "${WHITE_BG}    /\ _ /\     ${RESET_BG}"
            center_text "${WHITE_BG}  =( > w < )=_  ${RESET_BG}"
            center_text "${WHITE_BG}    )  v  (_/ | ${RESET_BG}"
            center_text "${WHITE_BG}   ( _\|/_ )_/  ${RESET_BG}"
            center_text "${WHITE_BG}                ${RESET_BG}";;
    esac
    center_text "${RESET_BG}             ${RESET_BG}"
}


function show_screen_resolutions() {
    screens=$(xrandr | grep ' connected' | awk '{ print $1 }')

    if [ -z "$screens" ]; then
        echo ""
        return
    fi

    for screen in $screens; do
        resolution=$(xrandr | grep -A1 "$screen" | grep '*' | awk '{print $1}')
        if [ "$show_labels" = true ]; then
            center_text "${BLUE}${RESOL_ICO} $screen: ${WHITE} $resolution"
        else
            center_text "${BLUE}${RESOL_ICO} ${WHITE} $resolution"
        fi
    done
}

function ip_info() {
    IP=$(curl --silent ifconfig.me)

    if [ "$show_labels" = true ]; then
        center_text "${BLUE}${IP_ICO} IP: ${WHITE}$IP"
    else
        center_text "${BLUE}${IP_ICO}  ${WHITE}$IP"
    fi
}

function cpu_info() {
    local cpu_percent
    cpu_percent=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2}')
    if [ "$show_labels" = true ]; then
        center_text "${BLUE}${CPU} CPU: ${WHITE}$(cat /proc/cpuinfo | grep 'model name' | uniq | cut -d: -f2 | awk '{print $5}') - $cpu_percent"
    else
        center_text "${BLUE}${CPU}  ${WHITE}$(cat /proc/cpuinfo | grep 'model name' | uniq | cut -d: -f2 | awk '{print $5}') - $cpu_percent"
    fi
}

function memory_info() {
    local total_mem
    local used_mem
    total_mem=$(free | grep Mem | awk '{print $2}')
    used_mem=$(free | grep Mem | awk '{print $3}')
    if [ "$show_labels" = true ]; then
        center_text "${BLUE}${RAM} RAM: ${WHITE}$((used_mem/1024/1024)) GB / $((total_mem/1024/1024)) GB - $((used_mem * 100 / total_mem))"
    else
        center_text "${BLUE}${RAM}  ${WHITE}$((used_mem/1024/1024)) GB / $((total_mem/1024/1024)) GB - $((used_mem * 100 / total_mem))"
    fi
}

function user_info() {
    local username
    local hostname
    username=$(whoami)
    hostname=$(hostname)
    center_text "${BLUE}${USER} $username@$hostname${WHITE}"
    printf "\n"
}

function gpu_info() {
    if command -v lspci &> /dev/null; then
        if [ "$show_labels" = true ]; then
            center_text "${BLUE}${GPU} GPU: ${WHITE}$(lspci | grep -i vga | cut -d: -f3- | sed 's/^.*\[\(.*\)\].*$/\1/')"
        else
            center_text "${BLUE}${GPU}  ${WHITE}$(lspci | grep -i vga | cut -d: -f3- | sed 's/^.*\[\(.*\)\].*$/\1/')"
        fi
    else
        echo "Error: lspci command not found."
        return 1
    fi
}

function disk_info() {
    local disk_usage
    local disk_use
    local disk_size
    disk_usage=$(df -h / | grep / | awk '{print $5}')
    disk_use=$(df -h / | grep / | awk '{print $3}')
    disk_size=$(df -h / | grep / | awk '{print $2}')

    if [ "$show_labels" = true ]; then
        center_text "${BLUE}${DISK} Disk: ${WHITE}$disk_use/$disk_size - $disk_usage"
    else
        center_text "${BLUE}${DISK}  ${WHITE}$disk_use/$disk_size - $disk_usage"
    fi
}

function kernel_info() {
    if [ "$show_labels" = true ]; then
        center_text "${BLUE}${KERNEL} Kernel: ${WHITE}$(uname -r)"
    else
        center_text "${BLUE}${KERNEL}  ${WHITE}$(uname -r)"
    fi
}

function os_info() {
    if [ "$show_labels" = true ]; then
        center_text "${BLUE}${OS} OS: ${WHITE}$(lsb_release -d | cut -f2)"
    else
        center_text "${BLUE}${OS}  ${WHITE}$(lsb_release -d | cut -f2)"
    fi
}

function shell_info() {
    if [ "$show_labels" = true ]; then
        center_text "${BLUE}${SHELL_ICO} Shell: ${WHITE}$SHELL"
    else
        center_text "${BLUE}${SHELL_ICO}  ${WHITE}$SHELL"
    fi
}

function wm_info() {
    if [ "$show_labels" = true ]; then
        center_text "${BLUE}${WM} WM: ${WHITE}$(echo $XDG_CURRENT_DESKTOP)"
    else
        center_text "${BLUE}${WM}  ${WHITE}$(echo $XDG_CURRENT_DESKTOP)"
    fi
}

function uptime_info() {
    local uptime_seconds
    uptime_seconds=$(awk '{print $1}' /proc/uptime)

    uptime_seconds=${uptime_seconds%.*}
    local days=$((uptime_seconds / 86400))
    local hours=$(( (uptime_seconds % 86400) / 3600 ))
    local minutes=$(( (uptime_seconds % 3600) / 60 ))

    if [ "$show_labels" = true ]; then
        center_text "${BLUE}${UPTIME} Uptime: ${WHITE}$((days))d $((hours))h $((minutes))m"
    else
        center_text "${BLUE}${UPTIME}  ${WHITE}$((days))d $((hours))h $((minutes))m"
    fi
}

function colors_info() {
    center_text "${BLACK_BG}    ${RED_BG}    ${GREEN_BG}    ${BLUE_BG}    ${CYAN_BG}    ${WHITE_BG}    ${RESET_BG}"
    printf "\n"
}

function help_info() {
    echo "Usage: $0 [--labels] [--logo] [--cpu] [--ram] [--gpu] [--disk] [--ip] [--os] [--shell] [--wm] [--uptime] [--kernel] [--user] [--help] [--colors] [--resol] [--song]"
}

function package_manager_info() {
    local package_manager=""
    local package_count=""

    if command -v dpkg &> /dev/null; then
        package_manager="dpkg"
        package_count=$(dpkg --get-selections | wc -l)
    elif command -v rpm &> /dev/null; then
        package_manager="rpm"
        package_count=$(rpm -qa | wc -l)
    elif command -v pacman &> /dev/null; then
        package_manager="pacman"
        package_count=$(pacman -Q | wc -l)
    elif command -v zypper &> /dev/null; then
        package_manager="zypper"
        package_count=$(zypper packages --installed-only | wc -l)
    elif command -v apt &> /dev/null; then
        package_manager="apt"
        package_count=$(apt list --installed | wc -l)
    else
        echo "Unknown package manager"
        return 1
    fi

    if [ "$show_labels" = true ]; then
        center_text "${BLUE}${PKGS} PKGS: ${WHITE}$package_count - $package_manager"
    else
        center_text "${BLUE}${PKGS}  ${WHITE}$package_count - $package_manager"
    fi
}

function get_current_song() {
    players=(
        "amarok"
        "audacious"
        "banshee"
        "clementine"
        "cmus"
        "deadbeef"
        "vlc"
        "spotify"
        "rhythmbox"
        "playerctl"
        "mpd"
        "mopidy"
    )

    printf -v players_pattern "|%s" "${players[@]}"
    player="$(ps aux | awk -v pattern="(${players_pattern:1})" \
        '!/ awk / && match($0, pattern) {print substr($0, RSTART, RLENGTH); exit}')"

    get_song_dbus() {
        song="$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2."${1}" /org/mpris/MediaPlayer2 \
            org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' \
            string:'Metadata' |\
            awk -F '"' 'BEGIN {RS=" entry"}; /"xesam:artist"/ {a = $4} /"xesam:album"/ {b = $4}
                        /"xesam:title"/ {t = $4} END {print a " \n" b " \n" t}')"
    }

    case ${player/*\/} in
        "vlc"*)           song="$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 \
                            org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' \
                            string:'Metadata' | awk -F '"' '/"xesam:artist"/ {print $4} /"xesam:title"/ {print $4}')" ;;
        "spotify"*)       song="$(playerctl metadata --format '{{ artist }} \n{{ album }} \n{{ title }}')" ;;
        "rhythmbox"*)     get_song_dbus "rhythmbox" ;;
        "mpd"*)           song="$(mpc -f '%artist% \n%album% \n%title%' current)" ;;
        "mopidy"*)        song="$(mpc -f '%artist% \n%album% \n%title%' current)" ;;
        *)                center_text "${BLUE}${MUSIC} " && return ;;
    esac

    IFS=$'\n' read -d "" artist album title <<< "${song//'\n'/$'\n'}"

    artist="${artist:-Unknown Artist}"
    album="${album:-Unknown Album}"
    title="${title:-Unknown Song}"

    if [ "$show_labels" = true ]; then
        center_text "${BLUE}${MUSIC} SONG: ${artist} - ${title}"
    else
        center_text "${BLUE}${MUSIC}  ${WHITE}${artist} - ${title}"
    fi
}



if [ $# -eq 0 ]; then
    # Если аргументы не переданы, выводим всю информацию
    ascii_art

    user_info
    wm_info
    ip_info
    os_info
    package_manager_info
    uptime_info
    get_current_song

    colors_info
else
    # Обработка переданных аргументов
    while [[ "$1" != "" ]]; do
        case $1 in
            --labels ) show_labels=true ;;
            --logo ) ascii_art ;;
            --cpu ) cpu_info ;;
            --ram ) memory_info ;;
            --gpu ) gpu_info ;;
            --disk ) disk_info ;;
            --os ) os_info ;;
            --shell ) shell_info ;;
            --wm ) wm_info ;;
            --uptime ) uptime_info ;;
            --kernel ) kernel_info ;;
            --user ) user_info ;;
            --help ) help_info ;;
            --colors ) colors_info ;;
            --pkgs ) package_manager_info ;;
            --ip ) ip_info ;;
            --resol ) show_screen_resolutions ;;
            --song ) get_current_song ;;
            * ) echo "Unknown option: $1" ;;
        esac
        shift # Переход к следующему аргументу
    done
fi

read -n1 -r -s -p " "
