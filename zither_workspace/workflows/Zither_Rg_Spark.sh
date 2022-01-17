#!/bin/sh


queueName=$1
no_of_executors=6
no_of_cores=4
exectors_memory=8gb
driver_memory=16g
executor_memoryOverhead=4096
main_class=com.bt.haas.zither.driver.Initialize
feeds_config=$2
feed_name=$3
jceks_file=$4
cluster_id=$5
control_file_path=$6
job_type=$7
keytab_file=$8
hdfs_property_file=$9
workflow_id=${10}
audit_log_path=${11}
job_name=${12}

spark2-submit --conf spark.yarn.keytab=AI081089.keytab --conf spark.yarn.principal=AI081089@IUSER.IROOT.ADIDOM.COM --master yarn --conf spark.yarn.queue=${queueName} --conf num-executors=${no_of_executors} --conf spark.executor.cores=${no_of_cores} --conf spark.executor.memory=${exectors_memory} --driver-memory=${driver_memory} --conf spark.executor.memoryOverhead=${executor_memoryOverhead} --conf spark.shuffle.consolidateFiles=true --deploy-mode cluster --class ${main_class} zither-rg-monitoring.jar "${feeds_config}" "${feed_name}" "${jceks_file}" "${cluster_id}" "${job_type}" "${control_file_path}" "${keytab_file}" "${hdfs_property_file}" "${workflow_id}" "${audit_log_path}" "${job_name}"