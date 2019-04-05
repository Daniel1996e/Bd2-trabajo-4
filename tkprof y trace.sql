

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
