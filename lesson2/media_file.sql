DROP DATABASE IF EXISTS media;
CREATE DATABASE IF NOT EXISTS media;

USE media;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя пользователя',
  age INT NOT NULL COMMENT 'Возраст'
);

INSERT INTO users VALUES
	(DEFAULT, 'Ольга', '14'),
    (DEFAULT, 'Ваня', '16');

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO media_types VALUES
	(DEFAULT, 'Изображение'),
    (DEFAULT, 'Видео'),
    (DEFAULT, 'Документ'),
    (DEFAULT, 'Аудио');

DROP TABLE IF EXISTS media_files;
CREATE TABLE media_files (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
    media_types_id INT UNSIGNED NOT NULL COMMENT 'Тип файла',
    file_name VARCHAR(40) COMMENT 'Название файла',
    add_info JSON,
    file_size BIGINT UNSIGNED COMMENT 'Размер файла',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    file_path  VARCHAR(255),
    KEY (user_id),
    KEY (media_types_id),
    FOREIGN KEY (media_types_id) REFERENCES media_types(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO media_files VALUES (DEFAULT, 1, 1, 'Смешной кот',DEFAULT, 120, DEFAULT, '/home/olga/Desktop');
INSERT INTO media_files VALUES (DEFAULT, 2, 2, 'Крутая машина',DEFAULT,50, DEFAULT, '/home/vanu/Desktop/car');
SELECT * FROM media_files;