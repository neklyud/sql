CREATE DEFINER=`root`@`localhost` PROCEDURE `flag_maker`()
BEGIN
DECLARE k INTEGER;
DECLARE sem,mark_info,idex,idst,what_,lf INT;
DECLARE dateexam varchar(20);
DECLARE done INTEGER DEFAULT 0;
DECLARE c1 CURSOR for(SELECT * FROM tab);
DECLARE c2 CURSOR for(SELECT * FROM tab);
declare continue handler for sqlstate '02000' set done=1;
OPEN c1;
OPEN c2;
SET k=0;
SET lf=0;
WHILE done=0 DO
    BEGIN
    WHILE k!=3 DO
        BEGIN
            FETCH c2 INTO idst,idex,what_,sem,dateexam,mark_info;
            SET k=k+1;
            SET lf=mark_info+lf;
        END;
    END WHILE;
SET k=0;
IF lf=0 THEN
    BEGIN
        WHILE k!=2 DO
            BEGIN
                FETCH c1 INTO idst,idex,what_,sem,dateexam,mark_info;
                SET k=k+1;
                IF done=0 THEN
                    INSERT new_tab values(idst,NULL,what_,sem,dateexam,'-',0);
                END IF;
            END;
        END WHILE;
        FETCH c1 INTO idst,idex,what_,sem,dateexam,mark_info;
        IF done=0 THEN
            INSERT new_tab values(idst,NULL,what_,sem,dateexam,'-',1);
        END IF;
    END;
ELSE
    BEGIN
        WHILE k!=2 DO
            BEGIN
                FETCH c1 INTO idst,idex,what_,sem,dateexam,mark_info;
                SET k=k+1;
                IF done=0 THEN
                    INSERT new_tab values(idst,NULL,what_,sem,dateexam,'+',0);
                END IF;
            END;
        END WHILE;
        FETCH c1 INTO idst,idex,what_,sem,dateexam,mark_info;
        IF done=0 THEN
            INSERT new_tab values(idst,NULL,what_,sem,dateexam,'+',0);
        END IF;
    END;
END IF;
SET lf=0;
SET k=0;
END;
END WHILE;
CLOSE c2;
CLOSE c1;
END