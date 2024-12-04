/*
Student name:  Yusuf Ahmed
Student ID: 240013970
*/

/* SECTION 1 - CREATE TABLE STATEMENTS */

CREATE TABLE visitors (
    visitorID int(4) PRIMARY KEY,
    visitor_name     VARCHAR(255),
    visitor_age      int(3),
    visitor_email    varchar(255)
);

CREATE TABLE all_staff (
	staff_name               varchar(255),
	staff_ID                 int(4) PRIMARY KEY,
	staff_InsuranceReference varchar(4),
	staff_age                varchar(8),
	staff_email              varchar(255),
	staff_extension          int(3),
	staff_mobileNo           int(11)
);

CREATE TABLE special_clearance (
	clearance_level        int(2),
	staff_ID               varchar(20) PRIMARY KEY,
	FOREIGN KEY (staff_ID) REFERENCES all_staff (staff_ID)
);

CREATE TABLE operation_team (
	team_ID      varchar(4) PRIMARY KEY,
	teamSize     int(2),
	current_task varchar(255) IS NULL,
	leader_ID    int(2),
	FOREIGN KEY (leader_ID) REFERENCES special_clearance (staff_ID)
);

/* SECTION 2 - INSERT STATEMENTS */

INSERT INTO allstaff VALUES
	('John Doe', 1001, 'INS1', '34', 'johndoe@example.com', 101, 9876543210),
	('Jane Smith', 1002, 'INS2', '29', 'janesmith@example.com', 102, 9876543211),
	('Alice Brown', 1003, 'INS3', '45', 'alicebrown@example.com', 103, 9876543212),
	('Bob Johnson', 1004, 'INS4', '37', 'bobjohnson@example.com', 104, 9876543213),
	('Charlie White', 1005, 'INS5', '41', 'charliewhite@example.com', 105, 9876543214),
	('Emma Green', 1006, 'INS6', '30', 'emmagreen@example.com', 106, 9876543215),
	('Liam Black', 1007, 'INS7', '33', 'liamblack@example.com', 107, 9876543216),
	('Olivia Blue', 1008, 'INS8', '28', 'oliviablue@example.com', 108, 9876543217),
	('Noah Brown', 1009, 'INS9', '50', 'noahbrown@example.com', 109, 9876543218),
	('Sophia Gray', 1010, 'INS10', '36', 'sophiagray@example.com', 110, 9876543219),
	('Ethan White', 1011, 'INS11', '32', 'ethanwhite@example.com', 111, 9876543220),
	('Ava Green', 1012, 'INS12', '27', 'avagreen@example.com', 112, 9876543221),
	('Mason Black', 1013, 'INS13', '39', 'masonblack@example.com', 113, 9876543222),
	('Isabella Yellow', 1014, 'INS14', '26', 'isabellayellow@example.com', 114, 9876543223),
	('Logan Purple', 1015, 'INS15', '35', 'loganpurple@example.com', 115, 9876543224);

INSERT INTO visitors VALUES
	(2001, 'Michael Johnson', 45, 'michael.johnson@example.com'),
	(2002, 'Sarah Williams', 32, 'sarah.williams@example.com'),
	(2003, 'David Brown', 29, 'david.brown@example.com'),
	(2004, 'Emily Davis', 34, 'emily.davis@example.com'),
	(2005, 'James Wilson', 40, 'james.wilson@example.com'),
	(2006, 'Linda Martinez', 50, 'linda.martinez@example.com'),
	(2007, 'Robert Anderson', 38, 'robert.anderson@example.com'),
	(2008, 'Patricia Thomas', 42, 'patricia.thomas@example.com'),
	(2009, 'Christopher Moore', 28, 'christopher.moore@example.com'),
	(2010, 'Elizabeth Jackson', 36, 'elizabeth.jackson@example.com'),
	(2011, 'Daniel Thompson', 31, 'daniel.thompson@example.com'),
	(2012, 'Jessica Martin', 27, 'jessica.martin@example.com'),
	(2013, 'Matthew Harris', 33, 'matthew.harris@example.com'),
	(2014, 'Ashley Clark', 35, 'ashley.clark@example.com'),
	(2015, 'Jack Wall', 41, 'j.wall@example.com');

INSERT INTO special_clearance VALUES
	(1, 1001),
	(2, 1002),
	(3, 1003),
	(4, 1004),
	(5, 1005),
	(1, 1006),
	(2, 1007),
	(3, 1008),
	(4, 1009),
	(5, 1010),
	(1, 1011),
	(2, 1012),
	(3, 1013),
	(4, 1014),
	(5, 1015);

