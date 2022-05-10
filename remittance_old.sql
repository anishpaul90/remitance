SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;
SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

/*!40000 DROP DATABASE IF EXISTS `remittance_db`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `remittance_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `remittance_db`;
DROP TABLE IF EXISTS `kyc_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kyc_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `expiry` varchar(500) NOT NULL,
  `kyc_type` varchar(500) DEFAULT NULL,
  `details` text,
  `id_number` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_kyc_type_unique_constraint` (`user_id`,`kyc_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3527 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `order_docs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_docs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `order_id` varchar(500) NOT NULL,
  `doc_id` varchar(500) DEFAULT NULL,
  `doc_type` varchar(500) NOT NULL,
  `uploaded` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id_doc_type_unique_constraint` (`order_id`,`doc_type`),
  KEY `order_id_idx` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `order_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_tracking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `transaction_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `internal_order_id` varchar(500) NOT NULL,
  `external_order_id` varchar(500) NOT NULL,
  `payment_id` varchar(500) NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `status` varchar(500) NOT NULL,
  `done` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id_status_unique_constraint` (`internal_order_id`,`status`),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8754 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `payment_details` text,
  `payment_id` varchar(500) DEFAULT NULL,
  `internal_order_id` varchar(500) NOT NULL,
  `external_order_id` varchar(500) NOT NULL,
  `amount` decimal(60,2) NOT NULL,
  `amount_paid` decimal(60,2) NOT NULL DEFAULT '0.00',
  `amount_due` decimal(60,2) NOT NULL DEFAULT '0.00',
  `fee` decimal(60,2) NOT NULL DEFAULT '0.00',
  `tax` decimal(60,2) NOT NULL DEFAULT '0.00',
  `payment_gateway` varchar(500) NOT NULL,
  `status` varchar(500) NOT NULL,
  `currency` varchar(500) NOT NULL,
  `source_country` varchar(500) NOT NULL,
  `target_country` varchar(500) NOT NULL,
  `target_currency` varchar(500) NOT NULL,
  `payment_method` varchar(500) DEFAULT NULL,
  `payment_time` varchar(500) NOT NULL,
  `event_id` varchar(500) DEFAULT NULL,
  `lrs_file_name` varchar(500) DEFAULT NULL,
  `batch_file_name` varchar(500) DEFAULT NULL,
  `horm_file_name` varchar(500) DEFAULT NULL,
  `lrs_included` tinyint NOT NULL DEFAULT '0',
  `batch_included` tinyint NOT NULL DEFAULT '0',
  `horm_included` tinyint NOT NULL DEFAULT '0',
  `amount_received` decimal(60,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_order_id_unique_constraint` (`external_order_id`),
  UNIQUE KEY `internal_order_id_unique_constraint` (`internal_order_id`),
  UNIQUE KEY `payment_id_unique` (`payment_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1992 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `sbm_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sbm_session` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `session_id` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `transaction_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `source_country` varchar(500) NOT NULL,
  `source_currency` varchar(500) NOT NULL,
  `destination_currency` varchar(500) NOT NULL,
  `destination_country` varchar(500) DEFAULT NULL,
  `vendor` varchar(500) DEFAULT NULL,
  `total_amount` decimal(60,2) NOT NULL,
  `amount` decimal(60,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(60,2) NOT NULL,
  `conversion_tax` decimal(60,2) NOT NULL,
  `tcs_amount` decimal(60,2) NOT NULL,
  `rate` decimal(60,2) NOT NULL,
  `source_amount` decimal(60,2) NOT NULL,
  `destination_amount` decimal(60,2) NOT NULL,
  `fee` decimal(60,2) NOT NULL,
  `order_id` varchar(500) NOT NULL,
  `source_account_Id` varchar(500) DEFAULT NULL,
  `status` varchar(500) NOT NULL,
  `beneficiary_id` varchar(500) DEFAULT NULL,
  `source_account_details` varchar(500) DEFAULT NULL,
  `external_order_id` varchar(500) DEFAULT NULL,
  `source_provider` varchar(500) DEFAULT NULL,
  `target_provider` varchar(500) DEFAULT NULL,
  `purpose_of_transfer` varchar(500) NOT NULL,
  `a2_form_id` varchar(500) DEFAULT NULL,
  `expiry` varchar(500) DEFAULT NULL,
  `transaction_time` varchar(500) NOT NULL,
  `docs_uploaded` tinyint NOT NULL DEFAULT '0',
  `source_of_funds` varchar(500) DEFAULT NULL,
  `industry_type` varchar(100) NOT NULL,
  `employment_status` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`),
  KEY `order_id_idx` (`order_id`),
  KEY `idx_external_order_id` (`external_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18946 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_account` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `country` varchar(500) NOT NULL,
  `account_details` text,
  `nick_name` varchar(500) DEFAULT NULL,
  `swift_no` varchar(500) DEFAULT NULL,
  `account_type` varchar(500) NOT NULL,
  `routing_no` varchar(500) DEFAULT NULL,
  `bank_name` varchar(500) NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `account_no` varchar(500) DEFAULT NULL,
  `ifsc_code` varchar(500) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `phone_no` varchar(500) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'pending',
  `deleted` tinyint(1) DEFAULT '0',
  `active` tinyint(1) GENERATED ALWAYS AS (if((`deleted` = 0),1,NULL)) VIRTUAL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_account_ifsc_unique` (`active`,`account_no`(100),`ifsc_code`(100),`user_id`(100)),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1686 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_address` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `address_line1` varchar(500) NOT NULL,
  `address_line2` varchar(500) DEFAULT NULL,
  `city` varchar(500) NOT NULL,
  `state` varchar(500) NOT NULL,
  `zip` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1612 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_attributes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `provider` varchar(50) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `active` tinyint(1) GENERATED ALWAYS AS (if((`deleted` = 0),1,NULL)) VIRTUAL,
  `entity_value` varchar(50) NOT NULL,
  `meta_data` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_name_entity_provider_active_unique_constraint1` (`user_id`,`provider`,`entity_value`,`active`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=4527 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_beneficiary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_beneficiary` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `beneficiary_user_id` varchar(500) DEFAULT NULL,
  `country` varchar(500) NOT NULL,
  `account_details` text,
  `nick_name` varchar(500) DEFAULT NULL,
  `swift_no` varchar(500) DEFAULT NULL,
  `account_type` varchar(500) NOT NULL,
  `routing_no` varchar(500) NOT NULL,
  `bank_name` varchar(500) NOT NULL,
  `ben_name` varchar(500) DEFAULT NULL,
  `dda_no` varchar(500) DEFAULT NULL,
  `ifsc_code` varchar(500) DEFAULT NULL,
  `ben_address` varchar(500) DEFAULT NULL,
  `deleted` tinyint NOT NULL DEFAULT '0',
  `active` tinyint NOT NULL DEFAULT '0',
  `bank_address` varchar(500) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `phone` varchar(500) DEFAULT NULL,
  `state` varchar(500) DEFAULT NULL,
  `city` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_dda_no_unique_constraint` (`user_id`,`dda_no`),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3396 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `user_type` varchar(500) DEFAULT NULL,
  `entity_value` varchar(500) DEFAULT NULL,
  `full_name` varchar(500) DEFAULT NULL,
  `nationality` varchar(500) DEFAULT NULL,
  `dob` varchar(500) DEFAULT NULL,
  `gender` varchar(500) DEFAULT NULL,
  `source_of_funds` varchar(500) DEFAULT NULL,
  `industry_type` varchar(500) DEFAULT NULL,
  `employee_status` varchar(500) DEFAULT NULL,
  `political` tinyint NOT NULL DEFAULT '0',
  `pan_verified` tinyint NOT NULL DEFAULT '0',
  `aadhaar_verified` tinyint NOT NULL DEFAULT '0',
  `kyc_done` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_unique_constraint` (`user_id`),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1613 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 DROP DATABASE IF EXISTS `wise_db`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `wise_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `wise_db`;
DROP TABLE IF EXISTS `source_account_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `source_account_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `country` varchar(500) NOT NULL,
  `account_details` text,
  `nick_name` varchar(500) DEFAULT NULL,
  `swift_no` varchar(500) DEFAULT NULL,
  `account_type` varchar(500) NOT NULL,
  `routing_no` varchar(500) NOT NULL,
  `bank_name` varchar(500) NOT NULL,
  `bank_address` varchar(500) DEFAULT NULL,
  `account_holder_name` varchar(500) DEFAULT NULL,
  `dda_no` varchar(500) NOT NULL,
  `address` varchar(500) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `phone` varchar(500) DEFAULT NULL,
  `state` varchar(500) DEFAULT NULL,
  `city` varchar(500) DEFAULT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `external_account_id` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_acc_no_unique_constraint` (`user_id`,`dda_no`),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=637 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_access_token` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `access_token` varchar(500) NOT NULL,
  `token_type` varchar(500) DEFAULT NULL,
  `profile_id` varchar(500) DEFAULT NULL,
  `refresh_token` varchar(500) NOT NULL,
  `expires_in` timestamp NOT NULL,
  `token_scope` varchar(500) DEFAULT NULL,
  `token_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_unique_constraint` (`user_id`),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1403 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `wise_journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wise_journal` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `payment_reference` varchar(500) NOT NULL,
  `actual_amount_to_send` decimal(60,2) NOT NULL DEFAULT '0.00',
  `balance_transfer` decimal(60,2) NOT NULL DEFAULT '0.00',
  `amount_sent` decimal(60,2) NOT NULL DEFAULT '0.00',
  `details` text,
  `total_amount_sent` decimal(60,2) NOT NULL DEFAULT '0.00',
  `refund_amount` decimal(60,2) NOT NULL DEFAULT '0.00',
  `amount_wise_owe` decimal(60,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_reference_unique_constraint` (`payment_reference`),
  KEY `payment_reference` (`payment_reference`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `wise_payment_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wise_payment_tracking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `transaction_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `order_id` varchar(500) NOT NULL,
  `payment_id` varchar(500) NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `status` varchar(500) NOT NULL,
  `done` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id_status_unique_constraint` (`order_id`,`status`),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3306 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `wise_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wise_payments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `order_id` varchar(500) NOT NULL,
  `external_recipient_id` varchar(500) NOT NULL,
  `external_source_account_id` varchar(500) DEFAULT NULL,
  `quote_id` varchar(500) NOT NULL,
  `external_user_id` varchar(500) NOT NULL,
  `details` text,
  `transaction_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active_issues` tinyint NOT NULL DEFAULT '0',
  `source_currency` varchar(500) NOT NULL,
  `payment_id` varchar(500) NOT NULL,
  `status` varchar(500) NOT NULL,
  `source_amount` decimal(60,2) NOT NULL,
  `target_currency` varchar(50) NOT NULL,
  `target_amount` decimal(60,2) NOT NULL,
  `ben_id` varchar(50) NOT NULL,
  `source_account_id` varchar(50) NOT NULL,
  `settlement_id` varchar(500) DEFAULT NULL,
  `need_settlement` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_order_id_unique_constraint` (`user_id`,`order_id`),
  KEY `user_id_idx` (`user_id`),
  KEY `order_id_idx` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=820 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `wise_quote_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wise_quote_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `source_country` varchar(500) NOT NULL,
  `source_currency` varchar(500) NOT NULL,
  `destination_currency` varchar(500) NOT NULL,
  `destination_country` varchar(500) DEFAULT NULL,
  `vendor` varchar(500) DEFAULT NULL,
  `total_amount` decimal(60,2) NOT NULL,
  `tax_amount` decimal(60,2) NOT NULL DEFAULT '0.00',
  `conversion_tax` decimal(60,2) NOT NULL DEFAULT '0.00',
  `rate` decimal(60,4) NOT NULL,
  `source_amount` decimal(60,2) NOT NULL DEFAULT '0.00',
  `destination_amount` decimal(60,2) NOT NULL DEFAULT '0.00',
  `fee` decimal(60,2) NOT NULL DEFAULT '0.00',
  `order_id` varchar(500) NOT NULL,
  `source_account_Id` varchar(500) DEFAULT NULL,
  `status` varchar(500) NOT NULL,
  `beneficiary_id` varchar(500) DEFAULT NULL,
  `quote_id` varchar(500) DEFAULT NULL,
  `details` text,
  `external_order_id` varchar(500) DEFAULT NULL,
  `source_provider` varchar(500) DEFAULT NULL,
  `target_provider` varchar(500) DEFAULT NULL,
  `purpose_of_transfer` varchar(500) DEFAULT NULL,
  `source_of_funds` varchar(500) DEFAULT NULL,
  `expiry` varchar(500) DEFAULT NULL,
  `estimated_delivery` varchar(500) DEFAULT NULL,
  `pay_in` varchar(500) DEFAULT NULL,
  `pay_out` varchar(500) DEFAULT NULL,
  `track_high_amount_order` tinyint NOT NULL DEFAULT '0',
  `transaction_time` varchar(500) NOT NULL,
  `discount` decimal(60,2) NOT NULL DEFAULT '0.00',
  `partner` decimal(60,2) NOT NULL DEFAULT '0.00',
  `pay_in_fee` decimal(60,2) NOT NULL DEFAULT '0.00',
  `transferwise_fee` decimal(60,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`),
  KEY `order_id_idx` (`order_id`),
  KEY `external_order_id_idx` (`external_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13659 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `wise_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wise_recipients` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `recipient_name` varchar(500) NOT NULL,
  `type` varchar(500) NOT NULL,
  `external_profile_id` varchar(500) DEFAULT NULL,
  `external_recipient_id` varchar(500) NOT NULL,
  `external_user_id` varchar(500) DEFAULT NULL,
  `country` varchar(500) NOT NULL,
  `details` text,
  `currency` varchar(500) NOT NULL,
  `city` varchar(500) NOT NULL,
  `first_line` varchar(500) NOT NULL,
  `postal_code` varchar(500) NOT NULL,
  `state` varchar(500) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `legal_type` varchar(50) NOT NULL,
  `ifsc_code` varchar(50) NOT NULL,
  `account_number` varchar(50) NOT NULL,
  `owned_by_customer` tinyint NOT NULL DEFAULT '0',
  `active` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_external_recipient_id_unique_constraint` (`user_id`,`external_recipient_id`),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=795 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `wise_user_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wise_user_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(500) NOT NULL,
  `registration_code` varchar(500) DEFAULT NULL,
  `user_type` varchar(500) DEFAULT NULL,
  `full_name` varchar(500) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `nationality` varchar(500) DEFAULT NULL,
  `phone_no` varchar(500) DEFAULT NULL,
  `occupation` varchar(500) DEFAULT NULL,
  `city` varchar(500) DEFAULT NULL,
  `country` varchar(500) DEFAULT NULL,
  `postal_code` varchar(500) DEFAULT NULL,
  `state` varchar(500) DEFAULT NULL,
  `first_line` varchar(500) DEFAULT NULL,
  `address_id` varchar(50) DEFAULT NULL,
  `external_user_id` varchar(50) DEFAULT NULL,
  `external_profile_id` varchar(50) DEFAULT NULL,
  `dob` varchar(500) DEFAULT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `status` varchar(50) NOT NULL DEFAULT 'init',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_unique_constraint` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1397 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
