connect sys/system1 as sysdba

prompt creando roles 
create role web_admin_role;
create role web_root_role;

prompt asignando privilegios a web_admin_role
grant create session, create table, create sequence to web_admin_role;

prompt asignar los privilegios de web_admin_role a web_root_role
grant web_admin_role to web_root_role;

prompt creando al usuario j_admin
create user j_admin identified by j_admin;

prompt otorgando role
grant web_admin_role to j_admin with admin option;

prompt conectando como j_admin
pause ¿será posible conectarse como j_admin?
connect j_admin/j_admin

prompt creando al usuario j_os_admin, conectando como SYS
connect sys/system1 as sysdba
create user j_os_admin identified by j_os_admin;

prompt el usuario j_admin podrá otorgar el rol web_admin_role
prompt conectando como j_admin
connect j_admin/j_admin
grant web_admin_role to j_os_admin;

prompt verificando privilegios de j_os_admin
prompt conectando como SYS
connect sys/system1 as sysdba

prompt consultando privilegios para j_os_admin

col grantee format a20
col granted_role format a40
select grantee, granted_role, admin_option
from dba_role_privs
where grantee='J_OS_ADMIN';

prompt limpieza

drop user j_admin;
drop user j_os_admin;
drop role web_admin_role;
drop role web_root_role;