INSERT INTO operation_team VALUES
(1, 5, "", 1001),
(2, 4, "", 1009),
(3, 6, "", 1009),
(4, 3, 'Operating', 1001),
(5, 7, 'Standby', 1009),
(6, 8, 'Operating', 1001),
(7, 5, 'Operating', 1007),
(8, 6, 'Operating', 1003),
(9, 4, 'Standby', 1009),
(10, 3, 'Standby', 1011),
(11, 7, 'Operating', 1011),
(12, 9, 'Standby', 1013),
(13, 4, 'Operating', 1013),
(14, 5, "", 1015),
(15, 6, 'Standby', 1015);

/* SECTION 3 - UPDATE STATEMENTS - The queries must be explained in natural (English) language first, and then followed up by respective statements */

/* 1) Change team 3 to Standby. */

UPDATE operation_team SET # = '' WHERE name = 'Hashim Amla';

/* 2) All players of 30 years old should be of 31 years. */

UPDATE mccPlayer SET age = 31 WHERE age = 30;


/* SECTION 4 - SINGLE TABLE SELECT STATEMENTS - The queries must be explained in natural (English) language first, and then followed up by respective SELECTs */


/* 1) List the names of all grounds in London sorted in reverse-lexicographical order. */

SELECT ground_name
FROM mccGround
WHERE g_town = 'London'
ORDER BY ground_name DESC;


/* 2) List all the details of the player whose name is 'Shane Watson'. */


SELECT *
FROM mccPlayer
WHERE name ='Shane Watson';


/* 3) List the dates of any matches played against the opposing team 'Darlington'. */

SELECT match_date
FROM mccMatches
WHERE opposing_team = 'Darlington';


/* 4) List the names of players who are more than 30 years old and live in 'Morpeth' or 'Alnwick'. */

SELECT name
FROM mccPlayer
WHERE (p_town = 'Morpeth' OR p_town = 'Alnwick') AND age > 30;


/* 5) What is the highest batting score made since 2012? */

SELECT MAX(batting_score)
FROM mccMatch_performance
WHERE match_date > 120100;


/* 6) What is the average batting score of all match performances? */

SELECT AVG(batting_score)
FROM mccMatch_performance;


/* SECTION 5 MULTIPLE TABLE SELECT StATEMENTS - The queries must be explained in natural (English) language first, and then followed up by respective SELECTs*/


/* 1) List the names of the teams, the ground names and street names that MCC have played against at grounds located in the town Tynemouth. */

SELECT opposing_team, G.ground_name, g_street
FROM mccMatches M
INNER JOIN mccGround G
ON M.ground_name = G.ground_name
WHERE g_town = 'Tynemouth';


/* 2) List the names of players who had a batting score of zero on the 5th July 2013? */

SELECT name
FROM mccPlayer P
INNER JOIN mccMatch_performance MP
ON P.registration_number = MP.registration_number
WHERE batting_score = 0
AND match_date = 130705;


/* 3) List the names of the grounds that 'Shane Watson' has played at. */

SELECT ground_name
FROM mccPlayer P
INNER JOIN mccMatch_performance MP
ON P.registration_number = MP.registration_number
INNER JOIN mccMatches M
ON MP.match_date = M.match_date
WHERE name = 'Shane Watson';

 /* 4) List the names of players who live in Durham and who played in the match on the 28th May 2013. */

SELECT name
FROM mccPlayer P
INNER JOIN mccMatch_performance MP
ON P.registration_number = MP.registration_number
WHERE p_town = 'Durham'
AND match_date = 130705;


/* 5) List the names of players who live in the same town as 'Shane Watson'. */

SELECT P2.name
FROM mccPlayer P1
INNER JOIN mccPlayer P2
ON P1.p_town = P2.p_town
WHERE P1.name = 'Shane Watson';


/* 6) •	List the towns where either a player lives or a ground is located. */

SELECT p_town FROM mccPlayer
UNION
SELECT g_town FROM mccGround;

/* SECTION 6 - DELETE ROWS - The queries must be explained in natural (English) language first, and then followed up by respective statements */

/* 1) Hashim Amla is no longer the player. */

DELETE FROM mccPlayer WHERE name = 'Hashim Amla';

/* 2) Remove all the information about the records with batting score less than 3. */

DELETE FROM mccMatch_performance WHERE batting_score < 3;

/* SECTION 7 DROP TABLES */

DROP TABLE mccMatch_performance;
DROP TABLE mccMatches;
DROP TABLE mccPlayer;
DROP TABLE mccGround;
