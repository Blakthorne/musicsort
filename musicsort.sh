#!/bin/bash

newdir=/home/dlpolar/Documents/
dir=/home/dlpolar/Documents/Google_Music/Legacy/*

for file in $dir
do
    # Extract album
    album=$(exiftool "$file" | grep '^Album   ' | awk -F': ' '{print $2,$3}' | sed 's/ *$//g')

    # Path to the album folder
    path=$newdir$album

    # If the album folder doesn't exist, create it and copy file to it
    # If not, just copy file to it
    if [ ! -d "$path" ]
    then
        mkdir "$path"
        cp "$file" "$path"
    else
        cp "$file" "$path"
    fi

    # Extract more information
    filename=$(exiftool "$file" | grep '^File Name  ' | awk -F': ' '{print $2,$3}' | sed 's/ *$//g')
    title=$(exiftool "$file" | grep '^Title   ' | awk -F': ' '{print $2,$3}' | sed 's/ *$//g' | sed 's/\//_/g')
    extension=$(exiftool "$file" | grep '^File Type Extension  ' | awk -F': ' '{print $2}' | sed 's/ *$//g')

    # Vars for copy command
    oldpath=$path/$filename
    newpath=$path/$title.$extension

    cp "$oldpath" "$newpath"
    rm "$oldpath"
done