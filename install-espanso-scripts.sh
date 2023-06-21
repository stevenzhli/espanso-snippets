#!/bin/bash

## Install snippets and configurations to Esapnso.app

# this script will unlink existing yaml files from Espanso config, then
# link all yaml files stored in the target dir to the Espanso app config dir
# -u: unlink (remove) previous setting yaml files only

MY_CONFIG=./config
ES_CONFIG=${HOME}/.config/espanso/config/
MY_SNIPPETS=./match/
ES_SNIPPETS=${HOME}/.config/espanso/match/

while getopts u flag
do
    case "${flag}" in
        u) unlink_only=1;;
       \?) echo ""
    esac
done

# remove old links
find $ES_CONFIG -type l -exec unlink {} \;
echo "old settings removed"
find $ES_SNIPPETS -type l -exec unlink {} \;
echo "old snippets removed"

if [[ $unlink_only ]]; then
  : # null command to skip
else
  ln -s $MY_CONFIG/*.yml $ES_CONFIG
  echo "new settings updated"
  ln -s $MY_SNIPPETS/*.yml $ES_SNIPPETS
  echo "new snippets updated"
fi

espanso restart