CREATE OR REPLACE PROCEDURE llenar
(k IN NUMBER)
IS
n NUMBER (8):= k;
g VARCHAR (1):='';
d NUMBER (8):=1;
s NUMBER (8):=1;
BEGIN
    delete from empleado;

    FOR i IN 1..n LOOP
        IF(d=20)THEN
            d:=1;
        ELSE
            d:=d+1;
        END IF;
        IF(MOD(i,2)=0)THEN
            g:='m';
        ELSE
            g:='f';
        END IF;
        s:=dbms_random.value(4000,10000);
        
        INSERT INTO empleado VALUES(i,s,d,g);

    END LOOP;
    
END;
/