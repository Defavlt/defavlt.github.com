#!/bin/bash

function compile {
    if [ $# -lt 1 ];
    then
        printf "Usage: compile (watch | now)";
        printf "\n"
        exit;
    else
        output=${2:-"css"}
        input=${3:-"_scss"}

        case "$1" in
            watch)
                scss --watch $input:$output &
            ;;
            now)
                scss --update $input $output
            ;;
            serve)
                clear
                jekyll serve
            ;;
        esac
    fi
}

compile $@;
