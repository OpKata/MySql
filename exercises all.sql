SELECT * FROM gringotts.wizzard_deposits;

#1
SELECT COUNT(*) AS 'count' FROM wizzard_deposits;

#2
SELECT MAX(`magic_wand_size`) FROM wizzard_deposits;

#3
SELECT `deposit_group`, MAX(`magic_wand_size`) AS 'mws'
FROM wizzard_deposits
GROUP BY `deposit_group`
ORDER BY `mws`,`deposit_group`;

#4
SELECT `deposit_group`
FROM wizzard_deposits
GROUP BY `deposit_group`
ORDER BY  AVG(`magic_wand_size`) 
LIMIT 1;

#5
SELECT `deposit_group`, SUM(`deposit_amount`) as `total_sum`
FROM wizzard_deposits
GROUP BY `deposit_group` 
ORDER BY `total_sum`;

#6
SELECT `deposit_group`, SUM(`deposit_amount`)
FROM wizzard_deposits
WHERE `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
ORDER BY `deposit_group`;

#7
SELECT `deposit_group`, SUM(`deposit_amount`) AS 'total_sum'
FROM wizzard_deposits
WHERE `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
HAVING total_sum<150000
ORDER BY `total_sum` DESC;

#8
SELECT 
    `deposit_group`, 
    `magic_wand_creator`, 
     MIN(`deposit_charge`) AS `min_deposit_charge`
FROM
    wizzard_deposits
GROUP BY `deposit_group` , `magic_wand_creator`
ORDER BY `magic_wand_creator` , `deposit_group`;

#9
SELECT (
	CASE
		WHEN `age` BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN `age` BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN `age` BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN `age` BETWEEN 31 AND 40 THEN '[31-40]'
        WHEN `age` BETWEEN 41 AND 50 THEN '[41-50]'
        WHEN `age` BETWEEN 51 AND 60 THEN '[51-60]'
        ELSE '[61+]'
    END

) AS `age_group`, COUNT(*) AS 'count_of_wizzards'
 FROM wizzard_deposits
 GROUP BY `age_group`
 ORDER BY `wizard_count`;
 
#10
SELECT LEFT (`first_name`,1) AS `first`
FROM wizzard_deposits
WHERE `deposit_group` ='Troll Chest'
GROUP BY `first`
ORDER BY `first`;

#11
SELECT `deposit_group`, `is_deposit_expired`, 
AVG(`deposit_interest`) AS 'avarage_interest'
FROM wizzard_deposits
WHERE `deposit_start_date` > '1985-01-01'
GROUP BY `deposit_group`, `is_deposit_expired`
ORDER BY `deposit_group` DESC, `is_deposit_expired`;

########## SOFT UNI ##########

#13
SELECT `department_id`, MIN(`salary`) AS 'Min_salary' 
FROM `employees`
WHERE `department_id` IN (2,5,7) AND `hire_date`> 2000-01-01
GROUP BY `department_id`
ORDER BY `department_id`;

#15
SELECT `department_id`, MAX(`salary`) AS 'max_salary'
FROM `employees`
GROUP BY `department_id`
HAVING `max_salary` NOT BETWEEN 30000 AND 70000
ORDER BY `department_id`;

#17
SELECT DISTINCT `salary`
FROM `employees`
WHERE `department_id` = 1
ORDER BY `salary` desc
LIMIT 2,1;


SELECT e.`department_id`,
	( SELECT DISTINCT e2.`salary` FROM `employees` AS e2
		WHERE e2.`department_id` = e.`department_id`
		ORDER BY  e2.`salary` DESC
		LIMIT 2, 1) AS `ths`
FROM `employees` AS e
WHERE `ths` IS NOT NULL
GROUP BY e.`department_id`;

SELECT e.`department_id`,
		(SELECT DISTINCT e2.`salary` FROM `employees` AS e2
			WHERE e2.`department_id` = e.`department_id`
            ORDER BY e2.`salary` DESC
            LIMIT 2, 1) AS 'ths'
FROM `employees` AS e
GROUP BY e.`department_id`    
HAVING `ths` IS NOT NULL
ORDER BY `department_id`; 


#18

SELECT AVG(e2.`salary`) AS `avg`
FROM `employees` AS e2
WHERE e2.`department_id` = 1
GROUP BY e2.`department_id`;

SELECT e.`first_name`, e.`last_name`, e.`department_id` 
FROM `employees` AS e
WHERE `salary` > 
		(SELECT AVG(e2.`salary`) AS `avg`
		FROM `employees` AS e2
		WHERE e2.`department_id` = e.department_id
		GROUP BY e2.`department_id`)
ORDER BY `department_id`, `employee_id`
LIMIT 10;


           




 
 




