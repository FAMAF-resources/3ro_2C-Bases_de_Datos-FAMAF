use olympics; 
# EJERCICIO 1
ALTER TABLE `person`
ADD COLUMN `total_medals` smallint unsigned NOT NULL DEFAULT '0'
AFTER `weight`;

############
# EJERCICIO 2
# El update individual dentro del while me funciona, probe muchas alternativas pero no logro que ande el while en si

DELIMITER $$
CREATE PROCEDURE update_medals_count()

BEGIN
DECLARE i int;
DECLARE filas int;
SET i = 0;
SET filas = (SELECT COUNT(*) FROM person);

WHILE i < filas
    UPDATE `person`
    SET person.total_medals = (
	SELECT SUM(medallas) FROM (
	    SELECT COUNT(medal_id) AS medallas 
	    FROM competitor_event AS ce 
            WHERE ce.competitor_id IN (
                SELECT id 
	    FROM games_competitor 
	    WHERE person_id = person.id
	    ) 
	    AND medal_id != 4 
	    GROUP BY medal_id)
	AS tabla
    )
    WHERE person.id = fila.id
    SET i = i+1;
END WHILE

END
DELIMITER ;
