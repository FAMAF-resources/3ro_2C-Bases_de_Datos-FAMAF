--1
CREATE TABLE directors( 
director_id smallint unsigned NOT NULL AUTO_INCREMENT, 
Nombre varchar(100) NOT NULL, 
Apellido varchar(100) NOT NULL, 
NumDePeliculas int NOT NULL DEFAULT '0', 
PRIMARY KEY (director_id)
);

--2
SELECT tab1.*, fi.film_id, fi.title 
FROM (
    SELECT ac.actor_id, ac.first_name, ac.last_name, fa.actor_id AS fa_actor_id, fa.film_id
    FROM actor AS ac INNER JOIN film_actor AS fa
    ON ac.actor_id = fa.actor_id) AS tab1
    INNER JOIN film AS fi
    ON tab1.film_id = fi.film_id
LIMIT 5;
-- NO hay campo directores, me falta coso

--3
ALTER TABLE customer
ADD COLUMN `premium_customer` enum('T', 'F') NOT NULL DEFAULT 'F';

--4
UPDATE customer
SET customer.premium_customer = 'T'
WHERE customer.customer_id IN (
    SELECT tab.customer_id FROM (
        SELECT customer.customer_id, SUM(payment.amount) AS total_spent 
        FROM customer 
        INNER JOIN payment ON customer.customer_id = payment.customer_id 
        GROUP BY customer.customer_id 
        ORDER BY total_spent DESC 
        LIMIT 10
    ) as tab
);

--5
SELECT film.rating, COUNT(*) AS movies 
FROM film  
GROUP BY film.rating 
ORDER BY movies DESC;

--6
SELECT MAX(payment.payment_date), MIN(payment.payment_date) FROM payment;

--7


--8
SELECT address.district, COUNT(*) AS district_rentals  
FROM rental 
INNER JOIN customer ON customer.customer_id = rental.customer_id  
INNER JOIN address ON customer.address_id = address.address_id  
GROUP BY district 
ORDER BY district_rentals DESC 
LIMIT 10;

--9
ALTER TABLE inventory 
ADD COLUMN `stock` INT NOT NULL DEFAULT(5);

--10
DELIMITER //

CREATE TRIGGER `update_stock` AFTER INSERT ON rental
FOR EACH ROW
BEGIN
    UPDATE inventory
    SET inventory.stock = inventory.stock -1
    WHERE inventory.inventory_id = NEW.inventory_id;
END;
//

DELIMITER ;

--11
CREATE TABLE `fines` (
    `rental_id` INT NOT NULL AUTO_INCREMENT,
    `amount` FLOAT(20, 2) DEFAULT(0),
    PRIMARY KEY(`rental_id`),
    CONSTRAINT `fk_fine_rental` FOREIGN KEY (`rental_id`) REFERENCES `rental` (`rental_id`)
);

DELIMITER //

CREATE PROCEDURE `check_date_and_fine`
BEGIN
    
    
END;
//

DELIMITER ;

IF rental.return_date > rental.rental_date THEN
    INSERT INTO fines(rental_id, amount) 
    VALUES(
        rental.rental_id
        SELECT ((rental.return_date - rental.rental_date) / (24*60*60)) 
        FROM rental
    )
END IF


CREATE PROCEDURE `insert_fine` (
    IN r_id INT
)
BEGIN 
    INSERT INTO fines(rental_id, amount) 
    VALUES(
        r_id,
        (
            SELECT ((rental.return_date - rental.rental_date) / (24*60*60)) 
            FROM rental
            WHERE rental.rental_id = r_id
        )
    );
    COMMIT;
END;

CREATE PROCEDURE foo() BEGIN
  DECLARE done BOOLEAN DEFAULT FALSE;
  DECLARE _id BIGINT UNSIGNED;
  DECLARE cur CURSOR FOR SELECT id FROM objects WHERE ...;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done := TRUE;

  OPEN cur;

  testLoop: LOOP
    FETCH cur INTO _id;
    IF done THEN
      LEAVE testLoop;
    END IF;
    CALL testProc(_id);
  END LOOP testLoop;

  CLOSE cur;
END
