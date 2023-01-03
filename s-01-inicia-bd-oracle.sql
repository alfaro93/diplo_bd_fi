connect sys/system2 as sysdba
prompt deteniendo instancia
shutdown immediate

define backup_dir='/home/oracle/backups/modulo-03'
prompt moviendo archivos a respaldo seguro
!mkdir -p &backup_dir

prompt moviendo spfile y pfile
!mv $ORACLE_HOME/dbs/spfileinicialesdip02.ora &backup_dir
!mv $ORACLE_HOME/dbs/initincialesdip02.ora &backup_dir

prompt moviendo un solo archivo de control
!mv /unam-diplomado-bd/disk-01/app/oracle/oradata/INICIALESDIP02/control01.ctl &backup_dir

prompt moviendo todos los archivo redo log de cada grupo
!mv /unam-diplomado-bd/disk-01/app/oracle/oradata/INICIALESDIP02/redo01a.log &backup_dir
!mv /unam-diplomado-bd/disk-01/app/oracle/oradata/INICIALESDIP02/redo02a.log &backup_dir
!mv /unam-diplomado-bd/disk-01/app/oracle/oradata/INICIALESDIP02/redo03a.log &backup_dir

!mv /unam-diplomado-bd/disk-02/app/oracle/oradata/INICIALESDIP02/redo01b.log &backup_dir
!mv /unam-diplomado-bd/disk-02/app/oracle/oradata/INICIALESDIP02/redo02b.log &backup_dir
!mv /unam-diplomado-bd/disk-02/app/oracle/oradata/INICIALESDIP02/redo03b.log &backup_dir

!mv /unam-diplomado-bd/disk-03/app/oracle/oradata/INICIALESDIP02/redo01c.log &backup_dir
!mv /unam-diplomado-bd/disk-03/app/oracle/oradata/INICIALESDIP02/redo02c.log &backup_dir
!mv /unam-diplomado-bd/disk-03/app/oracle/oradata/INICIALESDIP02/redo03c.log &backup_dir

prompt moviendo datafiles
!mv $ORACLE_BASE/oradata/INICIALESDIP02/system01.dbf &backup_dir

!mv $ORACLE_BASE/oradata/INICIALESDIP02/users01.dbf &backup_dir

prompt mostrando archivos en el directorio de respaldos (verificar 8 archivos)
!ls -lh &backup_dir
pause archivos en directorio de respaldos, [enter] para continuar

prompt intentando iniciar instancia modo nomount
startup nomount
pause [enter] para corregir y reintentar
prompt restaurando archivos de parametros

!mv &backup_dir/spfileinicialesdip02.ora $ORACLE_HOME/dbs
!mv &backup_dir/initinicialesdip02.ora  $ORACLE_HOME/dbs

prompt iniciando instancia
startup nomount
pause ¿se corrigio el error? [Enter] para continuar

prompt intentando pasar al modo mount
alter database mount;

pause [Enter] para corregir y reintentar
prompt restaurando el archivo de control
!mv &backup_dir/control01.ctl /unam-diplomado-bd/disk-01/app/oracle/oradata/INICIALESDIP02

prompt cambiando al modo mount
alter database mount;

pause ¿se corrigio el error? [Enter] para continuar

prompt intentar pasar al modo open
alter database open;

pause [Enter] para restaurar datafile del tablespace system
prompt restaurando datafile para el tablespace system
!mv &backup_dir/system01.dbf $ORACLE_BASE/oradata/INICIALESDIP02

prompt intentando abrir nuevamente
alter database open;

pause ¿se corrigio el error? [Enter] para restaurar datafile del TS user
!mv &backup_dir/users01.dbf $ORACLE_BASE/oradata/INICIALESDIP02

prompt intentando abrir nuevamente 
alter database open;

pause ¿se corrigio el error? [Enter] para restaurar los Redo Log
!mv &backup_dir/redo01a.log /unam-diplomado-bd/disk-01/app/oracle/oradata/INICIALESDIP02
!mv &backup_dir/redo02a.log /unam-diplomado-bd/disk-01/app/oracle/oradata/INICIALESDIP02
!mv &backup_dir/redo03a.log /unam-diplomado-bd/disk-01/app/oracle/oradata/INICIALESDIP02

!mv &backup_dir/redo01b.log /unam-diplomado-bd/disk-02/app/oracle/oradata/INICIALESDIP02
!mv &backup_dir/redo02b.log /unam-diplomado-bd/disk-02/app/oracle/oradata/INICIALESDIP02
!mv &backup_dir/redo03b.log /unam-diplomado-bd/disk-02/app/oracle/oradata/INICIALESDIP02

!mv &backup_dir/redo01c.log /unam-diplomado-bd/disk-03/app/oracle/oradata/INICIALESDIP02
!mv &backup_dir/redo02c.log /unam-diplomado-bd/disk-03/app/oracle/oradata/INICIALESDIP02
!mv &backup_dir/redo03c.log /unam-diplomado-bd/disk-03/app/oracle/oradata/INICIALESDIP02

prompt intentando iniciar nuevamente en modo open, requiere autenticar y volver a iniciar

connect sys/system2 as sysdba
startup open;

prompt mostrando status 
select instance_name, status from v$instance;

pause ¿La base ha regresado a su normalidad? [Enter] para terminar 
