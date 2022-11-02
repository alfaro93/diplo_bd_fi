prompt conectando como sysdba 
connect sys/system1 as sysdba 

prompt creando un pfile a partir de un SPFILE 
create pfile='/tmp/pfile-spfile.ora' from spfile; 

promp creando un pfile a partir de la instancia (debe estar iniciada ) 
create pfile='/tmp/pfile-memory.ora' from memory; 

prompt modificar permisos ya que el archivo le pertenece a oracle 
prompt proporcionar password del usuario administrador u ordinario del s.o.  
!sudo chmod 777 /tmp/pfile-memory.ora 

pause revisar archivos y detectar diferencias [Enter] para continuar 

promp agregando parametro al pfile /tmp/pfile-memory.ora 
!echo "nls_date_format=dd/mm/yyyy hh24:mi:ss" >> /tmp/pfile-memory.ora 

prompt comprobando el valor del parametro nls_date_format 
select sysdate from dual; 

prompt deteniendo la instancia 

shutdown immediate 

prompt iniciando instancia empleando el pfile /tmp/pfile-memory.ora 
startup pfile='/tmp/pfile-memory.ora' 

prompt creando spfile de /tmp/pfile-memory.ora
create spfile='/tmp/spfile-pfile.ora' from pfile='/tmp/pfile-memory.ora';

prompt modificar permisos ya que el archivo le pertenece a oracle 
prompt proporcionar password del usuario administrador u ordinario del s.o.  
!sudo chmod 777 /tmp/spfile-pfile.ora 

prompt comprobando el valor del parametro nls_date_format 
select sysdate from dual; 

prompt deteniendo la instancia 
shutdown immediate 

prompt iniciando instancia empleando el spfile /tmp/spfile-pfile.ora 
startup pfile='/tmp/spf_init.ora' 
 

prompt modificar el valor del parametro nls_date_format en el spfile 

pause ¿qué pasará?  

 

prompt no modificara porque inicio con pfile 

alter system nls_date_format="dd/mm/yyyy" scope=spfile; 




