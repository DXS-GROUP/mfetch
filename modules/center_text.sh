#!/bin/bash

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
        echo "$spaces$line"
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
