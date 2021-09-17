/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 100417
Source Host           : localhost:3306
Source Database       : daily_report

Target Server Type    : MYSQL
Target Server Version : 100417
File Encoding         : 65001

Date: 2021-05-18 13:07:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for lease_companies
-- ----------------------------
DROP TABLE IF EXISTS `lease_companies`;
CREATE TABLE `lease_companies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT 'リース会社名',
  `delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0-no,1-delete',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of lease_companies
-- ----------------------------

-- ----------------------------
-- Table structure for lease_equipments
-- ----------------------------
DROP TABLE IF EXISTS `lease_equipments`;
CREATE TABLE `lease_equipments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) NOT NULL COMMENT 'リース会社',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0-車両,1-機材',
  `name` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '重機又は車両',
  `delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0-no,1-delete',
  `start_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of lease_equipments
-- ----------------------------

-- ----------------------------
-- Table structure for lease_equipments_prices
-- ----------------------------
DROP TABLE IF EXISTS `lease_equipments_prices`;
CREATE TABLE `lease_equipments_prices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `equipment_id` bigint(20) NOT NULL COMMENT '重機又は車両',
  `type_id` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT 'リース形態',
  `price` int(11) NOT NULL DEFAULT 0 COMMENT 'price',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of lease_equipments_prices
-- ----------------------------

-- ----------------------------
-- Table structure for lease_types
-- ----------------------------
DROP TABLE IF EXISTS `lease_types`;
CREATE TABLE `lease_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) NOT NULL COMMENT 'リース会社',
  `name` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT 'リース形態',
  `delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0-no,1-delete',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of lease_types
-- ----------------------------

-- ----------------------------
-- Table structure for master_personals
-- ----------------------------
DROP TABLE IF EXISTS `master_personals`;
CREATE TABLE `master_personals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) DEFAULT 0 COMMENT '0-作業員,1-外注員',
  `deleted` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of master_personals
-- ----------------------------

-- ----------------------------
-- Table structure for personals
-- ----------------------------
DROP TABLE IF EXISTS `personals`;
CREATE TABLE `personals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `master_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `tax` tinyint(1) DEFAULT 0 COMMENT '0 => tax off, 1 => tax on',
  `start_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of personals
-- ----------------------------

-- ----------------------------
-- Table structure for reports
-- ----------------------------
DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `spot_id` bigint(20) NOT NULL COMMENT '現場',
  `user_id` bigint(20) NOT NULL COMMENT '作成者',
  `report_date` date NOT NULL COMMENT '日報日付',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_user_id` bigint(20) NOT NULL COMMENT '編集者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of reports
-- ----------------------------

-- ----------------------------
-- Table structure for reports_details
-- ----------------------------
DROP TABLE IF EXISTS `reports_details`;
CREATE TABLE `reports_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `report_id` bigint(20) NOT NULL COMMENT 'reportsの id',
  `user_id` bigint(20) NOT NULL COMMENT '作成者',
  `worker_id` bigint(20) DEFAULT NULL COMMENT '外注員・従業員',
  `worker_type` tinyint(2) DEFAULT 1 COMMENT '1-full,2-半',
  `worker_value` int(11) DEFAULT NULL COMMENT '人件費',
  `excise` double DEFAULT NULL COMMENT '所得税',
  `trucks_company_id` bigint(20) DEFAULT NULL COMMENT 'リース会社-車両',
  `trucks_type_id` bigint(20) DEFAULT NULL COMMENT 'リース形態-車両',
  `trucks_tool_id` bigint(20) DEFAULT NULL COMMENT '車両',
  `trucks_value` int(11) DEFAULT NULL COMMENT '車両金額',
  `equipment_company_id` bigint(20) DEFAULT NULL COMMENT 'リース会社-機材',
  `equipment_type_id` bigint(20) DEFAULT NULL COMMENT 'リース形態-機材',
  `equipment_tool_id` bigint(20) DEFAULT NULL COMMENT '重機',
  `equipment_value` int(11) DEFAULT NULL COMMENT '重機金額',
  `disposal` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '処分',
  `disposal_value` int(11) DEFAULT NULL COMMENT '処分金額',
  `defense` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '経費',
  `defense_value` int(11) DEFAULT NULL COMMENT '経費金額',
  `etc` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT 'その他',
  `etc_value` int(11) DEFAULT NULL COMMENT 'その他金額',
  `last_user_id` bigint(20) NOT NULL COMMENT '編集者',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of reports_details
-- ----------------------------

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(10) NOT NULL DEFAULT 0 COMMENT '0-消費税,1-外注員の税別,...',
  `value` double NOT NULL COMMENT '%',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of settings
-- ----------------------------

-- ----------------------------
-- Table structure for spots
-- ----------------------------
DROP TABLE IF EXISTS `spots`;
CREATE TABLE `spots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '作成者',
  `name` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '現場名',
  `address` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '現場住所',
  `code` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '現場コード',
  `contractor` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '元請名',
  `contract_price` int(11) NOT NULL DEFAULT 0 COMMENT '請負金額',
  `excise` double NOT NULL COMMENT '消費税',
  `content` text CHARACTER SET utf8 NOT NULL COMMENT '工事内容',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '0-process,1-complete,2-delete',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ended_at` timestamp NULL DEFAULT NULL COMMENT '完工日',
  `last_user_id` bigint(20) NOT NULL COMMENT '編集者',
  `cur_user_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '現在編集者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of spots
-- ----------------------------

-- ----------------------------
-- Table structure for taxes
-- ----------------------------
DROP TABLE IF EXISTS `taxes`;
CREATE TABLE `taxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` double(11,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of taxes
-- ----------------------------
INSERT INTO `taxes` VALUES ('2', '10.00', '2021-05-01', '2021-05-16 13:05:53', '2021-05-16 13:05:53');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userID` varchar(20) CHARACTER SET utf8 NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 NOT NULL,
  `role` tinyint(10) NOT NULL DEFAULT 0 COMMENT '(0-general,1-master,...)',
  `delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0-no,1-delete',
  `auto_login` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('8', 'admin', 'admin', '$2y$10$4H3MR60/G8nUq4D3rQ12jupuoB5P/MtUWOV3Ph6TvzFLXS6VboQOu', '1', '0', '0', '2021-03-02 09:40:18', '2021-03-02 09:40:18');
INSERT INTO `users` VALUES ('16', 'user', 'user', '$2y$10$15svTqDWfRNSwRM8Z2ko5uBEoWp0EcljrM46VEGJ5APjrWZTITlSK', '0', '0', '0', '2021-05-17 02:27:52', '2021-05-18 11:54:47');

-- ----------------------------
-- Table structure for workers
-- ----------------------------
DROP TABLE IF EXISTS `workers`;
CREATE TABLE `workers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0-作業員,1-外注員',
  `name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0-no,1-delete',
  `start_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of workers
-- ----------------------------

-- ----------------------------
-- Table structure for workers_prices
-- ----------------------------
DROP TABLE IF EXISTS `workers_prices`;
CREATE TABLE `workers_prices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `worker_id` int(10) NOT NULL DEFAULT 0 COMMENT 'workersの id',
  `price` int(10) NOT NULL COMMENT '人件費',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of workers_prices
-- ----------------------------
SET FOREIGN_KEY_CHECKS=1;
