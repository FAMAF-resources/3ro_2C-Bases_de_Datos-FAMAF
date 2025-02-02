--1
SELECT city.Name, country.Name
FROM city, country 
WHERE country.Name IN ( 
    SELECT country.Name  FROM country 
    WHERE country.Population < 10000
);

--2
SELECT city.name, city.Population 
FROM city 
WHERE city.Population > (
    SELECT AVG(city.Population) FROM city
);

--3
--Minimo de poblacion de un pais asiatico
--SELECT MIN(asian_countries.Population) FROM (SELECT * FROM country WHERE country.Continent = 'Asia') AS asian_countries;
SELECT city.Name, city.Population FROM city 
WHERE city.Population >= (
    SELECT MIN(asian_countries.Population) 
    FROM (
        SELECT * FROM country 
        WHERE country.Continent = 'Asia'
    ) AS asian_countries
);

--Este un extra, para poder corroborar que efectivamente las ciudades no son de un pais asiatico
SELECT ci.Name, co.Name, co.Continent, ci.Population, co.Code FROM (
    SELECT city.Name, city.Population, city.CountryCode FROM city 
    WHERE city.Population >= (
        SELECT MIN(asian_countries.Population) 
        FROM (
            SELECT * FROM country 
            WHERE country.Continent = 'Asia'
        ) AS asian_countries
    )
) AS ci INNER JOIN (
    SELECT * FROM country
    WHERE country.Continent != 'Asia'
) AS co
WHERE ci.CountryCode = co.Code;

--4
--sub_tabla = (SELECT * FROM countrylanguage WHERE countrylanguage.CountryCode = sp.CountryCode AND countrylanguage.IsOfficial = 'T') AS sub

SELECT co.Code, co.Name, cl.Language, cl.Percentage
FROM country AS co INNER JOIN countrylanguage AS cl 
ON co.Code = cl.CountryCode
WHERE cl.Percentage >= (
    SELECT MAX(sub.Percentage)
    FROM (
        SELECT * FROM countrylanguage 
        WHERE countrylanguage.CountryCode = cl.CountryCode AND countrylanguage.IsOfficial = 'T'
        ) AS sub
    )
AND cl.IsOfficial = 'F';

--5
--ciudades = SELECT co.Region, co.SurfaceArea, ci.Population FROM country AS co INNER JOIN city AS ci ON co.Code = ci.CountryCode WHERE ci.Population > 100000
SELECT DISTINCT ciudades_100k.Region
FROM (
	SELECT co.Region, co.Name, co.SurfaceArea, ci.Population 
	FROM country AS co INNER JOIN city AS ci 
	ON co.Code = ci.CountryCode 
	WHERE ci.Population > 100000
	) AS ciudades_100k 
WHERE ciudades_100k.SurfaceArea < 1000;

--SIN SUBQUERIES
SELECT DISTINCT co.Region, co.Name, co.SurfaceArea, ci.Population
FROM country AS co INNER JOIN city AS ci
ON co.Code = ci.CountryCode
WHERE co.SurfaceArea < 1000 AND ci.Population > 100000;

--6
SELECT co.Code, co.Name, SUM(ci.Population) 
FROM country AS co INNER JOIN city AS ci 
ON co.Code = ci.CountryCode 
GROUP BY co.Code;

--7
--inner = SELECT AVG(coso.Percentage) FROM (  SELECT * FROM countrylanguage WHERE countrylanguage.IsOfficial = 'T') as coso;
SELECT co.Code, co.Name, cl.Language, cl.Percentage, cl.IsOfficial
FROM country AS co INNER JOIN countrylanguage AS cl
WHERE cl.Percentage > 
    (
    SELECT AVG(sub.Percentage) 
    FROM (  
        SELECT * FROM countrylanguage 
        WHERE countrylanguage.IsOfficial = 'T'
        ) as sub
    )
AND cl.IsOfficial = 'F';

--8
SELECT country.Continent, SUM(country.Population) 
FROM country 
GROUP BY country.Continent;

--9
SELECT exp.Continent, exp.LifeExpectancy
FROM (
    SELECT country.Continent, AVG(country.LifeExpectancy) AS 'LifeExpectancy'
    FROM country 
    GROUP BY country.Continent
    ) AS exp
WHERE exp.LifeExpectancy BETWEEN 40 AND 70;

--10
SELECT country.Continent, MIN(country.Population) AS Minima, 
MAX(country.Population) AS Maxima, 
AVG(country.Population) AS Promedio, 
SUM(country.Population) AS Total
FROM country GROUP BY country.Continent;

--Si hubiese que hacerlo por ciudad de cada continente
SELECT co.Continent, MIN(ci.Population) AS Minima, 
MAX(ci.Population) AS Maxima, 
AVG(ci.Population) AS Promedio, 
SUM(ci.Population) AS Total
FROM country AS co INNER JOIN city AS ci
ON co.Code = ci.CountryCode
GROUP BY co.Continent;

---PREGUNTA EXTRA:
-- La forma cochina es agregando la columna city.Name a la query, y desactivando el modo "only full group by" de SQL :)
