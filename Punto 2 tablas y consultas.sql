--tablas--

CREATE TABLE s(sn NUMBER(8) PRIMARY KEY, 
snombre VARCHAR(30) NOT NULL, ciudad VARCHAR(10) NOT NULL);

CREATE TABLE p(pn NUMBER(8) PRIMARY KEY, 
pnombre VARCHAR (30) NOT NULL);

CREATE TABLE sp(sn NUMBER(8) REFERENCES s, 
pn NUMBER(8) REFERENCES p, 
canti NUMBER(8) NOT NULL CHECK (canti > 0), PRIMARY KEY (sn,pn));

--consultas--

--a) Consulta propuesta por Candice Swanepoel:--

SELECT s1.*
FROM s s1
WHERE (SELECT COUNT(*) FROM p) = 
               (SELECT COUNT(*) FROM sp WHERE sp.sn = s1.sn);

--b) Consulta propuesta por Emilia Clarke:--

SELECT *
FROM s
WHERE sn IN(SELECT sn 
                          FROM sp
                          GROUP BY sn
                          HAVING COUNT(*) = (SELECT COUNT(*) FROM p));
--c) Consulta propuesta por Barbara Palvin:--

SELECT *
FROM s
WHERE sn IN
(SELECT DISTINCT sn
 FROM (SELECT sn, COUNT(*) OVER (PARTITION BY sn) AS total
               FROM sp) 
               NATURAL JOIN 
               (SELECT COUNT(*) AS total FROM p)
);

--d) Pequeña modificación propuesta por Lena Headey:--
--Quitar el DISTINCT en la consulta c).--

--e) Variante propuesta por El Perro (Sandor Clegane):--

SELECT *
FROM
(SELECT DISTINCT sn
 FROM (SELECT sn, COUNT(*) OVER (PARTITION BY sn) AS total
               FROM sp) 
               NATURAL JOIN 
               (SELECT COUNT(*) AS total FROM p)
) NATURAL JOIN s;

