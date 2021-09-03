
# Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”

USE computer_shop;

-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

UPDATE users SET created_at = NULL;
UPDATE users SET updated_at = NULL;
UPDATE users SET created_at = NOW() WHERE created_at IS NULL;
UPDATE users SET updated_at = NOW() WHERE updated_at IS NULL;


-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
-- и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, 
-- сохранив введеные ранее значения.

DROP TABLE users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(256) DEFAULT '20.10.2017 8:10',
  updated_at VARCHAR(256) DEFAULT '20.10.2017 8:10'
) COMMENT = 'Покупатели';

ALTER TABLE users ADD created_at_dt DATETIME;
ALTER TABLE users ADD updated_at_dt DATETIME;
UPDATE users
SET created_at_dt = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'),
    updated_at_dt = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i');
ALTER TABLE users 
    DROP created_at, DROP updated_at, 
    RENAME COLUMN created_at_dt TO created_at, RENAME COLUMN updated_at_dt TO updated_at;

SELECT * FROM users;

-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, 
-- если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
-- чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться 
-- в конце, после всех записей.

SELECT value FROM storehouses_products
  ORDER BY CASE WHEN value = 0 THEN 2147483647 ELSE value END;
  
 -- Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
 -- Месяцы заданы в виде списка английских названий ('may', 'august')


SELECT name,birthday_at,
CASE 
	WHEN DATE_FORMAT(birthday_at, '%m') = 05 THEN 'May'
    WHEN DATE_FORMAT(birthday_at, '%m') = 08 THEN 'August'
END 
AS mounth FROM users WHERE DATE_FORMAT(birthday_at, '%m') = 05 OR DATE_FORMAT(birthday_at, '%m') = 08;

-- Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.

SELECT id, name FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);




