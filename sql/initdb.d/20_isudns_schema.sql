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
