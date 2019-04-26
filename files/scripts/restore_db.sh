#!/bin/bash

ras=`ps -A | grep ras`
if [ -z "$ras" ];
    then
       	/opt/1C/v8.3/x86_64/ras cluster --daemon
fi

cluster=`/opt/1C/v8.3/x86_64/rac cluster list | grep ^cluster | awk '{print $3}'`
echo $cluster

for var in $(ls /tmp/*.sql.gz)
do
gzip -d	$var
dumpfile=`echo $var | sed 's/.gz//'`
psql -U postgres < $dumpfile
base=`head -n 25 $dumpfile | grep "CREATE DATABASE" | awk '{print $3}'`
hostname=`hostname`
/opt/1C/v8.3/x86_64/rac infobase --cluster=$cluster create --name=$base --dbms=PostgreSQL --db-server=$hostname --db-name=$base --locale=ru --db-user=postgres --license-distribution=allow
rm -f $dumpfile
done
