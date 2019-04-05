--Codigos para el TKPROF--
ALTER SESSION SET SQL_TRACE = TRUE; 
ALTER SESSION SET TIMED_STATISTICS=TRUE; 
SELECT spid FROM sys.v_$process 
WHERE addr = (SELECT paddr FROM sys.v_$session
              WHERE audsid = USERENV('sessionid')
             ); 


--Le da la ruta para TKPROF--
select tracefile  from v$process 
where addr = (select paddr from v$session 
              where sid=userenv('sid'));

--Limpiar cacha--
ALTER SYSTEM flush buffer_cache;

--EXPLAIN PLAN--
EXPLAIN PLAN FOR
SELECT depto, sexo, SUM(salario) AS  ts
FROM empleado
GROUP BY depto, sexo;

SELECT *
FROM table(DBMS_XPLAN.DISPLAY);

--Permisos para sys as sysdba--
GRANT ALTER SESSION TO sys;
ALTER SESSION SET SQL_TRACE = TRUE;

ALTER SESSION SET TIMED_STATISTICS=TRUE;
--DBMS_SESSION.SET_SQL_TRACE(TRUE); (SOLO PL SQL)

SELECT value AS ruta_d
FROM v$parameter 
WHERE name = 'user_dump_dest';

SELECT spid FROM sys.v_$process
WHERE addr = (SELECT paddr FROM sys.v_$session
              WHERE audsid = USERENV('sessionid'));


EXPLAIN PLAN FOR
SELECT depto, SUM(ts) As tds
FROM totaldepsex
GROUP BY depto;



SELECT spid FROM sys.v_$process
WHERE addr = (SELECT paddr FROM sys.v_$session
              WHERE audsid = USERENV('sessionid')
             );

grant execute on dbms_monitor to sys;

grant select on v_$session to sys;

grant select on v_$process to sys;

 C:\oraclexe\app\oracle\diag\rdbms\xe\xe\trace
tkprof xe_ora_12676_test.trc  C:\temp\archivosalida.txt

EXPLAIN PLAN 
SET STATEMENT_ID = 'P1' FOR
SELECT e.*,
               SUM(salario) OVER (PARTITION BY depto, sexo) AS ts,
               SUM(salario) OVER (PARTITION BY depto) AS tsd
FROM empleado e;
