#!/bin/sh
attachment_path=$1
#archival_path=$2

filename=`hadoop fs -ls $attachment_path | awk '{print $NF}' | grep .csv$`
if [ “$filename” == “” ]
then
echo isNull=`echo true`
#echo filepath=`echo $filename`
else
echo isNull=`echo false`
echo filepath=`echo $filename`
fi

