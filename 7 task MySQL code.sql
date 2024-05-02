DROP DATABASE IF EXISTS May24_final_test;
CREATE DATABASE IF NOT EXISTS May24_final_test;
USE May24_final_test;

DROP TABLE IF EXISTS Pets;

CREATE TABLE IF NOT EXISTS `Pets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `Nick` varchar(45) DEFAULT NULL,
  `Type` varchar(45) DEFAULT NULL,
  `Birthdate` date DEFAULT NULL,
  `Commands` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS Pack_animals;

CREATE TABLE IF NOT EXISTS `Pack_animals` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `Nick` varchar(45) DEFAULT NULL,
  `Type` varchar(45) DEFAULT NULL,
  `Birthdate` date DEFAULT NULL,
  `Commands` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO Pets
(Nick, Type, Birthdate, Commands)
VALUES
('Fido',	'Dog', '2020-01-01',	'Sit, Stay, Fetch'),
('Whiskers','Cat','2019-05-15','Sit, Pounce'),		
('Hammy','Hamster','2021-03-10','Roll, Hide'),			
('Buddy','Dog','2018-12-10','Sit, Paw, Bark'),
('Smudge','Cat','2020-02-20','Sit, Pounce, Scratch'),
('Peanut','Hamster','2021-08-01','Roll, Spin'),
('Bella','Dog','2019-11-11','Sit, Stay, Roll'),
('Oliver','Cat','2020-06-30','Meow, Scratch, Jump');

INSERT INTO Pack_animals
(Nick, Type, Birthdate, Commands)
VALUES
('Thunder','Horse','2015-07-21','Trot, Canter, Gallop'),
('Sandy','Camel','2016-11-03','Walk, Carry Load'),
('Eeyore','Donkey','2017-09-18','Walk, Carry Load, Bray'),
('Storm','Horse','2014-05-05','Trot, Canter'),
('Dune','Camel','2018-12-12','Walk, Sit'),
('Burro','Donkey','2019-01-23','Walk, Bray, Kick'),
('Blaze','Horse','2016-02-29','Trot, Jump, Gallop'),			
('Sahara','Camel','2015-08-14','Walk, Run');

SELECT * FROM Pets; -- 01
SELECT * FROM Pack_animals; -- 02

SELECT * FROM Pets -- 03
UNION 
SELECT * FROM Pack_animals;

DELETE FROM Pack_animals
WHERE Type = 'Camel';

SELECT * FROM Pack_animals; -- 04

SELECT * FROM Pack_animals -- 05
WHERE Type = 'Horse'
UNION
SELECT * FROM Pack_animals 
WHERE Type = 'Donkey';

DROP TABLE IF EXISTS Teen_animals;

CREATE TABLE IF NOT EXISTS Teen_animals 
SELECT * FROM Pets  
WHERE 
period_diff(EXTRACT( YEAR_MONTH FROM CURDATE()), EXTRACT( YEAR_MONTH FROM (Birthdate))) >11 
AND
period_diff(EXTRACT( YEAR_MONTH FROM CURDATE()), EXTRACT( YEAR_MONTH FROM (Birthdate))) <37
UNION 
SELECT * FROM Pack_animals  
WHERE 
period_diff(EXTRACT( YEAR_MONTH FROM CURDATE()), EXTRACT( YEAR_MONTH FROM (Birthdate))) >11 
AND
period_diff(EXTRACT( YEAR_MONTH FROM CURDATE()), EXTRACT( YEAR_MONTH FROM (Birthdate))) <37;

SELECT * FROM Teen_animals; -- 06

ALTER TABLE Teen_animals
ADD Age INT;

SELECT * FROM Teen_animals; -- 07

INSERT INTO Teen_animals (Age)
SELECT period_diff(EXTRACT( YEAR_MONTH FROM CURDATE()), EXTRACT( YEAR_MONTH FROM (Birthdate)))
FROM Teen_animals;

SELECT * FROM Teen_animals; -- 08

ALTER TABLE Teen_animals
DROP COLUMN Age;

DELETE FROM Teen_animals
WHERE Nick IS NULL;

SELECT * FROM Teen_animals; -- 09

DROP TABLE IF EXISTS Common_list;

CREATE TABLE IF NOT EXISTS Common_list (
id SERIAL PRIMARY KEY,
Nick VARCHAR(45),
Type VARCHAR(45),
Birthdate DATE,
Commands VARCHAR(45),
Table_group VARCHAR(45)
);

INSERT INTO Common_list (Nick, Type, Birthdate, Commands, Table_group)
SELECT Nick, Type, Birthdate, Commands, 'Pets'
FROM Pets
UNION
SELECT Nick, Type, Birthdate, Commands, 'Pack_animals'
FROM Pack_animals
UNION
SELECT Nick, Type, Birthdate, Commands, 'Teen_animals'
FROM Teen_animals;

SELECT * FROM Common_list; -- 10