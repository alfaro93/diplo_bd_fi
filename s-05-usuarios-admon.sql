define syslogon='sys/system1 as sysdba'

prompt conectando como sysdba
connect &syslogon

prompt creando usuario user01
grant create session, create table to user01 identified by user01;
alter user user01 quota unlimited on users;

prompt otorgando privilegios de admon.
grant sysdba to user01;
grant sysoper to user01;
 
grant create session to user02 identified by user02;
alter user user02 quota unlimited on users;

grant create session to user03 identified by user03;
alter user user03 quota unlimited on users;

prompt conectando como user01 sin privilegios
connect user01/user01

prompt mostrando usuario:
show user

prompt mostrando el esquema:
select sys_context('USERENV','CURRENT_SCHEMA') as schema from dual;

prompt mostrando el método de autenticación
select sys_context('USERENV','AUTHENTICATION_METHOD') as auth_method from dual;

prompt creando tabla e insertando datos
create table test(id number);
insert into test values(1);
commit;

prompt otorgando privilegios para que cualquier usuario pueda consultar sus datos
grant select on test to public;

prompt conectando como user01 as sysdba
connect user01/user01 as sysdba

prompt mostrando usuario:
show user

-- funcion sys_context parameters ejemplo
--SELECT SYS_CONTEXT('SYS_SESSION_ROLES', 'RESOURCE') FROM DUAL
prompt mostrando el esquema:
select sys_context('USERENV','CURRENT_SCHEMA') as schema from dual;

prompt mostrando el método de autenticación
select sys_context('USERENV','AUTHENTICATION_METHOD') as auth_method from dual;

prompt mostrando los datos de la test  ¿se podra?  sí se puede !
select * from user01.test;

prompt conectando como user01 as sysoper
connect user01/user01 as sysoper

prompt mostrando usuario:
show user

prompt mostrando usuario2:
select sys_context('USERENV','CURRENT_USER') as schema from dual;

prompt mostrando el esquema: 
select sys_context('USERENV','CURRENT_SCHEMA') as schema from dual;

prompt mostrando el método de autenticación
select sys_context('USERENV','AUTHENTICATION_METHOD') as auth_method from dual;

pause mostrando los datos de la test ¿se podrá? - sí
select * from user01.test;

--prompt otorgando privilegio para que cualquier usuario pueda leer los datos 
--prompt de la tabla test
--connect user01/user01
--grant select on test to public; 

prompt conectando como usuario user02
connect user02/user02

prompt consultando la tabla publica
select * from user01.test;

prompt conectando como usuario user03
connect user03/user03

prompt consultando la tabla publica
select * from user01.test;

prompt aplicando limpieza
connect user01/user01 as sysdba 

--no realiza la limpieza 
--la instancia me da privilegios de sysdba pero en realidad estoy 
--haciendo uso de los datos de la cuenta user01
--connect sys/system1 as sysdba

prompt mostrando usuario:
show user

prompt mostrando el esquema:
select sys_context('USERENV','CURRENT_SCHEMA') as schema from dual;

prompt mostrando el método de autenticación
select sys_context('USERENV','AUTHENTICATION_METHOD') as auth_method from dual;


drop user user01 cascade;
drop user user02;
drop user user03;

disconnect
