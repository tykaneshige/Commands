#!/bin/sh

if [ $# = 1 ]
then
    installPath="$1"
elif [ $# -gt 1 ]
then
    echo "Please specify only one path"
    exit
else
    installPath="/usr/bin"
fi


echo "Okay to install to $installPath? [y , n]"


while [ true ]
do
    read response

    if [ "$response" = "n" ] || [ "$response" = "N" ]
    then
        exit
    elif [ "$response" != "y" ] && [ "$response" != "Y" ]
    then
        echo "Please enter either y or n"
    else
        break
    fi
done

echo "Installing..."

commands=$(find ./commands -type f -executable)

echo "$commands"

for command in "$commands"
do
    cp "$command" ~/Desktop
done