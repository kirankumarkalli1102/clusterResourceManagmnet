#!/bin/sh
attachment_path=$1
#archival_path=$2

# If multiple CSV files present in the dir then delete all except the latest.
hadoop fs -rm $attachment_path/_SUCCESS
csv_file_count=`hadoop fs -ls $attachment_path/*.csv | wc -l`
deletion_head_count=$(($csv_file_count-1))
echo "File count = $csv_file_count"
if [ "$csv_file_count" > "1"  ]
then
        for file in `hadoop fs -ls $attachment_path/*.csv | head -$deletion_head_count | awk '{print $8}'`; do
			echo "Deleting: $file"
                        hadoop fs -rm $file
		done
fi

filename=`hadoop fs -ls $attachment_path | awk '{print $NF}' | grep .csv$`
if [ “$filename” == “” ]
then
# echo "No attachment files present to be sent out."
echo isNull=`echo true`
# echo filepath=`echo $filename`
else
echo isNull=`echo false`
echo filepath=`echo $filename`
fi
