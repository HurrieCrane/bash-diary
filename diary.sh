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

while [[ $1 != '' ]]; do
  case $1 in
      -h|--help)
        printf ""
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
