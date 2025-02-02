
-- Parte 2
--1
SELECT CountryName, Region from country ORDER BY CountryName, Region;
--2
SELECT CityName, Population FROM city ORDER BY Population DESC LIMIT 10;
--3
SELECT CountryName, Region, SurfaceArea, GovernmentForm FROM country ORDER BY SurfaceArea ASC LIMIT 10;
--4
SELECT CountryName, GovernmentForm FROM country WHERE IndepYear IS NULL;
--5
SELECT Language, Percentage FROM countrylanguage WHERE IsOfficial = 'T';
--extra, 6
UPDATE countrylanguage SET Percentage = '100.0' WHERE CountryCode = 'AIA';
--7
SELECT * FROM city WHERE District LIKE '%rdoba' AND CountryCode = 'ARG'; -- No me toma la tilde la consola en MySQL
--8
DELETE FROM city WHERE District LIKE '%rdoba' AND CountryCode != 'ARG';
--9
SELECT CountryName, HeadOfState FROM country WHERE HeadOfState LIKE '%John %';
--10
SELECT CountryName, Population FROM country WHERE Population BETWEEN 35000000 AND 45000000;
--11
