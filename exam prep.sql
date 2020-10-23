INSERT INTO `likes` (article_id, comment_id, user_id)
SELECT IF(u.`id` % 2 = 0,char_length(`username`),null),
IF(u.`id` % 2 != 0,char_length(`email`), null),
u.id 
FROM `users` AS u
WHERE u.`id` BETWEEN 16 AND 20;
SET SQL_SAFE_UPDATES = 0;

UPDATE `comments`
SET `comment` = CASE
	WHEN `id`% 2 = 0 THEN 'Very good article.'
    WHEN `id`% 3 = 0 THEN 'This is interesting.'
    WHEN `id`% 5 = 0 THEN 'I definitely will read the article again.'
    WHEN `id`% 7 = 0 THEN 'The universe is such an amazing thing.'
    ELSE `comment`
    END
WHERE `id` BETWEEN 1 AND 15;


#4
DELETE FROM `articles`
WHERE `category_id` IS NULL;

#5
SELECT  id,title,CONCAT(left(content,20),'','...') AS Summary
FROM articles as a
ORDER BY char_length(content) DESC
LIMIT 3;

SELECT  id,title,CONCAT(left(content,20),'','...') AS Summary
FROM
(SELECT * FROM articles as A
ORDER BY char_length(a.`content`) DESC
limit 3) as WHATT
ORDER BY id;


SELECT title, CONCAT(LEFT(content,20),'...') AS `summary`
FROM
(SELECT * FROM articles AS a
ORDER BY CHAR_LENGTH(a.`content` ) DESC
LIMIT 3) AS s
ORDER BY id;

#6
SELECT a.`id`,a.`title`
FROM articles AS A
JOIN users_articles AS ua
ON ua.article_id = a.id
JOIN users AS us
ON us.id = ua.user_id
WHERE us.id = a.id
ORDER BY a.id;


#7
SELECT c.`category`,
COUNT(DISTINCT a.id) AS articles,
COUNT(l.id) AS likes
FROM categories AS c
LEFT JOIN articles AS a
ON a.category_id = c.id
LEFT JOIN likes AS l
ON l.article_id = a.id
GROUP BY `category`
ORDER BY likes desc,
articles desc, c.id;

#8
SELECT DISTINCT `title`, count(DISTINCT c.user_id) as 'comments'
FROM articles AS a
JOIN comments AS c
ON c.article_id=a.id
JOIN categories AS cate
ON cate.id = a.category_id
WHERE cate.id =5
GROUP BY title
ORDER BY comments desc
LIMIT 1;


#9
SELECT concat(LEFT(c.comment,20),'','...') AS summary
FROM `comments` AS c
LEFT JOIN likes AS l
ON l.comment_id = c.id
WHERE  l.comment_id IS NULL
ORDER BY c.id DESC;
#ORDER BY c.id DESC;

#11
SELECT a.title, u.username 
FROM articles a 
JOIN likes l
ON a.id = l.article_id
JOIN users u
ON l.user_id = u.id
WHERE u.username = 'BlaAntigadsa' AND a.title = 'Donnybrook, Victoria';



DELIMITER $$
CREATE PROCEDURE udp_like_article(username VARCHAR(30), title VARCHAR(30))
BEGIN
	SELECT a.title, u.username
    FROM articles AS A
    
 
END $$
DELIMITER ;



