#!/usr/bin/env bash

DIARY_DIR=$BASH_DIARY_DIR

# set default dir
if [[ $DIARY_DIR == '' ]]; then
  DIARY_DIR="~/.diary/"
fi

SHORTOPTS="hn:"
LONGOPTS="help,name:"

ARGS=$(getopt -s bash --options $SHORTOPTS --longoptions $LONGOPTS --name $PROGNAME -- "$0")

# Application argument values
DIARY_NAME=""

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


while [[ $1 != '' ]]; do
  case $1 in
      -h|--help)
        print_help
        exit 0
      ;;
      -n|--name)
        DIARY_NAME="_$2"; shift
      ;;
      *)
        printf "$2 is not a valid option"
      ;;
  esac
  shift
done

NAME="$DIARY_DIR$(date +%d-%m-%y)$DIARY_NAME"
vim $NAME
