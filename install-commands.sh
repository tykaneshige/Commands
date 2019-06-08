#!/bin/bash
# Created by: Matthew Fan
# Email: fanma@ucla.edu
#
# The install-commands.sh script installs all executable files under
# ./commands into /usr/bin by default or any other specified directory


# check to see if we have overwrite-check.sh script
checkTemp="$(ls | grep "overwrite-check.sh" )"

if [ "$checkTemp" != "overwrite-check.sh" ]
then
    echo "Error: overwrite-check.sh not found" >&2
    exit
fi


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


echo "Possible overwrites: "
./overwrite-check.sh "$installPath"


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

echo
echo "Installing..."

commands=$(find ./commands -type f -executable)

echo
echo "$commands"

i=0
lines=$(echo "$commands" | wc -l)
while [ $i -lt $lines ]
do
    currentTailAmount=$(echo "$lines - $i" | bc)
    currentCommand="$(echo "$commands" | tail -n $currentTailAmount | head -n 1)"
    
    cp "$currentCommand" "$installPath"

    i=$(echo $i + 1 | bc)
done