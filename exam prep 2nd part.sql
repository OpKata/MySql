#2
INSERT INTO `coaches`(`first_name`,`last_name`, `salary`, `coach_level`)
SELECT `first_name`, `last_name`, `salary` * 2,
CHAR_LENGTH(`first_name`)
FROM `players`
WHERE `age` >=45;

SET SQL_SAFE_UPDATES = 0;
#3
UPDATE `coaches`
SET `coach_level` = `coach_level` + 1
WHERE LEFT(`first_name` ,1) = 'A'
AND id IN (SELECT coach_id FROM players_coaches);
#4
DELETE FROM `players`
WHERE `age` >= 45;
#5
SELECT first_name, age, salary
FROM players
ORDER BY salary DESC;

#6
SELECT p.id,concat_ws(' ',first_name, last_name) AS 'full_name',
p.age,p.position,hire_date 
FROM players AS p
JOIN skills_data AS sd
ON sd.id = p.skills_data_id
WHERE hire_date IS NULL AND sd.strength >50
AND age < 23 AND p.position = 'A'
ORDER BY salary,age;

#7
SELECT t.name, t.established, t.fan_base, COUNT(p.id) AS `players_count`
FROM teams AS t
LEFT JOIN players AS p
ON p.team_id =t.id
GROUP BY t.id
ORDER BY `players_count` DESC, salary DESC;

#8
SELECT MAX(sd.speed)as 'max_speed'  ,t.name, s.name,te.`name`,p.`first_name`
 FROM `towns` AS t
 LEFT JOIN `stadiums` AS s
 ON t.id=s.town_id
 LEFT JOIN `teams` AS te
 ON s.id = te.stadium_id
 LEFT JOIN `players` AS p
 ON te.id = p.team_id
 LEFT JOIN skills_data AS sd
 ON p.skills_data_id=sd.id
 WHERE te.name !='Devify'
 GROUP BY t.id
 ORDER BY `max_speed` DESC, t.`name`;
 
 #9
 
 SELECT c.`name`, COUNT(p.id) AS total_count_of_players,
 SUM(p.salary) as total_sum_of_salaries
 FROM countries AS c
 LEFT JOIN `towns` AS t
 ON c.id = t.country_id
 LEFT JOIN `stadiums` AS s
 ON t.id = s.town_id
 LEFT JOIN `teams` AS te
 ON s.id = te.stadium_id
 LEFT JOIN `players` AS p
 ON te.id=p.team_id
 GROUP BY c.id
 ORDER BY `total_count_of_players` DESC, c.`name`;
 
 
 
 
 
 
 
 
 #10
 DELIMITER $$
 CREATE FUNCTION udf_stadium_players_count(stadium_name VARCHAR(30))
 RETURNS INT
 DETERMINISTIC
 BEGIN
	RETURN(SELECT count(p.id)
			FROM stadiums AS s
			LEFT JOIN `teams` AS t
			ON s.id = t.stadium_id
			LEFT JOIN `players`AS p
			ON t.id=p.team_id
			WHERE s.`name`=stadium_name); 
 END $$
 
 DELIMITER ;
 
SELECT udf_stadium_players_count ('Jaxworks') as `count`; 









#11
DELIMITER $$
CREATE PROCEDURE udp_find_playmaker(min_dibrle_points INT, team_name VARCHAR(45))
BEGIN
	SELECT concat(p.first_name, ' ', p.last_name)AS 'full_name',
p.age,p.salary, sd.dribbling, sd.speed,t.name
FROM  teams as T
JOIN players AS p
ON t.id = p.team_id
JOIN skills_data AS sd
ON sd.id = p.skills_data_id
WHERE sd.dribbling  >min_dibrle_points AND t.name = team_name
ORDER BY sd.speed DESC
LIMIT 1;
END $$

DELIMITER ;

CALL udp_find_playmaker(20, 'Skyble'); 




SELECT concat(p.first_name, ' ', p.last_name)AS 'full_name',
p.age,p.salary,
 sd.dribbling, sd.speed,t.name
FROM  teams as T
JOIN players AS p
ON t.id = p.team_id
JOIN skills_data AS sd
ON sd.id = p.skills_data_id
WHERE sd.dribbling  >20 AND t.name = 'Skyble'
ORDER BY sd.speed DESC
LIMIT 1;