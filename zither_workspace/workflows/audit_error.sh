#!/bin/sh

workflow_id=$1
job_name=$2
audit_log_path=$3
error=$4
attachment_path=$5

echo "Application resulted in an error."
echo "Deleting all attachment files from dir: $attachment_path"
hadoop fs -rm $attachment_path/*
echo "Logging only error relevant logs..."
start_time=$(date '+%Y-%m-%d %H:%M:%S')
echo "$workflow_id|NA|$job_name|$start_time|NA|FAILED|NA|NA|NA|NA|NA|NA|NA|NA|$4" | hadoop fs -appendToFile - $audit_log_path
echo "Done."
