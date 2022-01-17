#!/bin/sh


queueName=$1
no_of_executors=6
no_of_cores=4
exectors_memory=8gb
driver_memory=16g
executor_memoryOverhead=4096
main_class=com.bt.haas.zither.driver.Initialize
config_file=$2
alert_type=$3
hdfs_properties_file=$4
cluster_id=$5
job_type=$6



spark2-submit --conf spark.yarn.keytab=AI081089.keytab --conf spark.yarn.principal=AI081089@IUSER.IROOT.ADIDOM.COM --master yarn --conf spark.serializer=org.apache.spark.serializer.KryoSerializer --conf spark.yarn.queue=${queueName} --conf num-executors=${no_of_executors} --conf spark.executor.cores=${no_of_cores} --conf spark.executor.memory=${exectors_memory} --driver-memory=${driver_memory} --conf spark.executor.memoryOverhead=${executor_memoryOverhead} --conf spark.shuffle.consolidateFiles=true --deploy-mode cluster --class ${main_class} zither-rg-monitoring.jar "${config_file}" "${alert_type}" "${hdfs_properties_file}" "${cluster_id}" "${job_type}"  