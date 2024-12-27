/*
Student name:  Yusuf Ahmed
Student ID: 240013970
*/

/* SECTION 1 - CREATE TABLE STATEMENTS */
/* DROP DATABASE if exists courseworkyearone;
create database courseworkyearone;
use courseworkyearone;

DROP table if exists all_visitor,all_staff,special_clearance,operation_team; */

CREATE TABLE all_staff (
	staff_name               varchar(255),
	staff_ID                 int(4) PRIMARY KEY,
	staff_InsuranceReference varchar(5),
	staff_age                int(3),
	staff_email              varchar(255),
	staff_extension          char(3),
	staff_mobileNo           char(11)
);

CREATE TABLE special_clearance (
	clearance_level        int(2),
	staff_ID               int(4) PRIMARY KEY,
	FOREIGN KEY (staff_ID) REFERENCES all_staff (staff_ID) ON DELETE CASCADE
);

CREATE TABLE all_visitor (
    visitor_ID       int(4) PRIMARY KEY,
    visitor_name     varchar(255),
    visitor_email    varchar(255),
	staff_ID         int(4) NULL,
	FOREIGN KEY (staff_ID) REFERENCES all_staff (staff_ID) ON DELETE set NULL
);

CREATE TABLE operation_team (
	team_ID      varchar(4) PRIMARY KEY,
	team_size    int(2),
	status       varchar(255),
	leader_ID    int(2) NULL,
	FOREIGN KEY (leader_ID) REFERENCES special_clearance (staff_ID) ON DELETE set null
);

/* SECTION 2 - INSERT STATEMENTS */

INSERT INTO all_staff VALUES
	('Vitaly Aksenov', 1001, 'INS1', 34, 'vitalyaksenov@example.com', '101', '98765432100'),
	('John Smith', 1002, 'INS2', 29, 'johnsmith@example.com', '102', '98765432110'),
	('Deji Olatunji', 1003, 'INS3', 45, 'comedyshortsgamer@example.com', '103', '98765432120'),
	('Bob Johnson', 1004, 'INS4', 37, 'bobjohnson@example.com', '104', '98765432130'),
	('Charlie White', 1005, 'INS5', 41, 'charliewhite@example.com', '105', '98765432140'),
	('Emma Green', 1006, 'INS6', 30, 'emmagreen@example.com', '106', '98765432150'),
	('Liam Black', 1007, 'INS7', 33, 'liamblack@example.com', '107', '98765432160'),
	('Olivia Blue', 1008, 'INS8', 28, 'oliviablue@example.com', '108', '98765432170'),
	('Noah Brown', 1009, 'INS9', 50, 'noahbrown@example.com', '109', '98765432180'),
	('Sophia Gray', 1010, 'INS10', 36, 'sophiagray@example.com', '110', '98765432190'),
	('Ethan White', 1011, 'INS11', 32, 'ethanwhite@example.com', '111', '98765432200'),
	('Ava Green', 1012, 'INS12', 27, 'avagreen@example.com', '112', '98765432210'),
	('Mason Black', 1013, 'INS13', 39, 'masonblack@example.com', '113', '98765432220'),
	('Isabella Yellow', 1014, 'INS14', 26, 'isabellayellow@example.com', '114', '98765432230'),
	('Logan Purple', 1015, 'INS15', 35, 'loganpurple@example.com', '115', '98765432240');

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
	(5, 1010);

INSERT INTO all_visitor VALUES
	(2001, 'Michael Johnson', 'michael.johnson@example.com', NULL),
	(2002, 'Sarah Williams', 'sarah.williams@example.com', NULL),
	(2003, 'David Brown', 'david.brown@example.com', NULL),
	(2004, 'Emily Davis', 'emily.davis@example.com', 1007),
	(2005, 'James Wilson', 'james.wilson@example.com', 1007),
	(2006, 'Linda Martinez', 'linda.martinez@example.com', 1010),
	(2007, 'Robert Anderson', 'robert.anderson@example.com', 1010),
	(2008, 'Patricia Thomas', 'patricia.thomas@example.com', 1010),
	(2009, 'Christopher Moore', 'christopher.moore@example.com', 1001),
	(2010, 'Elizabeth Jackson', 'elizabeth.jackson@example.com', NULL);


INSERT INTO operation_team VALUES
(1, 5, NULL, 1001),
(2, 4, NULL, 1009),
(3, 6, NULL, 1009),
(4, 5, 'Active', 1001),
(5, 5, 'Standby', 1009),
(6, 4, 'Active', 1001),
(7, 5, 'Active', 1007),
(8, 6, 'Active', 1003),
(9, 4, 'Standby', 1009),
(10, 6, 'Standby', 1006),
(11, 5, 'Active', 1006),
(12, 4, 'Standby', 1003),
(13, 5, 'Active', 1004),
(14, 5, NULL, 1005),
(15, 5, 'Standby', 1005);


/* SECTION 3 - UPDATE STATEMENTS - The queries must be explained in natural (English) language first, and then followed up by respective statements */

/* 1) Change all teams with a NULL status to an updated status of being on 'Standby'. */

UPDATE operation_team SET status = 'Standby' WHERE status is NULL;

/* 2) All teams that were under leader ID 1001 to under Jane Smith, who is Staff ID 1002 . */

UPDATE operation_team SET operation_team.leader_ID=1002 WHERE operation_team.leader_ID = 1001;

/* SECTION 4 - SINGLE TABLE SELECT STATEMENTS - The queries must be explained in natural (English) language first, and then followed up by respective SELECTs */


