#!/bin/bash

RESET="\e[0m"
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"

# Функция для получения размеров терминала
function get_terminal_size() {
    local width
    local height
    width=$(tput cols)
    height=$(tput lines)
    echo "$width $height"
}

# Функция для центрирования текста
function center_text() {
    local text="$1"
    local width=$(tput cols)
    
    # Удаляем управляющие последовательности для подсчета длины видимого текста
    local visible_text=$(echo -e "$text" | sed -r "s/\x1B\[[0-9;]*m//g")
    local text_length=${#visible_text}
    
    local padding=$(( (width - text_length) / 2 ))
    printf "%${padding}s$text\n"
}

# Функция для вертикального центрирования текста
function vertical_center_text() {
    local lines=("$@")
    local height=$(tput lines)
    local text_height=${#lines[@]}
    
    # Вычисляем количество пустых строк для вертикального центрирования
    local padding=$(( (height - text_height) / 2 ))
    
    # Выводим пустые строки
    for ((i=0; i<padding; i++)); do
        echo
    done
    
    # Выводим текст
    for line in "${lines[@]}"; do
        center_text "$line"
    done
}

# Функция для вывода ASCII-арт
function ascii_art() {
    vertical_center_text \
        "${GREEN}     ,___  " \
        "   _| () \\ " \
        " /    --' " \
        " \\\ __^/   "
    echo -e "${RESET}"
}

function cpu_info() {
    local cpu_percent
    cpu_percent=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2}')
    center_text "${MAGENTA}CPU: ${RESET}$(cat /proc/cpuinfo | grep 'model name' | uniq | cut -d: -f2 | awk '{print $5}') - ${YELLOW}$((cpu_percent))%"
}

function memory_info() {
    local total_mem
    local used_mem
    total_mem=$(free | grep Mem | awk '{print $2}')
    used_mem=$(free | grep Mem | awk '{print $3}')
    center_text "${MAGENTA}RAM: ${RESET}$((used_mem/1024/1024)) GB / $((total_mem/1024/1024)) GB - ${YELLOW}$((used_mem * 100 / total_mem))%"
}

function user_info() {
    local username
    local hostname
    username=$(whoami)
    hostname=$(hostname)
    center_text "${YELLOW}$username${WHITE}@${CYAN}$hostname${RESET}"
}

function gpu_info() {
    if command -v lspci &> /dev/null; then
        center_text "${MAGENTA}GPU: ${RESET}$(lspci | grep -i vga | cut -d: -f3- | sed 's/^.*\[\(.*\)\].*$/\1/')"
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
    center_text "${MAGENTA}Disk: ${RESET}$disk_use/$disk_size - ${YELLOW}$disk_usage"
}

function kernel_info() {
    center_text "${MAGENTA}Kernel: ${RESET}$(uname -r)"
}

function os_info() {
    center_text "${MAGENTA}OS: ${RESET}$(lsb_release -d | cut -f2)"
}

function shell_info() {
    center_text "${MAGENTA}Shell: ${RESET}$SHELL"
}

function wm_info() {
    center_text "${MAGENTA}WM: ${RESET}$(echo $XDG_CURRENT_DESKTOP)"
}

function uptime_info() {
    local uptime_seconds
    uptime_seconds=$(awk '{print $1}' /proc/uptime)

    uptime_seconds=${uptime_seconds%.*}
    local days=$((uptime_seconds / 86400))
    local hours=$(( (uptime_seconds % 86400) / 3600 ))
    local minutes=$(( (uptime_seconds % 3600) / 60 ))

    center_text "${MAGENTA}Uptime: ${RESET}$((days))d $((hours))h $((minutes))m"
}

function colors_info() {
    center_text "${BLACK} ${RED} ${GREEN} ${YELLOW} ${BLUE} ${MAGENTA} ${CYAN} ${WHITE} "
}

function help_info() {
    center_text "Usage: $0 [--cpu] [--ram] [--gpu] [--disk] [--os] [--shell] [--wm] [--uptime] [--kernel] [--user] [--help] [--colors]"
}

if [ $# -eq 0 ]; then
    ascii_art
    user_info
    os_info
    wm_info
    uptime_info
    colors_info
else
    while [[ "$1" != "" ]]; do
        case $1 in
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
            * ) echo "Unknown option: $1" ;;
        esac
        shift
    done
fi
