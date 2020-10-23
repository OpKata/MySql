CREATE TABLE `users`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(30) NOT NULL UNIQUE,
    `password` VARCHAR(30) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `gender` CHAR(1) NOT NULL,
    `age` INT NOT NULL,
    `job_title` VARCHAR(40) NOT NULL,
    `ip` VARCHAR(30) NOT NULL
);


CREATE TABLE `addresses` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `address` VARCHAR(30) NOT NULL,
    `town` VARCHAR(30) NOT NULL,
    `country` VARCHAR(30) NOT NULL,
    `user_id` INT NOT NULL,
    CONSTRAINT fk_addresses_users
    FOREIGN KEY(`user_id`)
    REFERENCES `users`(`id`)
);

CREATE TABLE `photos` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `description` TEXT NOT NULL,
    `date` DATETIME NOT NULL,
    `views` INT NOT NULL DEFAULT 0    
);

CREATE TABLE `users_photos` (
	`user_id` INT NOT NULL,
    `photo_id` INT NOT NULL,
    CONSTRAINT fk_users_photos_users
    FOREIGN KEY (`user_id`)
    REFERENCES `users`(`id`),
    
    CONSTRAINT fk_users_photos_photos
    FOREIGN KEY (`photo_id`)
    REFERENCES `photos`(`id`)
);


CREATE TABLE `likes` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `photo_id` INT,
    `user_id` INT,
    CONSTRAINT fk_likes_photo
    FOREIGN KEY(`photo_id`)
    REFERENCES `photos`(`id`),
    
    CONSTRAINT fk_likes_users
    FOREIGN KEY (`user_id`)
    REFERENCES `users`(`id`)   
);

CREATE TABLE `comments` (
	`id`  INT PRIMARY KEY AUTO_INCREMENT,
    `comment` VARCHAR(255) NOT NULL,
    `date` DATETIME NOT NULL,
    `photo_id` INT NOT NULL,
    CONSTRAINT fk_comments_photos
    FOREIGN KEY(`photo_id`)
    REFERENCES `photos`(`id`)
);

#4
DELETE FROM addresses
WHERE id % 3  = 0;

#5
SELECT `username`, `gender`, `age`
FROM `users`
ORDER BY age desc, `username`;

#6
SELECT p.`id`,p.`date` , p.`description`, count(c.id) AS 'commentsCount'
FROM photos AS p
JOIN comments AS c
ON p.id = c.photo_id
GROUP BY p.id
ORDER BY commentsCount DESC, p.id
LIMIT 5;

#7
SELECT CONCAT(u.id,' ',u.username) AS id_username, u.email
FROM users AS u
JOIN users_photos AS up
ON up.user_id=u.id
WHERE up.user_id=up.photo_id
ORDER BY u.id;

#8
SELECT p.`id` , COUNT(DISTINCT l.id) AS 'likes_count',
COUNT(DISTINCT c.`id`) as 'commentsCount' 
FROM photos AS p
LEFT JOIN likes AS l
ON p.id =l.photo_id
LEFT JOIN comments AS c
ON p.id=c.photo_id
GROUP BY p.`id`
ORDER BY likes_count DESC, `commentsCount` DESC, p.`id`;

#9
SELECT 
CONCAT(LEFT(p.description,30),'...')AS 'Summanry',
 p.date
FROM photos AS p
WHERE DAY(p.`date`) = 10
ORDER BY p.`date` DESC;

#10
DELIMITER $$
CREATE FUNCTION udf_users_photos_count(username VARCHAR(30))
RETURNS INT 
DETERMINISTIC
BEGIN
	 return 4;
END
DELIMITER ;


SELECT u.username, COUNT(us.user_id)
FROM users AS u
LEFT JOIN users_photos AS up
ON u.id = up.user_id
GROUP BY u.username;

