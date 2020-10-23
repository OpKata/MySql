#1
SELECT e.`employee_id`, e.`job_title`, a.address_id, a.address_text
FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
ORDER BY address_id
LIMIT 5;

#2

SELECT e.`first_name`, e.`last_name`, t.`name`,a.`address_text`
FROM employees AS e
JOIN addresses AS a
ON e.`address_id`= a.`address_id`
JOIN towns AS t
ON a.`town_id` = t.`town_id`
ORDER BY e.`first_name`, e.`last_name`
LIMIT 5;

#3
SELECT e.`employee_id` ,e.`first_name`, e.`last_name`,
d.`name`
FROM employees AS e
JOIN departments AS d
ON e.`department_id` = d.`department_id`
WHERE d.`name` = 'Sales'
ORDER BY e.employee_id DESC;

#4
SELECT 
    e.`employee_id`, e.`first_name`, e.`salary`, d.`name`
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    e.`salary` > 15000
ORDER BY d.`department_id` DESC
LIMIT 5; 

#5
SELECT e.employee_id ,e.`first_name` From 
employees AS e
WHERE e.`employee_id` NOT IN  (SELECT employee_id FROM employees_projects)
ORDER BY e.`employee_id` DESC
LIMIT 3;

SELECT e.employee_id, e.`first_name`
FROM employees AS e
LEFT JOIN employees_projects AS ep
ON ep.employee_id = e.employee_id
WHERE ep.project_id IS NULL
ORDER BY e.`employee_id` DESC
LIMIT 3;

#6
SELECT e.`first_name`, e.`last_name`, e.`hire_date`,d.`name`
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE DATE (e.`hire_date`) > '1999-01-01' 
AND d.`name` IN ('Sales', 'Finance')
ORDER BY e.`hire_date`;

#7
SELECT e.`employee_id`,e.`first_name`,p.`name`
FROM employees AS e
JOIN employees_projects AS ep
ON  e.employee_id=ep.employee_id
JOIN projects AS p
ON ep.project_id = p.project_id
WHERE DATE( p.`start_date`) > '2002-08-13'
AND p.`end_date` IS NULL
ORDER BY e.`first_name`, p.`name` 
LIMIT 5;

#8
SELECT e.`employee_id`, e.`first_name`,
IF(YEAR(p.`start_date`)<2005, p.`name`, NULL) AS `project_name` 
FROM employees AS e
JOIN employees_projects AS ep
ON e.`employee_id` = ep.`employee_id`
JOIN projects AS p
ON ep.`project_id`= p.`project_id`
WHERE e.`employee_id` = 24
ORDER BY `project_name`;

#9
SELECT e.employee_id,e.first_name,e2.employee_id, e2.first_name FROM employees AS e
JOIN employees AS e2
ON e2.employee_id = e.manager_id
WHERE e.manager_id IN (3,7)
ORDER BY e.first_name; 

#10
SELECT 
    e.employee_id,
    CONCAT(e.`first_name`, ' ', e.`last_name`) AS `employee_name`,
    CONCAT(e2.`first_name`, ' ', e2.`last_name`) AS `manager_name`,
    d.`name` AS 'department_name'
FROM
    employees AS e
        JOIN
    employees AS e2 ON e2.employee_id = e.manager_id
        JOIN
    departments AS d ON e.department_id = d.department_id
ORDER BY e.`employee_id`
LIMIT 5;

#11

SELECT MIN(min_avg_salary) AS min_avg_salary
FROM
(
	SELECT AVG(salary) AS min_avg_salary
    FROM employees
    GROUP BY department_id
) AS min_avg_salary;

#12
SELECT c.`country_code`, m.mountain_range, p.peak_name, p.elevation 	
FROM countries AS c
JOIN  mountains_countries AS mc
ON mc.country_code =c.country_code
JOIN  mountains AS m
ON m.id = mc.mountain_id
JOIN peaks AS p
ON p.mountain_id = m.id
WHERE c.country_code IN ('BG') AND p.elevation > 2835 
ORDER BY p.elevation DESC;






#17
SELECT 
    c.country_name,
    MAX(p.elevation) AS 'highest_peak_elevation',
    MAX(r.length) AS 'longest_river_length'
FROM
    countries AS c
        JOIN
    countries_rivers AS cr ON c.country_code = cr.country_code
        JOIN
    rivers AS r ON cr.river_id = r.id
        JOIN
    mountains_countries AS mc ON mc.country_code = c.country_code
        JOIN
    mountains AS m ON mc.mountain_id = m.id
        JOIN
    peaks AS p ON p.mountain_id = m.id
GROUP BY c.country_name
ORDER BY `highest_peak_elevation` DESC , `longest_river_length` DESC , c.`country_name`
LIMIT 5;

#16
SELECT count(*)
FROM countries AS c
LEFT JOIN mountains_countries as mc
ON c.country_code = mc.country_code
WHERE mc.mountain_id is NULL;





















