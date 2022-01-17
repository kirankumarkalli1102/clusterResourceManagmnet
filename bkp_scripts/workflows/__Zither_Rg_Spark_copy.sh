#!/bin/sh


echo "running spark submit"

spark2-submit --master yarn --conf spark.yarn.queue=PROD.HAASDAP6035_12672 --conf num-executors=6 --conf spark.executor.cores=4 --conf spark.executor.memory=8gb --driver-memory=16g --conf spark.executor.memoryOverhead=4096 --conf spark.shuffle.consolidateFiles=true --deploy-mode cluster --class com.bt.haas.zither.driver.Initialize zither-rg-monitoring.jar "/serv/HAASDAP6035_12672/workspace/zither/conf/feeds.config" "f_yarn_all_apps" "jceks:///serv/HAASDAP6035_12672/workspace/zither/credstore_vault/vault.jceks" "1D" "t_feed" "/serv/HAASDAP6035_12672/workspace/zither/keytab,AI081089.keytab,AI081089@IUSER.IROOT.ADIDOM.COM" "/serv/HAASDAP6035_12672/workspace/zither/properties/f_yarn_all_apps_th.properties"