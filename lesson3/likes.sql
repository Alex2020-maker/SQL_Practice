USE vk;

CREATE TABLE media_likes (
	user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, media_id),
    KEY user_id_idx (user_id),
    KEY media_id_idx (media_id),
	CONSTRAINT media_likes_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT media_likes_media FOREIGN KEY (media_id) REFERENCES media (id) ON DELETE CASCADE
);

CREATE TABLE post_likes (
	user_id BIGINT UNSIGNED NOT NULL,
    post_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, post_id),
    KEY user_id_idx (user_id),
	KEY post_id_idx (post_id),
	CONSTRAINT post_likes_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT post_likes_post FOREIGN KEY (post_id) REFERENCES post (id) ON DELETE CASCADE
);
