#!/bin/bash

# Variable
tempDir=~/temp
gitRemote="https://github.com/Dizzy-cz/DotFiles"

# Functions
failed()
{
    echo "ERROR: Something was wrong!"
    return 2
}

copyFiles()
{
    # Variables
    destDir=~
    # Code

    echo "$destDir/$file"
    if [ -e $destDir/$file ]; then
	echo "WARNING: $file exist, this script rename the old"
	
	if [ -d $destDir/$file ]; then
	    echo "INFO: $file is Directory"

	    if [ -d $destDir/$file.old ]; then
		echo "WARNING: $file.old directory exist, remove the old"
		rm -rfv $destDir/$file.old
	    fi
	    
	    mkdir $destDir/$file.old
	    mv -v $destDir/$file/.[!.]* $destDir/$file.old
	else
	    mv $destDir/$file $destDir/$file.old
	fi
    else
	echo "WTF"
    fi
}

# Code
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

    git clone $gitRemote $tempDir
else
    echo "ERROR: Please install git"
    failed
fi


# Get list of config files/directories in $tempDir
configFiles=$(ls -A $tempDir |grep -v '.git\|README.md')

# Copy config files to right path
for file in $configFiles; do
    echo "Processing file: $file"

#    if [ -e ~/$file ]; then
#	echo "WARNING: $file exist, this script rename the old"
#	
#	if [ -d $tempDir/$file ]; then
#	    echo "INFO: $file is Directory"
#
#	    if [ -d ~/$file.old ]; then
#		rm -rfv ~/$file.old
#	    fi
#	    
#	    mkdir ~/$file.old
#	    mv -v ~/$file/.[!.]* ~/$file.old
#	else
#	    mv ~/$file ~/$file.old
#	fi
#	
#   fi
    copyFiles
    cp -rv $tempDir/$file ~/
done
