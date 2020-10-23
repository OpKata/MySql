#2
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(min_salary DECIMAL(19,4))
BEGIN
	SELECT 
    first_name, last_name
FROM
    employees
WHERE
    salary >= min_salary
ORDER BY first_name , last_name , employee_id;
END $$
DELIMITER ;


SELECT first_name, last_name
FROM employees
WHERE salary > 45000
ORDER BY first_name, last_name,employee_id;

CALL  usp_get_employees_salary_above(45000);

#3
DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(start_str VARCHAR(50))
BEGIN	SELECT `name` 
	FROM towns
	WHERE `name` LIKE concat(start_str,'%')
	ORDER BY `name`;
END $$

SELECT `name` 
FROM towns
WHERE `name` LIKE 'b%'
ORDER BY `name`;

CALL usp_get_towns_starting_with('b');

#5
DELIMITER  $$
CREATE FUNCTION ufn_get_salary_level(e_salary DECIMAL)
RETURNS VARCHAR (10)
DETERMINISTIC
BEGIN
	RETURN (CASE 
				WHEN e_salary < 30000 THEN 'Low'
				WHEN e_salary BETWEEN 30000 AND 50000 THEN 'Average'
                WHEN e_salary > 50000 THEN 'High'
			END
		);
END $$

DELIMITER ;

SELECT ufn_get_salary_level(60100) AS 'Salary';

#6
DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(s_level VARCHAR (10))
BEGIN
		SELECT first_name, last_name
		FROM employees
		WHERE ufn_get_salary_level(salary) = s_level
        ORDER BY first_name DESC , last_name DESC;

END $$

CALL usp_get_employees_by_salary_level ('high')


#10
DELIMITER $$
	CREATE FUNCTION ufn_calculate_future_value
    (summ DECIMAL(19,4), interest DOUBLE, years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN
	RETURN summ*pow(1+interest, years);
END $$
DELIMITER ;

SELECT ufn_calculate_future_value(1000,0.5,5);

#11
DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account
(acc_id INT, interest DOUBLE)
	BEGIN
    SELECT a.id, ah.first_name, ah.last_name, a.balance, ufn_calculate_future_value(a.balance,interest ,5)
	FROM accounts AS a
	JOIN account_holders AS ah
	ON a.account_holder_id = ah.id
    where a.id = acc_id;
	END $$
    
 DELIMITER ;
 
SELECT a.id, ah.first_name, ah.last_name, a.balance, ufn_calculate_future_value(a.balance, 0.1,0.5)
FROM accounts AS a
JOIN account_holders AS ah
on a.account_holder_id = ah.id;



CALL usp_calculate_future_value_for_account(1,0.1);

















