Prompt conectando como sysdba (sys)
-- no poner password en ambientes productivos/testing
connect sys/system1 as sysdba

prompt creando usuario nombre02
create user nombre02 identified by nombre02 ---- quota unlimited on users;

prompt asignando privilegios de sistema
grant create table, create session to nombre02;

prompt conectando como nombre02
connect nombre02/nombre02

prompt creando tabla de prueba, si no se indica se toma el table space por default
create table test01(id number);

prompt regreso a sys conectando como sys
connect sys/system1 as sysdba

prompt consultas al diccionario de datos , mostrando privilegios del usuario
col grantee format A30
select grantee, privilege, admin_option
from dba_sys_privs
where grantee ='NOMBRE02';


prompt haciendo limpieza 
drop user nombre02 cascade;


