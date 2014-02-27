#!/bin/bash

function compile {
    if [ $# -lt 1 ];
    then
        compile help
    else
        cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
        tmpd=${5:-"$cwd/.tmp"}
        src=${4:-"$cwd/src"}
        output=${2:-"$src/css"}
        input=${3:-"$src/_scss"}


        case "$1" in
            help)
                printf "Usage: compile (help | now | start | stop) [input] [output] [src directory] [tmp directory]"
                printf "\n"
                exit;
            ;;
            --debug)
                printf "tmpd:\t$tmpd\n"
                printf "src:\t$src\n"
                printf "output:\t$output\n"
                printf "input:\t$input\n"
                exit
            ;;
            start)
                {
                    compile stop

                    rm -r $tmpd > /dev/null
                    mkdir $tmpd

                    scss --watch $input:$output > /dev/null & &>/dev/null
                    pid_scss=$!
                    pid_scss_f=`mktemp -p $tmpd -t $pid_scss.XXXXXX`

                    jekyll serve & &> /dev/null
                    pid_jekyll=$!
                    pid_jekyll_f=`mktemp -p $tmpd -t $pid_jekyll.XXXXXX`
                
                    echo "$pid_scss"    > $pid_scss_f
                    echo "$pid_jekyll"  > $pid_jekyll_f
                } &> /dev/null

                echo "Started compile chain with pid: $pid_scss, $pid_jekyll"
            ;;
            stop)
               shopt -s nullglob
               echo "Kill and remove pids and pidfiles.."
               printf "Pid\tPidfile"
               for pidf in $tmpd/*; 
               do
                   if [ -e $pidf ];
                   then
                       got_files=true
                       content=`cat $pidf`
                       printf "\n$content\t$pidf"
                       kill -9 $content
                       rm $pidf
                   fi
               done

               if [ $got_files ];
               then
                   printf "\nDone!\n"
               else
                   printf "\rNo previous process alive!                                                                   \n"
               fi
            ;;
            now)
                scss --update $input $output
                jekyll build
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
