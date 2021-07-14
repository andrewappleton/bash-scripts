#!/bin/bash
if [ "$#" -ne 1 ] ; then
        echo "Please provide search expression for tag (e.g. 100.0.0)"
fi
CONTAINERS=$(docker image ls --format "{{.Repository}}:{{.Tag}}"  | grep $1)
for cname in $CONTAINERS
do
        image=$( echo $cname | cut -d\: -f1 )
        filename=$( echo $cname | cut -d\: -f1 | rev | cut -d\/ -f1 | rev )
        tag=$( echo $cname | cut -d\: -f2 )
        currfilename=$filename-$tag.tar
        echo Saving image $currfilename...
        docker save -o $currfilename $image:$tag
        filelist+=" "$currfilename
done
echo Adding files to .tar...
tar cvf cxc-$1.tar $filelist
echo Deleting generated .tar files
for fname in $filelist
do
        echo deleting $fname
        rm -f $fname
done
echo XZing tar file...
xz -v cxc-$1.tar
echo Done...
