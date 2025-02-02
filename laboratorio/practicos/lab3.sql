--1
SELECT city.Name, c.Name, c.Region, c.GovernmentForm 
FROM city INNER JOIN country AS c 
ON city.CountryCode = c.Code 
ORDER BY city.Population DESC LIMIT 10;
--2
SELECT co.Name, ci.Name, co.Capital, ci.ID 
FROM country AS co LEFT JOIN city AS ci
ON co.Capital = ci.ID 
ORDER BY co.Population ASC LIMIT 10;
--3
SELECT co.Name, co.Continent, lang.Language  
FROM country AS co INNER JOIN countrylanguage AS lang 
ON co.Code = lang.CountryCode 
WHERE lang.IsOfficial = 'T';
--4
SELECT co.Name, ci.Name 
FROM country AS co INNER JOIN city AS ci 
ON co.Capital = ci.ID 
ORDER BY co.SurfaceArea DESC LIMIT 20;
--5
SELECT city.Name, lang.Language, lang.Percentage 
FROM city INNER JOIN countrylanguage AS lang 
ON city.CountryCode = lang.CountryCode 
WHERE lang.IsOfficial = 'T' LIMIT 20;
--6
(
SELECT Name, Population 
FROM country 
ORDER BY Population DESC LIMIT 10
) 
UNION 
(
SELECT Name, Population 
FROM country 
ORDER BY Population ASC LIMIT 10);
--7
(
SELECT c.Name 
FROM country AS c INNER JOIN countrylanguage AS lang 
ON c.Code = lang.CountryCode 
WHERE lang.IsOfficial = 'T' AND lang.Language = 'English'
) 
INTERSECT 
(
SELECT c.Name 
FROM country AS c INNER JOIN countrylanguage AS lang 
ON c.Code = lang.CountryCode 
WHERE lang.IsOfficial = 'T' AND lang.Language = 'French');
--8
(
SELECT c.Name 
FROM country AS c INNER JOIN countrylanguage AS lang 
ON c.Code = lang.CountryCode 
WHERE lang.Language = 'English'
) 
EXCEPT 
(
SELECT c.Name 
FROM country AS c INNER JOIN countrylanguage AS lang 
ON c.Code = lang.CountryCode 
WHERE lang.Language = 'Spanish');

--PArte 2
--1: Si, porque hacer un join por igualdad del codigo y despues quedarse solo las filas que son Argentina, es como hacer un join con una tabla donde ya te quedaste las filas que son Argentina
--Se podría decir que el WHERE actúa como un AND en términos de lógioa de selecciones en tablas
--2. No porque hacer el left join con las 2 condiciones (city.codigo=country.codigo y name=ARgentina) hace que generes la tabla que hacía originalmente el INNER JOIN, concatenada con la tabla en que tenés todos los nombres de ciudad asociados a un país NULL
-- con el WHERE name=Argentina después de joinear se descartan de la tabla las filas que tienen nombre de país NULL
