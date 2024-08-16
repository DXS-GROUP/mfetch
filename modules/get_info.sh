#!/bin/bash

function cpu_info() {
    local cpu_percent
    cpu_percent=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2}')
    center_text "${CYAN}${CPU} CPU: ${RESET}$(cat /proc/cpuinfo | grep 'model name' | uniq | cut -d: -f2 | awk '{print $5}') - $((cpu_percent))%"
}

function memory_info() {
    local total_mem
    local used_mem
    total_mem=$(free | grep Mem | awk '{print $2}')
    used_mem=$(free | grep Mem | awk '{print $3}')
    center_text "${CYAN}${RAM} RAM: ${RESET}$((used_mem/1024/1024)) GB / $((total_mem/1024/1024)) GB - $((used_mem * 100 / total_mem))%"
}

function user_info() {
    local username
    local hostname
    username=$(whoami)
    hostname=$(hostname)
    center_text "${CYAN}${USER} $username@$hostname${RESET}"
    printf "\n"
}

function gpu_info() {
    if command -v lspci &> /dev/null; then
        center_text "${CYAN}${GPU} GPU: ${RESET}$(lspci | grep -i vga | cut -d: -f3- | sed 's/^.*\[\(.*\)\].*$/\1/')"
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
    center_text "${CYAN}${DISK} Disk: ${RESET}$disk_use/$disk_size - $disk_usage"
}

function kernel_info() {
    center_text "${CYAN}${KERNEL} Kernel: ${RESET}$(uname -r)"
}

function os_info() {
    center_text "${CYAN}${OS} OS: ${RESET}$(lsb_release -d | cut -f2)"
    # center_text "${CYAN}${OS} OS: ${RESET}Endeavouros Linux"
}

function shell_info() {
    center_text "${CYAN}${SHELL_ICO} Shell: ${RESET}$SHELL"
}

function wm_info() {
    center_text "${CYAN}${WM} WM: ${RESET}$(echo $XDG_CURRENT_DESKTOP)"
}

function uptime_info() {
    local uptime_seconds
    uptime_seconds=$(awk '{print $1}' /proc/uptime)

    uptime_seconds=${uptime_seconds%.*}
    local days=$((uptime_seconds / 86400))
    local hours=$(( (uptime_seconds % 86400) / 3600 ))
    local minutes=$(( (uptime_seconds % 3600) / 60 ))

    center_text "${CYAN}${UPTIME} Uptime: ${RESET}$((days))d $((hours))h $((minutes))m"
}

function colors_info() {
    center_text "${BLACK_BG}     ${RED_BG}     ${GREEN_BG}     ${BLUE_BG}     ${CYAN_BG}     ${WHITE_BG}     ${RESET_BG}"
    printf "\n"
}

function help_info() {
    printf "Usage: $0 [--logo] [--cpu] [--ram] [--gpu] [--disk] [--os] [--shell] [--wm] [--uptime] [--kernel] [--user] [--help] [--colors]"
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

    center_text "${CYAN}${PKGS} PKGS: ${RESET}$package_count - $package_manager"
}
