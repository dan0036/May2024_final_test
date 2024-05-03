-- Cоздать базу данных с названием "Human Friends"

DROP DATABASE IF EXISTS Human_Friends;
CREATE DATABASE IF NOT EXISTS Human_Friends;
USE Human_Friends;

-- Создать таблицы, соответствующие иерархии из вашей диаграммы классов.

DROP TABLE IF EXISTS All_animals;

CREATE TABLE IF NOT EXISTS All_animals(
id SERIAL PRIMARY KEY,
animal_subclass_name VARCHAR(45) UNIQUE
);

INSERT INTO All_animals (animal_subclass_name)
VALUES
('Pets'),
('Pack_animals');

SELECT * FROM All_animals;

DROP TABLE IF EXISTS Pets;

CREATE TABLE IF NOT EXISTS Pets (
  id SERIAL PRIMARY KEY,
  type VARCHAR(45) UNIQUE,
  animal_subclass_name VARCHAR(45),
FOREIGN KEY (animal_subclass_name) REFERENCES All_animals(animal_subclass_name) ON DELETE CASCADE ON UPDATE CASCADE 
);

INSERT INTO Pets (type, animal_subclass_name)
VALUES 
('Dogs','Pets'),
('Cats','Pets'),
('Hamsters','Pets');

SELECT * FROM Pets;

DROP TABLE IF EXISTS Pack_animals;

CREATE TABLE IF NOT EXISTS Pack_animals (
  id SERIAL PRIMARY KEY,
  type VARCHAR(45) UNIQUE,
  animal_subclass_name VARCHAR(45),
FOREIGN KEY (animal_subclass_name) REFERENCES All_animals(animal_subclass_name) ON DELETE CASCADE ON UPDATE CASCADE 
);

INSERT INTO Pack_animals (type, animal_subclass_name)
VALUES 
('Horses','Pack_animals'),
('Camels','Pack_animals'),
('Donkeys','Pack_animals');

SELECT * FROM Pack_animals;

DROP TABLE IF EXISTS Dogs;

