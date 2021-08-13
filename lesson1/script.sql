CREATE DATABASE example;
USE example;

CREATE TABLE users(
	id INT,
    name VARCHAR(100)
);

INSERT users (id, name) VALUES (001, 'Dasha'), (002, 'Valera');