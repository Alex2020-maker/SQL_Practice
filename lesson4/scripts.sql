USE vk;

# Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке

SELECT DISTINCT firstname FROM users ORDER BY firstname;

# Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). 
# Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)

ALTER TABLE profiles
ADD COLUMN is_active BOOLEAN DEFAULT TRUE;

UPDATE vk.profiles SET is_active = FALSE WHERE TIMESTAMPDIFF(year, birthday, now()) < 18;

SELECT *, TIMESTAMPDIFF(year, birthday, now()) AS age FROM profiles;

# Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)

DELETE FROM messages WHERE created_at > NOW();