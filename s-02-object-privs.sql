Prompt conectando como sysdba
conn sys/system1 as sysdba

Prompt creando usuarios
create user user01 identified by user01 quota unlimited on users;
create user guest01 identified by guest01 quota unlimited on users;

Prompt otorgando privilegios de sistema
grant create session, create table to user01;

Prompt otorgando privilegios de sistema
grant create session to guest01;

Prompt creando al usuario guest02, otorgando privilegios al mismo tiempo
grant create session to guest02 identified by guest02;
alter user guest02 quota 10M on users; 

Prompt permitir a guest02 la posibilidad de otorgar privilegios de objeto 
Prompt a cualquier usuario
grant grant any object privilege to guest02;

Prompt conectando como user01
connect user01/user01

Prompt creando tabla de prueba
create table test(id number);
insert into test (id) values (1);
commit;

Prompt conectando como guest01
connect guest01/guest01

Prompt intentar consultar datos de la tabla test del esquema user01
pause ¿Qué sucederá si se intenta acceder a user01.test ? [enter]
select * from user01.test;

Prompt otorgando privilegio de objeto (select) a guest01 

Prompt conectando como user01
connect user01/user01

grant select on test to guest01;
-- SYS también podría otorgar el privilegio:
-- diciendo qué objeto de qué usuario
-- grant select on user01.test to guest01;

Prompt conectando como guest01 para validar acceso
connect guest01/guest01

pause ¿Qué sucederá ahora ? el usuario guest01 ¿podrá acceder a la tabla test ? 
select * from user01.test;

Prompt  conectando como guest02
connect guest02/guest02
grant insert on user01.test to guest01;

Prompt comprobando privilegio de insercion para guest01
connect guest01/guest01
pause ¿será posible insertar en user01.test
insert into user01.test (id) values(2);

select * from user01.test;
--al eliminar los usuarios se eliminan todos los permisos y objetos
--que le pertenece

Prompt limpieza:
connect sys/system1 as sysdba
drop user user01 cascade;
drop user guest01;
drop user guest02;

disconnect







