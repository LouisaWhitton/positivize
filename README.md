# positivize

*positivize* is a bash script which, given a folder containing scanned photographic negatives, converts them to positive images (or vice versa).

## Pre-requisites
* **Linux** (tested on Ubuntu 23.10)
* **ImageMagick** (tested on version 6.9.11 - earlier versions may fail due to changes in the "convert" function)

## Usage

After saving the file *positivize.sh* make it executable, for example through the terminal command:
```
chmod 755 positivize.sh
```
Consider adding the holding folder to ```$PATH``` , eg by adding the following line to *.bashrc* or *.profile*:
```
export PATH="$HOME/<your bash script folder name here>/positivize:$PATH"
```
*positivize* can then be run by executing the following command from a folder containing image files:
```
positivize.sh -v
```
Note that the script will fail if the folder contains any files which are not valid image files.

## Options
* **-d** - follow with destination filepath; if omitted, overwrites the negative images with the positve
* **-s** - follow with source filepath; if omitted, operates on all files in the current directory
* **-v** - verbose; echoes to terminal for each file operation
* 
Example:
```
positivize -s ./my_negatives/ -d ./my_positives/ -v
```
This will operate on all files in ```./my_negatives/``` and will save the positive files to ```./my_positives/``` - there will be verbose output.
