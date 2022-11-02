define syslogon='sys/system1 as sysdba'

prompt conectando como sysdba
connect &syslogon

Prompt creando usuario user01
grant create session, create table to user01 identified by user01;
alter user user01 quota unlimited on users;

grant create session to user02 identified by user02;
alter user user02 quota unlimited on users;

grant create session to user03 identified by user03;
alter user user03 quota unlimited on users;

prompt asignando privilegios de admon
grant sysdba to user01;
grant sysoper to user02;
grant sysbackup to user03;

prompt consultando los datos del archivo

col username format a20
col account_status format a20
col last_login format a40
select username,sysdba,sysoper,sysasm,sysbackup,sysdg,syskm,account_status,last_login 
from v$pwfile_users;

prompt ejecutar shell scripts como usuario oracle


disconnect
