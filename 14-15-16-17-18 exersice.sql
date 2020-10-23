CREATE DATABASE `soft_uni`;
USE `soft_uni`;
create table `towns` (
	`id` INT PRIMARY KEY auto_increment,
    `name` varchar(45)
);

create table `adresses` (
	`id` int primary key auto_increment,
	`adress_text` varchar(45),
    `town_id` int,
    constraint fk_addresses_towns
    foreign key (`town_id`)
    references `towns`(`id`)
);

create table  `departments`(
	`id` int primary key auto_increment,
    `name` varchar (45)
);

create table `employees` (
	`id` int primary key auto_increment,
    `first_name` varchar(30) not null,
    `middle_name` varchar(30) not null,
    `last_name` varchar(30) not null,
    `job_title` varchar(20) not null,
    `department_id` int not null,
    `hire_date` date,
    `salary` decimal(19,2),
    `adress_id` int,
    constraint fk_employees_departments
    foreign key (`department_id`)
    references `departments`(`id`),
    constraint fk_employees_adresses
    foreign key (`adress_id`)
    references `adresses`(`id`)     
);	

insert into `towns`
values
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna'),
(4,'Burgas');



insert into `departments`
values
(1,'Engineering'),
(2,'Sales'),
(3,'Marketing'),
(4,'Software Development'),
(5,'Quality Assurance');

insert into `employees` (`id`, `first_name`, `middle_name`, `last_name`, `job_title`, `department_id`,
`hire_date`, `salary`)
values
(1, 'Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
(2, 'Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
(3, 'Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
(4, 'Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
(5, 'Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);

select `name` from `towns`
order by `name` ; 
select `name` from `departments`
order by `name`;
select `first_name`, `last_name`, `job_title`, `salary`
from `employees`
order by `salary` desc;

update `employees`
set
`salary`=`salary` * 1.1;
select `salary` from `employees`;