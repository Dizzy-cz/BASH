#!/bin/bash

# Functions
failed()
{
    echo "ERROR: Something was wrong!"
    return 1
}

# Download actual version form git into ~/temp
if [ -x /usr/bin/git ]; then

    if [ -d ~/temp ]; then
	echo "WARNING: Temp directory exist, this script rename the old"
	mv -f ~/temp ~/temp.old
    fi
    
    exec git clone https://github.com/Dizzy-cz/DotFiles ~/temp
else
    echo "ERROR: Please install git"
    failed
fi
