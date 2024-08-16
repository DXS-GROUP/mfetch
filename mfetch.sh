#!/bin/bash

. modules/center_text.sh
. modules/ascii.sh
. modules/get_info.sh
. modules/colors.sh
. modules/icons.sh

clear

vertical_center_text

if [ $# -eq 0 ]; then
    ascii_art
    colors_info
    user_info
    wm_info
    ip_info
    os_info
    package_manager_info
    uptime_info
else
    while [[ "$1" != "" ]]; do
        case $1 in
            --logo ) ascii_art;;
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
            --pkgs ) package_manager_info;;
            --ip ) ip_info;;
            * ) echo "Unknown option: $1" ;;
        esac
        shift
    done
fi

read -n1 -r -s -p " "
