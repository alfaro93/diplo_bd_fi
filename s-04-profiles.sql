define syslogon='sys/system1 as sysdba'

prompt conectando como sysdba
connect &syslogon

prompt creando un user profile
create profile session_limit_profile limit
sessions_per_user 2;

prompt creando usuario user01
create user user01 identified by user01 profile session_limit_profile;
grant create session to user01;

pause abrir 3 terminales y validar el user profile [Enter] para continuar, no cerrarlas.


prompt consultando sessiones del usuario user01
col username format a30
col schemaname format a30
select sid, serial#, username, schemaname, status
from v$session
where username ='USER01';

pause cerrar terminales antes de realizar limpieza [Enter] para continuar

drop user user01;
drop profile session_limit_profile;

