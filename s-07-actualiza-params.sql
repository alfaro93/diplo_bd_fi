
prompt actualizando parametros 

/* select name, isdefault, isses_modifiable, issys_modifiable, value
 from v$parameter where name in ('db_domain','nls_date_format','deferred_segment_creation')*/

prompt conectando como sysdba
connect sys/system1 as sysdba

prompt realizando un respaldo 
create pfile from spfile;

prompt modificando el valor de nls_date_format
prompt nivel session
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';

prompt nivel memory:se espera error...
alter system set nls_date_format= 'dd/mm/yyyy hh24:mi:ss' scope=memory;

prompt nivel spfile : ok
alter system set nls_date_format='dd/mm/yyyy hh24:mi:ss' scope=spfile;

prompt nivel spfile y memory: error
alter system set nls_date_format='dd/mm/yyyy hh24:mi:ss' scope=both;

prompt modificando el valor para db_domain

prompt nivel session :error
alter session set db_domain='diplomado.fi.unam.mx';

prompt nivel memory: ERROR
alter system set db_domain='diplomado.fi.unam.mx' scope=memory;

prompt nivel spfile : ok
alter system set db_domain='diplomado.fi.unam.mx' scope=spfile;

prompt  nivel both: error
alter system set db_domain='diplomado.fi.unam.mx' scope=both;

prompt modificando el valor para deferred_segment_creation

prompt nivel session : ok
alter session set deferred_segment_creation=false;
 
prompt nivel memory: ok
alter system set deferred_segment_creation=false scope=memory;

prompt  nivel both: ok
alter system set deferred_segment_creation=false scope=both;

prompt limpieza:

prompt para el parametro nls_date_format
alter system reset nls_date_format scope=spfile;

prompt para db_domain
alter system set db_domain='fi.unam' scope=spfile;

prompt para deferred_segment_creation
alter system reset deferred_segment_creation scope=both;

prompt mostrando nuevamente los valores en session/memory (v$parameter)

col name format a30
col value format a30
col default_value format a30
select name, isdefault, isses_modifiable, issys_modifiable, value, default_value
 from v$parameter where name in ('db_domain','nls_date_format','deferred_segment_creation');

prompt mostrando nuevamente los valores en spfile (v$spparameter)

select name, value from v$spparameter
where name in ('db_domain','nls_date_format','deferred_segment_creation');