/* 1) List the names of visitors who have no registered staff member on their visitor information. Order them alphabetically descending A-Z */

SELECT visitor_name
FROM all_visitor
WHERE staff_ID is NULL
ORDER BY visitor_name DESC;


/* 2) List the team ID/team number and status of the teams run by staff member, Noah Brown. Display the columns as 'Team' and 'Operating Status'*/

SELECT team_ID as Team,status as Operating_Status
FROM operation_team
WHERE operation_team.leader_ID = (select staff_ID from all_staff where all_staff.staff_name = 'Noah Brown');


/* 3) All teams have an assigned size. List the percentage of people who are currently 'Active' across all teams as 'Active_Agents'. Round the percentage to 2 decimal places.*/

SELECT ROUND(SUM(IF(status='Active',team_size,0))/SUM(team_size)*100,2) as Active_Agents
FROM operation_team;


/* 4) Show the range of team sizes, with the number of teams with that size. Give the sizes in ascending order.*/

select team_size,COUNT(team_size) as No_of_teams_with_size
from operation_team
group by team_size
order by team_size;


/* 5) Show the team leader's ID who has the most teams under their control */

SELECT leader_ID,count(leader_ID) as Teams_Managing
FROM operation_team
group by leader_ID;


/* 6) List names and ages of all staff who are in their twenties. List them in decreasing age down the list. */

select staff_name,staff_age
from all_staff
where staff_age like '2%'
order by staff_age desc;

/* SECTION 5 MULTIPLE TABLE SELECT STATEMENTS - The queries must be explained in natural (English) language first, and then followed up by respective SELECTs*/


/* 1) List the number of visitors and the staff member name and ID they are registered under. */

SELECT all_staff.staff_ID,all_staff.staff_name,COUNT(all_visitor.visitor_ID) as Visitors
FROM all_staff
INNER JOIN all_visitor
ON all_staff.staff_ID = all_visitor.staff_ID
group by all_staff.staff_ID, all_staff.staff_name;


/* 2) List the team leader's name with the most teams under them. Display the number of teams they control */

SELECT st.staff_name, COUNT(op.team_ID) AS team_count
FROM operation_team op
INNER JOIN special_clearance sc ON op.leader_ID = sc.staff_ID
INNER JOIN all_staff st ON sc.staff_ID = st.staff_ID
GROUP BY leader_ID
HAVING COUNT(op.team_ID) = (
    SELECT MAX(team_count)
    FROM (
        SELECT COUNT(op.team_ID) AS team_count
        FROM operation_team op
        INNER JOIN special_clearance sc ON op.leader_ID = sc.staff_ID
        GROUP BY leader_ID
    ) as leader_teamCount
)
ORDER BY team_count DESC;

/* 3) List the staff ID and clearance level and how many teams they control for staff who have a clearance level 2 or higher but 4 or lower (range [2,4] ). */

SELECT st.staff_ID,sc.clearance_level,Count(team_ID)
FROM all_staff st
INNER JOIN special_clearance sc ON st.staff_ID = sc.staff_ID
INNER JOIN operation_team ot on sc.staff_ID = ot.leader_ID
where clearance_level>=2 and clearance_level<=4
group by st.staff_ID, sc.clearance_level;

 /* 4) List the name of the leader of the teams, the ID and status of all the teams they run. Display a value from 0 to 100 representing a percentage which is the number of teams under them which are active. Show this as a column called 'Active_Teams'.*/

SELECT staff_name,ROUND(SUM(IF(status='Active',100,0))/COUNT(team_ID),2) as Active_Teams
FROM all_staff st
INNER JOIN operation_team ot
on st.staff_ID = ot.leader_ID
group by staff_name
order by staff_name;

/* 5) List the names of all non-special clearance staff and all the visitors of non-special clearance staff. List this as Secondary_Evac_Priority*/

select all_staff.staff_name as Secondary_Evac_Priority
from all_staff
where all_staff.staff_name not in (
SELECT st.staff_name
FROM all_staff st
inner JOIN special_clearance sc ON st.staff_ID = sc.staff_ID)
union
select all_visitor.visitor_name
from all_visitor
where all_visitor.visitor_name not in (
select all_visitor.visitor_name
from all_visitor
inner join special_clearance sc on all_visitor.staff_ID = sc.staff_ID);


/* 6) Show the ID and names of anyone with a clearance level 2 or less in charge of a team*/

SELECT st.staff_ID, st.staff_name
FROM all_staff st
WHERE EXISTS (
    SELECT 1
    FROM special_clearance sc
    WHERE st.staff_ID = sc.staff_ID
    AND sc.clearance_level <= 2
    AND EXISTS (
    SELECT 1
    FROM operation_team ot
    WHERE ot.leader_ID = sc.staff_ID)
);


/* SECTION 6 - DELETE ROWS - The queries must be explained in natural (English) language first, and then followed up by respective statements */

/* 1) Delete all visitors who do not have a staff ID associated with them. */

DELETE FROM all_visitor WHERE staff_ID is null;

/* 2) Remove all operation teams who are serving under leader Noah Brown*/
DELETE FROM operation_team
WHERE operation_team.leader_ID=(select all_staff.staff_ID from all_staff where staff_name='Noah Brown');

/* SECTION 7 DROP TABLES */

DROP TABLE operation_team;
DROP TABLE all_visitor;
DROP TABLE special_clearance;
DROP TABLE all_staff;
