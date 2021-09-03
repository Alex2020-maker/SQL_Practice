CREATE DATABASE IF NOT EXISTS vk;

USE vk;

CREATE TABLE users (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL COMMENT 'ФАМИЛИЯ',
  email VARCHAR(120) NOT NULL,
  phone CHAR(11) NOT NULL,
  password_hash CHAR(65) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY email (email),
  KEY users_email_idx (email),
  KEY users_phone_idx (phone)
);

CREATE TABLE profiles (
  user_id BIGINT UNSIGNED NOT NULL,
  gender ENUM('f','m','x') DEFAULT NULL,
  birthday DATE NOT NULL,
  photo_id INT UNSIGNED DEFAULT NULL,
  city VARCHAR(130) DEFAULT NULL,
  country VARCHAR(130) DEFAULT NULL,
  PRIMARY KEY (user_id),
  CONSTRAINT profiles_ibfk_1 FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE friend_requests (
  from_user_id BIGINT UNSIGNED NOT NULL,
  to_user_id BIGINT UNSIGNED NOT NULL,
  accepted TINYINT(1) DEFAULT '0',
  PRIMARY KEY (from_user_id,to_user_id),
  KEY fk_friend_requests_from_user_idx (from_user_id),
  KEY fk_friend_requests_to_user_idx (to_user_id),
  CONSTRAINT fk_friend_requests_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id),
  CONSTRAINT fk_friend_requests_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id)
);

CREATE TABLE communities (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	name  VARCHAR(145) NOT NULL,
	DESCRIPTION VARCHAR(245) DEFAULT NULL,
	PRIMARY KEY (id),
	KEY id (id),
    KEY communities_name_idx (name)
);

CREATE TABLE communities_users (
  community_id BIGINT UNSIGNED NOT NULL,
  user_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (community_id, user_id),
  KEY communities_users_comm_idx (community_id),
  KEY communities_users_users_idx (user_id),
  CONSTRAINT communities_users_ibfk_1 FOREIGN KEY (community_id) REFERENCES communities (id),
  CONSTRAINT communities_users_ibfk_2 FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY name (name)
);

CREATE TABLE media (
  id BIGINT UNSIGNED  NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  media_types_id INT UNSIGNED NOT NULL,
  file_name varchar(245) DEFAULT NULL COMMENT '/files/folder/img.png',
  file_size  BIGINT UNSIGNED DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  KEY media_users_idx (user_id),
  KEY media_media_types_idx (media_types_id),
  CONSTRAINT fk_media_media_types FOREIGN KEY (media_types_id) REFERENCES media_types (id),
  CONSTRAINT fk_media_users FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE post (
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 user_id BIGINT UNSIGNED NOT NULL,
 name  VARCHAR(145) NOT NULL,
 DESCRIPTION VARCHAR(245) DEFAULT NULL,
 PRIMARY KEY (id),
 KEY post_name_id (name)
);

CREATE TABLE messages (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  from_user_id BIGINT UNSIGNED NOT NULL,
  to_user_id BIGINT UNSIGNED NOT NULL,
  txt TEXT NOT NULL,
  is_delivered TINYINT(1) DEFAULT '0',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  KEY fk_messages_from_user_idx (from_user_id),
  KEY fk_messages_to_user_idx (to_user_id),
  CONSTRAINT fk_messages_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id),
  CONSTRAINT fk_messages_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id)
);