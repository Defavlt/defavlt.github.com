#!/bin/bash

function compile {
    if [ $# -lt 1 ];
    then
        printf "Usage: compile (watch | now)";
        printf "\n"
        exit;
    else
        src=${4:-"src/"}
        output=${2:-"$src/css"}
        input=${3:-"$src/_scss"}

        case "$1" in
            watch)
                scss --watch $input:$output &
            ;;
            now)
                scss --update $input $output
            ;;
        "serve now")
                compile now
                compile serve
            ;;
            serve)
                clear
                jekyll serve
            ;;
        esac
    fi
}

compile $@;
