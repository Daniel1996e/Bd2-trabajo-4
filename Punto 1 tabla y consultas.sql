-- Tabla --
Drop table empleado;
CREATE TABLE empleado(
codigo NUMBER(8) PRIMARY KEY, 
salario NUMBER(8) NOT NULL, 
depto NUMBER(8) NOT NULL,
sexo CHAR(1) NOT NULL CHECK(sexo = 'm' OR sexo = 'f'));

--consultas--
--a) Consulta propuesta por Godzilla:--

SELECT e.*, SUM(salario) OVER (PARTITION BY depto, sexo) AS ts, SUM(salario) OVER (PARTITION BY depto) AS tsd
FROM empleado e;

--b) Consulta propuesta por King Kong:--

SELECT e.*,
               (SELECT SUM(salario) 
                FROM empleado e1
                WHERE e1.depto = e.depto AND e1.sexo = e.sexo) AS ts,
               (SELECT SUM(salario) 
                FROM empleado e1
                WHERE e1.depto = e.depto) AS tsd
FROM empleado e;

--c) Consulta propuesta por el trío infernal: Diamanda Galas, The Red Woman y Chucky:--

--La Serpenta crea esta vista:--
CREATE view totaldepsex AS
SELECT depto, sexo, SUM(salario) AS ts
FROM empleado
GROUP BY depto, sexo;
--Carice van Houten contribuye con esta:--
CREATE view totaldep AS
SELECT depto, SUM(ts) AS tds
FROM totaldepsex
GROUP BY depto;
--Finalmente, el muñeco diabólico ensambla todo y hace esta consulta:--
SELECT *
FROM empleado NATURAL JOIN totaldepsex NATURAL JOIN totaldep;
