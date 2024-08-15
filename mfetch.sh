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

function cpu_info() {
    cpu_percent=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2}')
    echo -e "${MAGENTA}CPU: ${RESET}$(cat /proc/cpuinfo | grep 'model name' | uniq | cut -d: -f2 | awk '{print $5}') - ${YELLOW}$((cpu_percent))%"
}

function memory_info() {
    total_mem=$(free | grep Mem | awk '{print $2}')
    used_mem=$(free | grep Mem | awk '{print $3}')
    echo -e "${MAGENTA}RAM: ${RESET}$((used_mem/1024/1024)) GB / $((total_mem/1024/1024)) GB - ${YELLOW}$((used_mem * 100 / total_mem))%"
}

function user_info() {
    username=$(whoami)
    hostname=$(hostname)
    echo -e "${YELLOW}$username${WHITE}@${CYAN}$hostname${RESET}"
}

function gpu_info() {
    if command -v lspci &> /dev/null; then
        echo -e "${MAGENTA}GPU: ${RESET}$(lspci | grep -i vga | cut -d: -f3- | sed 's/^.*\[\(.*\)\].*$/\1/')"
    else
        echo "Error: lspci command not found."
        return 1
    fi
}

function disk_info() {
    disk_usage=$(df -h / | grep / | awk '{print $5}')
    disk_use=$(df -h / | grep / | awk '{print $3}')
    disk_size=$(df -h / | grep / | awk '{print $2}')
    echo -e "${MAGENTA}Disk: ${RESET}$disk_use/$disk_size - ${YELLOW}$disk_usage"
}

function kernel_info() {
    echo -e "${MAGENTA}Kernel: ${RESET}$(uname -r)"
}

function os_info() {
    echo -e "${MAGENTA}OS: ${RESET}$(lsb_release -d | cut -f2)"
}

function shell_info() {
    echo -e "${MAGENTA}Shell: ${RESET}$SHELL"
}

function wm_info() {
    echo -e "${MAGENTA}WM: ${RESET}$(echo $XDG_CURRENT_DESKTOP)"
}

function uptime_info() {
    uptime_seconds=$(awk '{print $1}' /proc/uptime)

    uptime_seconds=${uptime_seconds%.*}
    days=$((uptime_seconds / 86400))
    hours=$(( (uptime_seconds % 86400) / 3600 ))
    minutes=$(( (uptime_seconds % 3600) / 60 ))

    echo -e "${MAGENTA}Uptime: ${RESET}$((days))d $((hours))h $((minutes))m"
}

function colors_info() {
    echo -e "${BLACK} ${RED} ${GREEN} ${YELLOW} ${BLUE} ${MAGENTA} ${CYAN} ${WHITE} "
}

function help_info() {
    echo "Usage: $0 [--cpu] [--ram] [--gpu] [--disk] [--os] [--shell] [--wm] [--uptime] [--kernel] [--user] [--help] [--colors]"
}

if [ $# -eq 0 ]; then
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
