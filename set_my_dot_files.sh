#!/bin/bash

# Variable
tempDir=~/temp

# Functions
failed()
{
    echo "ERROR: Something was wrong!"
    return 1
}

# Download actual version form git into $tempDir
if [ -x /usr/bin/git ]; then

    if [ -d $tempDir ]; then
	echo "WARNING: Temp directory exist, this script rename the old"
	
	if [ -d $tempDir.old ]; then
	    echo "WARNING: Temp.old directory exist, remove the old"
	    rm -rf $tempDir.old
	fi
	
	mv -f $tempDir $tempDir.old
    fi

    git clone https://github.com/Dizzy-cz/DotFiles $tempDir
else
    echo "ERROR: Please install git"
    failed
fi


# Get list of config files
configFiles=$(ls -A $tempDir |grep -v '.git\|README.md')

# Copy config files to right path
for file in $configFiles; do
    echo "Processing file: $file"

    if [ -e ~/$file ]; then
	    echo "WARNING: $file exist, this script rename the old"
	    mv ~/$file ~/$file.old
    fi
    
    cp $tempDir/$file ~/
done
