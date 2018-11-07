CREATE TABLE `media` (
  `media_id` int(10) unsigned NOT NULL,
  `hashcode` varchar(255) DEFAULT NULL,
  `update_time` datetime NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `click` (
  `click_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `media_id` int(10) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`click_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `media`(media_id, hashcode, update_time) VALUES (100, 'hogehoge', NOW());
