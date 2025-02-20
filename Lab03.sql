DROP TABLE digimon;
DROP TABLE tamer;
CREATE TABLE digimon(
    digi_id INT,
    name VARCHAR2(50),
    stage VARCHAR2(20),
    attribute VARCHAR2(20),
    hp INT,
    attack INT,
    defense INT,
    speed INT,
    CONSTRAINT PK_digi_id PRIMARY KEY(digi_id)
);

CREATE TABLE tamer(
    tamer_id INT,
    first_name VARCHAR2(30),
    last_name VARCHAR2(30),
    city VARCHAR2(30),
    age INT,
    CONSTRAINT PK_tamer_id PRIMARY KEY(tamer_id)
);

INSERT INTO digimon (digi_ID, name, stage, attribute, hp, attack, defense, speed) VALUES (1, 'Agumon', 'Rookie', 'Vaccine', 45, 50, 40, 65);
INSERT INTO digimon (digi_ID, name, stage, attribute, hp, attack, defense, speed) VALUES (2, 'Greymon', 'Champion', 'Vaccine', 60, 65, 55, 75);
INSERT INTO digimon (digi_ID, name, stage, attribute, hp, attack, defense, speed) VALUES (3, 'MetalGreymon', 'Ultimate', 'Vaccine', 80, 85, 75, 85);
INSERT INTO digimon (digi_ID, name, stage, attribute, hp, attack, defense, speed) VALUES (4, 'Gabumon', 'Rookie', 'Data', 40, 45, 35, 60);
INSERT INTO digimon (digi_ID, name, stage, attribute, hp, attack, defense, speed) VALUES (5, 'Garurumon', 'Champion', 'Data', 58, 63, 53, 80);
INSERT INTO digimon (digi_ID, name, stage, attribute, hp, attack, defense, speed) VALUES (6, 'WereGarurumon', 'Ultimate', 'Data', 78, 83, 73, 90);
INSERT INTO digimon (digi_ID, name, stage, attribute, hp, attack, defense, speed) VALUES (7, 'Biyomon', 'Rookie', 'Vaccine', 44, 48, 38, 70);
INSERT INTO digimon (digi_ID, name, stage, attribute, hp, attack, defense, speed) VALUES (8, 'Birdramon', 'Champion', 'Vaccine', 59, 63, 53, 80);
INSERT INTO digimon (digi_ID, name, stage, attribute, hp, attack, defense, speed) VALUES (9, 'Garudamon', 'Ultimate', 'Vaccine', 79, 83, 73, 100);
INSERT INTO digimon (digi_ID, name, stage, attribute, hp, attack, defense, speed) VALUES (10, 'Tentomon', 'Rookie', 'Vaccine', 35, 40, 30, 55);
INSERT INTO digimon (digi_ID, name, stage, attribute, hp, attack, defense, speed) VALUES (11, 'Kabuterimon', 'Champion', 'Vaccine', 60, 65, 55, 75);
INSERT INTO digimon (digi_ID, name, stage, attribute, hp, attack, defense, speed) VALUES (12, 'Palmon', 'Rookie', 'Data', 42, 46, 36, 68);

INSERT INTO tamer (tamer_id, first_name, last_name, city, age) VALUES (1, 'Tai', 'Kamiya', 'Odaiba', 11);
INSERT INTO tamer (tamer_id, first_name, last_name, city, age) VALUES (2, 'Matt', 'Ishida', 'Odaiba', 11);
INSERT INTO tamer (tamer_id, first_name, last_name, city, age) VALUES (3, 'Sora', 'Takenouchi', 'Odaiba', 11);
INSERT INTO tamer (tamer_id, first_name, last_name, city, age) VALUES (4, 'Izzy', 'Izumi', 'Odaiba', 10);
INSERT INTO tamer (tamer_id, first_name, last_name, city, age) VALUES (5, 'Mimi', 'Tachikawa', 'Odaiba', 10);
INSERT INTO tamer (tamer_id, first_name, last_name, city, age) VALUES (6, 'Joe', 'Kido', 'Odaiba', 12);

SELECT DISTINCT stage FROM digimon;
SELECT name FROM digimon WHERE name LIKE '%a%' OR name LIKE '%o%' OR name LIKE '%i%' OR name LIKE '%o%' OR name LIKE '%u%';

SELECT * FROM tamer WHERE age > 10;

SELECT * FROM digimon WHERE name LIKE '%Garu%';

SELECT * FROM digimon WHERE name LIKE 'M%' AND name LIKE '%mon';

SELECT first_name || ' ' || last_name AS full_name, age FROM tamer;

SELECT * FROM digimon ORDER BY attribute ASC;
SELECT * FROM digimon ORDER BY speed DESC;

SELECT name, stage, attack FROM digimon WHERE attribute != 'vaccine' AND speed > (0.75 * (SELECT speed FROM digimon where name = 'Garudamon'));


CREATE TABLE tamer_digimon(
    tamer_id INT,
    digi_id INT,
    partner_level VARCHAR2(20),
    CONSTRAINT check_partner_level CHECK (partner_level IN ('Primary', 'Secondary')),
    CONSTRAINT FK_tamer_id FOREIGN KEY(tamer_id) REFERENCES tamer(tamer_id),
    CONSTRAINT FK_digi_id FOREIGN KEY(digi_id) REFERENCES digimon(digi_id)
);
