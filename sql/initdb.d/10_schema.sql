USE `isupipe`;

-- ユーザ (配信者、視聴者)
DROP TABLE `users`;
CREATE TABLE `users` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `display_name` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  UNIQUE `uniq_user_name` (`name`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- プロフィール画像
DROP TABLE `icons`;
CREATE TABLE `icons` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `image` LONGBLOB NOT NULL,
  INDEX user_id_idx(`user_id`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ユーザごとのカスタムテーマ
DROP TABLE `themes`;
CREATE TABLE `themes` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `dark_mode` BOOLEAN NOT NULL,
  INDEX user_id_idx(`user_id`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ライブ配信
DROP TABLE `livestreams`;
CREATE TABLE `livestreams` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` text NOT NULL,
  `playlist_url` VARCHAR(255) NOT NULL,
  `thumbnail_url` VARCHAR(255) NOT NULL,
  `start_at` BIGINT NOT NULL,
  `end_at` BIGINT NOT NULL,
  INDEX user_id_idx(`user_id`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ライブ配信予約枠
DROP TABLE `reservation_slots`;
CREATE TABLE `reservation_slots` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `slot` BIGINT NOT NULL,
  `start_at` BIGINT NOT NULL,
  `end_at` BIGINT NOT NULL,
  INDEX start_at_end_at_idx(`start_at`, `end_at`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ライブストリームに付与される、サービスで定義されたタグ
DROP TABLE `tags`;
CREATE TABLE `tags` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  UNIQUE `uniq_tag_name` (`name`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ライブ配信とタグの中間テーブル
DROP TABLE `livestream_tags`;
CREATE TABLE `livestream_tags` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `livestream_id` BIGINT NOT NULL,
  `tag_id` BIGINT NOT NULL,
  INDEX livestream_id_tag_id_idx(`livestream_id`, `tag_id`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ライブ配信視聴履歴
DROP TABLE `livestream_viewers_history`;
CREATE TABLE `livestream_viewers_history` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `livestream_id` BIGINT NOT NULL,
  `created_at` BIGINT NOT NULL,
  INDEX user_id_livestream_id_idx(`user_id`, `livestream_id`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ライブ配信に対するライブコメント
DROP TABLE `livecomments`;
CREATE TABLE `livecomments` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `livestream_id` BIGINT NOT NULL,
  `comment` VARCHAR(255) NOT NULL,
  `tip` BIGINT NOT NULL DEFAULT 0,
  `created_at` BIGINT NOT NULL,
  INDEX livestream_id_idx(`livestream_id`),
  FULLTEXT INDEX comment_fulltext(`comment`) WITH PARSER ngram
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- ユーザからのライブコメントのスパム報告
DROP TABLE `livecomment_reports`;
CREATE TABLE `livecomment_reports` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `livestream_id` BIGINT NOT NULL,
  `livecomment_id` BIGINT NOT NULL,
  `created_at` BIGINT NOT NULL,
  INDEX livestream_id_idx(`livestream_id`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- 配信者からのNGワード登録
DROP TABLE `ng_words`;
CREATE TABLE `ng_words` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `livestream_id` BIGINT NOT NULL,
  `word` VARCHAR(255) NOT NULL,
  `created_at` BIGINT NOT NULL,
  INDEX user_id_idx(`user_id`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
-- CREATE INDEX ng_words_word ON ng_words(`word`);
-- DROP INDEX ng_words_word ON ng_words;

-- ライブ配信に対するリアクション
DROP TABLE `reactions`;
CREATE TABLE `reactions` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `livestream_id` BIGINT NOT NULL,
  -- :innocent:, :tada:, etc...
  `emoji_name` VARCHAR(255) NOT NULL,
  `created_at` BIGINT NOT NULL,
  INDEX user_id_idx(`user_id`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;


USE `isudns`;
DROP TABLE `records`;
CREATE TABLE `records` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `domain_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `content` varchar(64000) DEFAULT NULL,
  `ttl` int DEFAULT NULL,
  `prio` int DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT '0',
  `ordername` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `auth` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `records_name_type` (`name`, `type`),
  KEY `domain_id` (`domain_id`),
  KEY `ordername` (`ordername`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
create index records_name_type on records(name, type);