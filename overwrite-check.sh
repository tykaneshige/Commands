#!/bin/bash
# Author: Matthew Fan <fanma@ucla.edu>
#
# This script checks to see if installing these commands has
# the possibility of overwriting existing commands in the 
# install directory or specified directory
#
# DO NOT RENAME ME
# THIS SCRIPT IS A DEPENDENCY


if [ $# = 1 ]
then
    checkPath="$1"
elif [ $# -gt 1 ]
then
    echo "Please specify only one path"
    exit
else
    checkPath="/usr/bin"
fi

projectCommands="$(find ./commands -type f -executable | sed -e "s/.*\///g" | sort)"
installCommands="$(find $checkPath -maxdepth 1 -type f -executable | sed -e "s/.*\///g" | sort )"
conflict=$(comm -12 <(echo "$projectCommands") <(echo "$installCommands") )

echo "$conflict"