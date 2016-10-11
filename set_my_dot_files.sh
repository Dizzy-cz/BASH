#!/bin/bash

#Download actual version form git into ~/temp
if [ -x /usr/bin/git ];then
    exec git clone https://github.com/Dizzy-cz/DotFiles ~/temp
else
    echo "ERROR: Please install git"
    #failed()
fi
