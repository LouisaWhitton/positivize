#!/bin/bash
#
# Convert scanned photographic negatives to positive images
# The positive images are white balanced
SOURCE_DIR=$PWD/
DESTINATION_DIR=$PWD/
VERBOSE=false
REGEX_FULL="^.*(//)?([^\/\0]+(\/)?)+\/$"
REGEX_SHORT="^.*(\/)?([^\/\0]+(\/)?)+$"

set -euo pipefail
shopt -s inherit_errexit nullglob

while getopts 'd:s:v' flag; do
  case "${flag}" in
    s) 
    	SOURCE_DIR=${OPTARG}  
     	if [[ $SOURCE_DIR =~ $REGEX_FULL ]]; then
            echo "Source directory conforms to directory pattern"
        elif [[ $SOURCE_DIR =~ $REGEX_SHORT ]]; then
            SOURCE_DIR=$SOURCE_DIR/
            echo "Source directory conforms to directory pattern"
        else 
            echo "Invalid source directory path"
    	    exit 100
    	fi    	   	
    	DESTINATION_DIR=$SOURCE_DIR
    	;;
    d) 
    	DESTINATION_DIR=${OPTARG} 
     	if [[ "$DESTINATION_DIR" =~ $REGEX_FULL ]]; then
     	    echo "Destination directory conforms to directory pattern"
        elif [[ "$DESTINATION_DIR" =~ $REGEX_SHORT ]]; then
            DESTINATION_DIR=$DESTINATION_DIR/
            echo "Destination directory conforms to directory pattern"
        else 
            echo "Invalid destination directory path"
    	    exit 101
    	fi    	   	
    	mkdir -p "$DESTINATION_DIR"	
    	;;
    v) 
    	VERBOSE=true
    	;;
  esac
done
readonly SOURCE_DIR
readonly DESTINATION_DIR
readonly VERBOSE

FILES="$SOURCE_DIR"*
for file in `find $FILES -maxdepth 0 -type f`
do
    convert "$SOURCE_DIR${file##*/}" -channel RGB -negate "$DESTINATION_DIR${file##*/}"
    if [[ $VERBOSE == true ]]; then
        echo "Converted to positive $DESTINATION_DIR${file##*/}"
    fi
    
    
    convert "$DESTINATION_DIR${file##*/}" -separate -contrast-stretch 0.5%x0.5% -combine "$DESTINATION_DIR${file##*/}"
    if [[ $VERBOSE == true ]]; then
        echo "White balanced $DESTINATION_DIR${file##*/}"
    fi
done

echo "Finished positivizing $SOURCE_DIR"
