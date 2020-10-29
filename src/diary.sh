#!/usr/bin/env bash

DIARY_DIR=$BASH_DIARY_DIR

# set default dir
#if [[ $DIARY_DIR == '' ]]; then
  DIARY_DIR="./"
#fi

SHORTOPTS="hnf:"
LONGOPTS="help,name,format:"

ARGS=$(getopt -s bash --options $SHORTOPTS --longoptions $LONGOPTS --name $PROGNAME -- "$0")

# Application argument values
DIARY_NAME=""
FORMAT=""

FILE_FORMATS=(html)
DIARY_PATH=""

# Help function
print_help() {
  printf "Usage \e[92mdiary.sh command\e[0m\n"
  printf "\n"
  printf "Commands:\n"
  printf "\n-h|--help:\n"
  printf "\tThis command, it prints helpful information to the console\n"
  printf "\n-n|--name:\n"
  printf "\tThis command appends an additional name to the end of that diary entry,\n"
  printf "\tfor example 00-00-00_ExtraName\n"
  printf "\n\n"
}

print_invalidFormatError() {
    printf "\e[31m$FORMAT is not a currently supported format\e[0m\n"
}

collect_diary() {
    if [[ $1 = true ]]; then 
        DIARY_DIR="$DIARY_DIR.$(date +%d-%m-%y)$diary_name"
        vim $DIARY_DIR
    else
        DIARY_DIR="$DIARY_DIR$(date +%d-%m-%y)$diary_name"
        vim $DIARY_DIR
    fi
}

export_formatted_diary() {
    # file_format, diary_text, file to write to
    $(find "./src/formats/$1.sh") $2 $3
}

while [[ $1 != '' ]]; do
  case $1 in
      -h|--help)
        print_help
        exit 0
      ;;
      -n|--name)
        DIARY_NAME="_$2"; shift
      ;;
      -f|--format)
        FORMAT="$2"; shift
      ;;
      *)
        printf "$1 is not a valid option"
      ;;
  esac
  shift
done

if [[ $FORMAT == "" ]]; then
    collect_diary false
else
    l_format=""
    for i in ${FILE_FORMATS[@]}; do
        if [[ $FORMAT == ${FILE_FORMATS[$i]} ]]
        then
            l_format=${FILE_FORMATS[$i]}
            printf "Creating entry with $l_format\n"
            
            collect_diary true
            export_formatted_diary $FORMAT $(cat $DIARY_DIR)
            #rm $?
        fi
    done
fi
