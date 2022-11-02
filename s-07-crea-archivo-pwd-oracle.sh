#!/bin/bash
echo "moviendo elarchivo de passwords a /home/oracle/backups"
mkdir -p /home/oracle/backups
mv "${ORACLE_HOME}"/dbs/orapwinicialesdip01 /home/oracle/backups

echo "creando un nuevo archivo de passwords"
orapwd file='${ORACLE_HOME}/dbs/orapwinicialesdip01' \
	force='Y' \
	format=12.2 \
	SYS=password  

echo "comprobando existencia"
ls -l "${ORACLE_HOME}"/dbs/orapwinicialesdip01
