#!/bin/bash
# Author: Matthew Fan <fanma@gmail.com>
#
# Deletes all executables in install directory with same name
# as commands
# THIS IS DANGEROUS Make sure you know what you're deleting!


if [ $# = 1 ]
then
    installPath="$1"
elif [ $# -gt 1 ]
then
    echo "Please specify only one path"
    exit
else
    uninstallPath="/usr/bin"
fi


uninstallThese="$(find ./commands -type f -executable | sed -e "s/.*\///g" | sort)"

echo "About to remove: "
echo "$uninstallThese"
echo

echo "Okay to uninstall from $uninstallPath? [y , n]"


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

echo
echo "Uninstalling..."
echo

i=0
lines=$(echo "$uninstallThese" | wc -l)
while [ $i -lt $lines ]
do
    currentTailAmount=$(echo "$lines - $i" | bc)
    currentCommand="$(echo "$uninstallThese" | tail -n $currentTailAmount | head -n 1)"
    fullCommand="${uninstallPath}/$currentCommand"
    echo "$fullCommand"
    rm "$fullCommand"

    i=$(echo $i + 1 | bc)
done