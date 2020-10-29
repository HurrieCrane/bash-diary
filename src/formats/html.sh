#!/usr/bin/env bash

TEMPLATE_DIR="./src/formats/template.html"
HTML_DIARY_OATH="$DIARY_DIR.html"

cp $TEMPLATE_DIR $HTML_DIARY_OATH

find $HTML_DIARY_OATH -type f -exec  sed -i "" "s/#TEMPLATE/$1/g" {} \;