CREATE TABLE IF NOT EXISTS Dogs (
  id SERIAL PRIMARY KEY,
  nick varchar(45) DEFAULT NULL,
  birthdate date DEFAULT NULL,
  commands varchar(45) DEFAULT NULL,
  type varchar(45) NOT NULL DEFAULT 'Dogs',
  FOREIGN KEY (type) REFERENCES Pets(type) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Cats;

CREATE TABLE IF NOT EXISTS Cats (
  id SERIAL PRIMARY KEY,
  nick varchar(45) DEFAULT NULL,
  birthdate date DEFAULT NULL,
  commands varchar(45) DEFAULT NULL,
  type varchar(45) NOT NULL DEFAULT 'Cats',
  FOREIGN KEY (type) REFERENCES Pets(type) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Hamsters;

CREATE TABLE IF NOT EXISTS Hamsters (
  id SERIAL PRIMARY KEY,
  nick varchar(45) DEFAULT NULL,
  birthdate date DEFAULT NULL,
  commands varchar(45) DEFAULT NULL,
  type varchar(45) NOT NULL DEFAULT 'Hamsters',
  FOREIGN KEY (type) REFERENCES Pets(type) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Horses;

CREATE TABLE IF NOT EXISTS Horses (
  id SERIAL PRIMARY KEY,
  nick varchar(45) DEFAULT NULL,
  birthdate date DEFAULT NULL,
  commands varchar(45) DEFAULT NULL,
  type varchar(45) NOT NULL DEFAULT 'Horses',
  FOREIGN KEY (type) REFERENCES Pack_animals(type) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Camels;

CREATE TABLE IF NOT EXISTS Camels (
  id SERIAL PRIMARY KEY,
  nick varchar(45) DEFAULT NULL,
  birthdate date DEFAULT NULL,
  commands varchar(45) DEFAULT NULL,
  type varchar(45) NOT NULL DEFAULT 'Camels',
  FOREIGN KEY (type) REFERENCES Pack_animals(type) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Donkeys;

CREATE TABLE IF NOT EXISTS Donkeys (
  id SERIAL PRIMARY KEY,
  nick varchar(45) DEFAULT NULL,
  birthdate date DEFAULT NULL,
  commands varchar(45) DEFAULT NULL,
  type varchar(45) NOT NULL DEFAULT 'Donkeys',
  FOREIGN KEY (type) REFERENCES Pack_animals(type) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Заполнить таблицы данными о животных, их командах и датами рождения.

INSERT INTO Dogs (nick, type, birthdate, commands)
VALUES
('Fido','Dogs', '2020-01-01','Sit, Stay, Fetch'),
('Buddy','Dogs','2018-12-10','Sit, Paw, Bark'),
('Bella','Dogs','2019-11-11','Sit, Stay, Roll');

SELECT * FROM Dogs;

INSERT INTO Cats (nick, type, birthdate, commands)
VALUES
('Whiskers','Cats','2019-05-15','Sit, Pounce'),		
('Smudge','Cats','2020-02-20','Sit, Pounce, Scratch'),
('Oliver','Cats','2020-06-30','Meow, Scratch, Jump');

SELECT * FROM Cats;

INSERT INTO Hamsters (nick, type, birthdate, commands)
VALUES
('Hammy','Hamsters','2021-03-10','Roll, Hide'),			
('Peanut','Hamsters','2021-08-01','Roll, Spin');

SELECT * FROM Hamsters;

INSERT INTO Horses
(nick, type, birthdate, commands)
VALUES
('Thunder','Horses','2015-07-21','Trot, Canter, Gallop'),
('Storm','Horses','2014-05-05','Trot, Canter'),
('Blaze','Horses','2016-02-29','Trot, Jump, Gallop');

SELECT * FROM Horses;

INSERT INTO Camels
(nick, type, birthdate, commands)
VALUES
('Sandy','Camels','2016-11-03','Walk, Carry Load'),
('Dune','Camels','2018-12-12','Walk, Sit'),
('Sahara','Camels','2015-08-14','Walk, Run');

SELECT * FROM Camels;

INSERT INTO Donkeys
(nick, type, birthdate, commands)
VALUES
('Eeyore','Donkeys','2017-09-18','Walk, Carry Load, Bray'),
('Burro','Donkeys','2019-01-23','Walk, Bray, Kick');

-- Удалить записи о верблюдах

DELETE FROM Camels;

SELECT * FROM Camels;

-- объединить таблицы лошадей и ослов.

DROP TEMPORARY TABLE IF EXISTS Horses_n_Donkeys;

CREATE TEMPORARY TABLE Horses_n_Donkeys
SELECT * FROM Horses
UNION 
SELECT * FROM Donkeys;

SELECT * FROM Horses_n_Donkeys;

-- Создать новую таблицу для животных в возрасте от 1 до 3 лет и вычислить их возраст с точностью до месяца.

DROP TEMPORARY TABLE IF EXISTS All_of_animals;

CREATE TEMPORARY TABLE IF NOT EXISTS All_of_animals 
		 SELECT nick, birthdate, commands, type, 
         period_diff(EXTRACT( YEAR_MONTH FROM CURDATE()), EXTRACT( YEAR_MONTH FROM (birthdate))) 
         AS Age_in_months FROM Dogs
   UNION SELECT nick, birthdate, commands, type, 
         period_diff(EXTRACT( YEAR_MONTH FROM CURDATE()), EXTRACT( YEAR_MONTH FROM (birthdate))) 
         AS Age_in_months FROM Cats
   UNION SELECT nick, birthdate, commands, type, 
         period_diff(EXTRACT( YEAR_MONTH FROM CURDATE()), EXTRACT( YEAR_MONTH FROM (birthdate))) 
         AS Age_in_months FROM Hamsters
   UNION SELECT nick, birthdate, commands, type, 
         period_diff(EXTRACT( YEAR_MONTH FROM CURDATE()), EXTRACT( YEAR_MONTH FROM (birthdate))) 
         AS Age_in_months FROM Horses
   UNION SELECT nick, birthdate, commands, type, 
         period_diff(EXTRACT( YEAR_MONTH FROM CURDATE()), EXTRACT( YEAR_MONTH FROM (birthdate))) 
         AS Age_in_months FROM Camels
   UNION SELECT nick, birthdate, commands, type, 
         period_diff(EXTRACT( YEAR_MONTH FROM CURDATE()), EXTRACT( YEAR_MONTH FROM (birthdate))) 
         AS Age_in_months FROM Donkeys;

ALTER TABLE All_of_animals
ADD COLUMN id SERIAL PRIMARY KEY FIRST;

SELECT * FROM All_of_animals;

DROP TABLE IF EXISTS Teen_animals;

CREATE TABLE IF NOT EXISTS Teen_animals
SELECT * FROM All_of_animals  
WHERE 
Age_in_months >11 
AND
Age_in_months <37;

SELECT * FROM Teen_animals;

-- Объединить все созданные таблицы в одну, сохраняя информацию о принадлежности к исходным таблицам.


SELECT nick, birthdate, commands, Pets.type, animal_subclass_name AS subclass
FROM Dogs
LEFT JOIN Pets ON Dogs.type = Pets.type
UNION
SELECT nick, birthdate, commands, Pets.type, animal_subclass_name AS subclass
FROM Cats
LEFT JOIN Pets ON Cats.type = Pets.type
UNION
SELECT nick, birthdate, commands, Pets.type, animal_subclass_name AS subclass
FROM Hamsters
LEFT JOIN Pets ON Hamsters.type = Pets.type
UNION
SELECT nick, birthdate, commands, Pack_animals.type, animal_subclass_name AS subclass
FROM Horses
LEFT JOIN Pack_animals ON Horses.type = Pack_animals.type
UNION
SELECT nick, birthdate, commands, Pack_animals.type, animal_subclass_name AS subclass
FROM Camels
LEFT JOIN Pack_animals ON Camels.type = Pack_animals.type
UNION
SELECT nick, birthdate, commands, Pack_animals.type, animal_subclass_name AS subclass
FROM Donkeys
LEFT JOIN Pack_animals ON Donkeys.type = Pack_animals.type;
