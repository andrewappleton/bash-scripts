#!/bin/bash
if [[ -z "$1" ]] ; then
    printf "No argument provided..\nPlease specify logfile prefix. e.g. 'confserv'\n"
    exit 1
fi
FILESPEC=$1
FILEDATE=$(date +"%Y%m%d_%H")
ZIPNAME=$FILESPEC.$FILEDATE.zip
KEEP=5
#Compress files based on the date/time...
#Doesn't matter if a file gets zipped twice...
#Zip will replace the file if it already exists in the archive.
echo "Writing zip file $ZIPNAME..."
zip --exclude=*snapshot* $ZIPNAME $FILESPEC.$FILEDATE*.log

#Delete older files...
#Count how many zip files we have
LOGCOUNT=$(ls -al $FILESPEC.*.zip | wc -l)
#If the count is greater than then number we want to keep, then delete,
#if not, then just exit
if [[ LOGCOUNT -gt  KEEP ]]
then
    #Subtract 5 from the count of current zip files
        LOGDELCOUNT=$(echo "$LOGCOUNT-$KEEP" | bc)
    #List the files by filename only in one column...
    #iterate through the list of files and delete each one.
        for n in $(ls -1 $FILESPEC.*.zip | head -$LOGDELCOUNT)
        do
                #rm -f b;
                echo "Deleting $n..."
        rm -f $n;
        done
fi
printf "\n\n\nDone!\n"
