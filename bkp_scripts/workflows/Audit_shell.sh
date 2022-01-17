#!/bin/sh
workflow_id=$1
job_name=$2
start_time=$3
error_msg=$4
control_file_path=$5
audit_file_path=$6
queueName=HAASDAP6035_12672
keytabUser=AI081089

#end_time=$4
#status=$5
#run_type=$6

kinit -kt ${keytabUser}.keytab ${keytabUser}@IUSER.IROOT.ADIDOM.COM
chmod 777 /home/ai081089/Zither_jobs/audit_check/*

echo error=`echo $error_msg`


#m1=`hadoop fs -cat /serv/HAASDAP6035_12672/annotated/zither/control_file/audit_control_file.txt`
m1=`hadoop fs -cat $control_file_path`
feed_record_count="$(cut -d'|' -f1 <<<"$m1")"
feed_record_count+=":"
feed_record_count+="$(cut -d'|' -f2 <<<"$m1")"
feed_record_count+=","
feed_record_count+="$(cut -d'|' -f8 <<<"$m1")"
feed_record_count+=":"
feed_record_count+="$(cut -d'|' -f9 <<<"$m1")"
attachment_file="$(cut -d'|' -f3 <<<"$m1")"
housekeeping_files_deleted="$(cut -d'|' -f4 <<<"$m1")"
number_of_compacted_files="$(cut -d'|' -f5 <<<"$m1")"
hdfs_path="$(cut -d'|' -f6 <<<"$m1")"
run_type="$(cut -d'|' -f7 <<<"$m1")"

if [ -z "$error_msg" ]
then
    status="success"
    echo $status
else
    status="failure"
    echo $status
fi

 end_time=$(date +%Y-%m-%d_%H:%M:%S)


echo $feed_record_count,$attachment_file,$compacted_small_files_count,$housekeeping_files_deleted,$number_of_compacted_files,$hdfs_path,$workflow_id,$job_name,$start_time,$end_time,$status,$run_type,$error_msg

echo "$feed_record_count|$attachment_file|$compacted_small_files_count|$housekeeping_files_deleted|$number_of_compacted_files|$hdfs_path|$workflow_id|$job_name|$start_time|$end_time|$status|$run_type|$error_msg" >> $audit_file_path



# `beeline --showHeader=false --outputformat=csv2 --hiveconf mapreduce.job.queuename=PROD.${queueName} -u "jdbc:hive2://rehvl01g003.iuser.iroot.adidom.com:10000/${queueName};principal=hive/_HOST@IUSER.IROOT.ADIDOM.COM" -e "insert into table application_audit_logs values('$workflow_id','$job_name','$start_time','$end_time','$status','$run_type','$feed_record_count','$attachment_file','$housekeeping_files_deleted','$number_of_compacted_files','$hdfs_path','$error_msg')"`

`hadoop fs -rm $control_file_path`
`hadoop fs -touchz $control_file_path`

echo status = `echo $status`
