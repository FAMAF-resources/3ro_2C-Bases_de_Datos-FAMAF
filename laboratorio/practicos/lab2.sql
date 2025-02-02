CREATE DATABASE world;
USE world;

CREATE TABLE country ( `Code` char(3) NOT NULL AUTO_INCREMENT DEFAULT '', 
`CountryName` varchar(60) NOT NULL DEFAULT '', 
`Continent` varchar(30) NOT NULL DEFAULT '',
`Region` varchar(60) NOT NULL DEFAULT '',
`SurfaceArea` numeric(20, 2) NOT NULL DEFAULT '0.00',
`IndepYear` smallint DEFAULT '0',
`Population` int NOT NULL DEFAULT '0',
`LifeExpectancy` smallint DEFAULT '0',
`GNP` numeric(40, 3) NOT NULL DEFAULT '0.000',
`GNPOld` numeric(40, 3) DEFAULT '0.000',
`LocalName` varchar(60) DEFAULT '',
`GovernmentForm` varchar(60) NOT NULL DEFAULT '',
`HeadOfState` varchar(60) DEFAULT '',
`Capital` int DEFAULT '0',
`Code2` char(2) NOT NULL DEFAULT '',
PRIMARY KEY (`Code`));


CREATE TABLE city (
`ID` int NOT NULL AUTO_INCREMENT,
`CityName` varchar(60) NOT NULL DEFAULT '',
`CountryCode` char(3) NOT NULL DEFAULT '',
`District` varchar(40) NOT NULL DEFAULT '',
`Population` int NOT NULL DEFAULT '0',
PRIMARY KEY (`ID`),
KEY `CountryCode` (`CountryCode`), 
CONSTRAINT `fk_city_country` FOREIGN KEY (`CountryCode`) REFERENCES `country` (`Code`)
);


CREATE TABLE countrylanguage (
`CountryCode` char(3) NOT NULL DEFAULT '',
`Language` varchar(30) NOT NULL DEFAULT '',
`IsOfficial` enum('T', 'F') NOT NULL DEFAULT 'F',
`Percentage` numeric(5, 2) NOT NULL DEFAULT '0.0',
PRIMARY KEY (`CountryCode`, `Language`),
KEY `CountryCode` (`CountryCode`), 
CONSTRAINT `fk_countrylanguage_country` FOREIGN KEY (`CountryCode`) REFERENCES `country` (`Code`)
);


CREATE TABLE continent (
`ContinentName` varchar(30) NOT NULL DEFAULT '',
`ContinentArea` int NOT NULL DEFAULT '0',
`LandmassPercent` numeric(4, 2) NOT NULL DEFAULT '0.0',
`MostPopulousCity` varchar(60) DEFAULT '',
PRIMARY KEY (`ContinentName`)
);

ALTER TABLE country ADD CONSTRAINT fk_country_continent FOREIGN KEY (Continent) REFERENCES continent(ContinentName);

INSERT INTO continent VALUES ('Africa', '30370000', '20.4', 'Cairo, Egypt');
INSERT INTO continent VALUES ('Antarctica', '14000000', '9.2', 'McMurdo Station');
INSERT INTO continent VALUES ('Asia', '44579000', '29.5', 'Mumbai, India');
INSERT INTO continent VALUES ('Europe', '10180000', '6.8', 'Instanbul, Turquia');
INSERT INTO continent VALUES ('North America', '24709000', '16.5', 'Ciudad de México, Mexico');
INSERT INTO continent VALUES ('Oceania', '8600000', '5.9', 'Sydney, Australia');
INSERT INTO continent VALUES ('South America', '17840000', '12.0', 'São Paulo, Brazil');


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
UPDATE countrylanguage SET Percentage = '100.0' WHERE CountryCode = 'AIA' AND Language = 'English';
UPDATE countrylanguage SET Percentage = '0.0' WHERE CountryCode = 'AIA' AND Language = 'English';
--7
SELECT * FROM city WHERE District LIKE '%rdoba' AND CountryCode = 'ARG'; -- No me toma la tilde la consola en MySQL
--8
DELETE FROM city WHERE District LIKE '%rdoba' AND CountryCode != 'ARG';
--9
SELECT CountryName, HeadOfState FROM country WHERE HeadOfState LIKE '%John %';
--10
SELECT CountryName, Population FROM country WHERE Population BETWEEN 35000000 AND 45000000;
--11
