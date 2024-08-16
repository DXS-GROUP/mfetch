#!/bin/bash

function ascii_art() {
    os_name="$(lsb_release -d | cut -f2)"

    # os_name="Endeavouros Linux"

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
