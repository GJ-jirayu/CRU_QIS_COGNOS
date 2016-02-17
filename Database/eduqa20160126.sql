/*
Navicat MySQL Data Transfer

Source Server         : che
Source Server Version : 50626
Source Host           : 10.1.2.206:3306
Source Database       : eduqa

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2016-01-26 14:48:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for calendar_type
-- ----------------------------
DROP TABLE IF EXISTS `calendar_type`;
CREATE TABLE `calendar_type` (
  `calendar_type_id` int(11) NOT NULL DEFAULT '0' COMMENT 'ปีปฏิทิน\r\nปีงบประมาณ\r\nปีการศึกษา',
  `calendar_type_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ปีปฏิทิน\r\nปีงบประมาณ\r\nปีการศึกษา',
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`calendar_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ประเภทปฏิทิน';

-- ----------------------------
-- Table structure for cds
-- ----------------------------
DROP TABLE IF EXISTS `cds`;
CREATE TABLE `cds` (
  `cds_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `cds_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cds_desc` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_level_id` int(11) NOT NULL,
  `che_cds_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sql_flag` char(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'เก็บ Y , N',
  `cds_sql` text COLLATE utf8_unicode_ci,
  `value_field_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `university_field_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `faculty_field_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `course_field_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `support_data_field_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `year_field_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `month_field_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `connection_id` int(11) DEFAULT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  `constant` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cds_id`),
  KEY `kpi_level_common_data_set_fk` (`kpi_level_id`),
  KEY `database_connection_common_data_set_fk` (`connection_id`),
  CONSTRAINT `database_connection_common_data_set_fk` FOREIGN KEY (`connection_id`) REFERENCES `database_connection` (`connection_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_level_common_data_set_fk` FOREIGN KEY (`kpi_level_id`) REFERENCES `kpi_level` (`kpi_level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for cds_evidence
-- ----------------------------
DROP TABLE IF EXISTS `cds_evidence`;
CREATE TABLE `cds_evidence` (
  `evidence_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `result_detail_id` int(11) NOT NULL,
  `evidence_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'เก็บลิ้งค์ url หรือ path attached file',
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`evidence_id`),
  KEY `kpi_cds_detail_kpi_result_evidence_fk` (`result_detail_id`),
  CONSTRAINT `kpi_cds_detail_kpi_result_evidence_fk` FOREIGN KEY (`result_detail_id`) REFERENCES `cds_result_detail` (`result_detail_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for cds_result
-- ----------------------------
DROP TABLE IF EXISTS `cds_result`;
CREATE TABLE `cds_result` (
  `result_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) DEFAULT NULL,
  `month_id` int(11) NOT NULL,
  `org_id` int(11) NOT NULL,
  `cds_id` int(11) NOT NULL,
  `cds_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `university_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `faculty_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `course_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `support_data_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cds_value` decimal(12,2) DEFAULT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  `result_row_no` int(11) NOT NULL,
  `row_type` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`result_id`),
  KEY `organization_cds_result_fk` (`org_id`),
  KEY `cds_cds_result_fk` (`cds_id`),
  KEY `sys_month_cds_result_fk` (`month_id`),
  CONSTRAINT `cds_cds_result_fk` FOREIGN KEY (`cds_id`) REFERENCES `cds` (`cds_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `organization_cds_result_fk` FOREIGN KEY (`org_id`) REFERENCES `org` (`org_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sys_month_cds_result_fk` FOREIGN KEY (`month_id`) REFERENCES `sys_month` (`month_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for cds_result_detail
-- ----------------------------
DROP TABLE IF EXISTS `cds_result_detail`;
CREATE TABLE `cds_result_detail` (
  `result_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `result_id` int(11) NOT NULL,
  `evidence_flag` char(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'R = Standard Report\r\nL = URL \r\nF = Attached Files',
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`result_detail_id`),
  KEY `cds_result_kpi_result_detail_fk` (`result_id`),
  CONSTRAINT `cds_result_kpi_result_detail_fk` FOREIGN KEY (`result_id`) REFERENCES `cds_result` (`result_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='สำหรับตัวบ่งชี้ที่เป็นเชิงปริมาณ';

-- ----------------------------
-- Table structure for criteria_group
-- ----------------------------
DROP TABLE IF EXISTS `criteria_group`;
CREATE TABLE `criteria_group` (
  `criteria_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `criteria_group_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_level_id` int(11) NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`criteria_group_id`),
  KEY `kpi_level_criteria_group_fk` (`kpi_level_id`),
  CONSTRAINT `kpi_level_criteria_group_fk` FOREIGN KEY (`kpi_level_id`) REFERENCES `kpi_level` (`kpi_level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='กลุ่มสถาบัน\r\nกลุ่มสาขาวิชา\r\nกลุ่มระดับการศึกษา';

-- ----------------------------
-- Table structure for criteria_group_detail
-- ----------------------------
DROP TABLE IF EXISTS `criteria_group_detail`;
CREATE TABLE `criteria_group_detail` (
  `criteria_group_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `criteria_group_id` int(11) NOT NULL,
  `detail_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ท, เอก',
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`criteria_group_detail_id`),
  KEY `criteria_group_criteria_group_detail_fk` (`criteria_group_id`),
  CONSTRAINT `criteria_group_criteria_group_detail_fk` FOREIGN KEY (`criteria_group_id`) REFERENCES `criteria_group` (`criteria_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for criteria_method
-- ----------------------------
DROP TABLE IF EXISTS `criteria_method`;
CREATE TABLE `criteria_method` (
  `criteria_method_id` int(11) NOT NULL AUTO_INCREMENT,
  `criteria_method_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `criteria_type_id` int(11) NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`criteria_method_id`),
  KEY `criteria_type_criteria_method_fk` (`criteria_type_id`),
  CONSTRAINT `criteria_type_criteria_method_fk` FOREIGN KEY (`criteria_type_id`) REFERENCES `criteria_type` (`criteria_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='วิธีการประเมิน';

-- ----------------------------
-- Table structure for criteria_type
-- ----------------------------
DROP TABLE IF EXISTS `criteria_type`;
CREATE TABLE `criteria_type` (
  `criteria_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `criteria_type_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'เชิงปริมาณ\r\nเชิงคุณภาพ',
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`criteria_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ประเภทเกณฑ์ประเมิน';

-- ----------------------------
-- Table structure for database_connection
-- ----------------------------
DROP TABLE IF EXISTS `database_connection`;
CREATE TABLE `database_connection` (
  `connection_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `connection_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `host_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `database_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `port` int(11) NOT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  `database_type` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`connection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for joblog
-- ----------------------------
DROP TABLE IF EXISTS `joblog`;
CREATE TABLE `joblog` (
  `joblogid` int(11) NOT NULL AUTO_INCREMENT,
  `jobname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastrundttm` datetime DEFAULT NULL,
  `finishdttm` datetime DEFAULT NULL,
  `successdttm` datetime DEFAULT NULL,
  `createddttm` datetime NOT NULL,
  `updateddttm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`joblogid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for kpi
-- ----------------------------
DROP TABLE IF EXISTS `kpi`;
CREATE TABLE `kpi` (
  `kpi_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `kpi_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_level_id` int(11) NOT NULL,
  `kpi_group_id` int(11) NOT NULL,
  `kpi_structure_id` int(11) DEFAULT NULL,
  `kpi_type_id` int(11) NOT NULL,
  `calendar_type_id` int(11) DEFAULT NULL COMMENT 'ปีปฏิทิน\r\nปีงบประมาณ\r\nปีการศึกษา',
  `kpi_uom_id` int(11) NOT NULL,
  `period_id` int(11) NOT NULL,
  `parent_kpi_id` int(11) DEFAULT NULL,
  `benchmark_value` decimal(15,2) NOT NULL,
  `criteria_type_id` int(11) NOT NULL,
  `score_criteria_flag` char(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'คะแนนเต็ม',
  `criteria_score` int(11) DEFAULT NULL,
  `pass_criteria_flag` char(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ผ่าน/ไม่ผ่าน',
  `criteria_method_id` int(11) NOT NULL,
  `formula_desc` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `formula` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `percentage_flag` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`kpi_id`),
  KEY `criteria_type_kpi_fk` (`criteria_type_id`),
  KEY `criteria_method_kpi_fk` (`criteria_method_id`),
  KEY `calendar_type_kpi_fk` (`calendar_type_id`),
  KEY `period_kpi_fk` (`period_id`),
  KEY `kpi_uom_kpi_fk` (`kpi_uom_id`),
  KEY `kpi_type_kpi_fk` (`kpi_type_id`),
  KEY `kpi_group_kpi_fk` (`kpi_group_id`),
  KEY `kpi_structure_kpi_fk` (`kpi_structure_id`),
  KEY `kpi_level_kpi_fk` (`kpi_level_id`),
  KEY `kpi_kpi_fk` (`parent_kpi_id`),
  CONSTRAINT `calendar_type_kpi_fk` FOREIGN KEY (`calendar_type_id`) REFERENCES `calendar_type` (`calendar_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `criteria_method_kpi_fk` FOREIGN KEY (`criteria_method_id`) REFERENCES `criteria_method` (`criteria_method_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `criteria_type_kpi_fk` FOREIGN KEY (`criteria_type_id`) REFERENCES `criteria_type` (`criteria_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_group_kpi_fk` FOREIGN KEY (`kpi_group_id`) REFERENCES `kpi_group` (`kpi_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_kpi_fk` FOREIGN KEY (`parent_kpi_id`) REFERENCES `kpi` (`kpi_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_level_kpi_fk` FOREIGN KEY (`kpi_level_id`) REFERENCES `kpi_level` (`kpi_level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_structure_kpi_fk` FOREIGN KEY (`kpi_structure_id`) REFERENCES `kpi_structure` (`kpi_structure_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_type_kpi_fk` FOREIGN KEY (`kpi_type_id`) REFERENCES `kpi_type` (`kpi_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_uom_kpi_fk` FOREIGN KEY (`kpi_uom_id`) REFERENCES `kpi_uom` (`kpi_uom_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `period_kpi_fk` FOREIGN KEY (`period_id`) REFERENCES `period` (`period_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for kpi_cds_mapping
-- ----------------------------
DROP TABLE IF EXISTS `kpi_cds_mapping`;
CREATE TABLE `kpi_cds_mapping` (
  `mapping_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `kpi_id` int(11) NOT NULL,
  `cds_id` int(11) NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  `Parent_mapping_id` int(11) DEFAULT NULL,
  `accum_flag` varchar(10) COLLATE utf8_unicode_ci DEFAULT '0',
  PRIMARY KEY (`mapping_id`),
  KEY `kpi_kpi_cds_mapping_fk` (`kpi_id`),
  KEY `cds_kpi_cds_mapping_fk` (`cds_id`),
  KEY `kpi_cds_mapping_kpi_cds_mapping_fk` (`Parent_mapping_id`),
  CONSTRAINT `cds_kpi_cds_mapping_fk` FOREIGN KEY (`cds_id`) REFERENCES `cds` (`cds_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_cds_mapping_kpi_cds_mapping_fk` FOREIGN KEY (`Parent_mapping_id`) REFERENCES `kpi_cds_mapping` (`mapping_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_kpi_cds_mapping_fk` FOREIGN KEY (`kpi_id`) REFERENCES `kpi` (`kpi_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for kpi_evidence
-- ----------------------------
DROP TABLE IF EXISTS `kpi_evidence`;
CREATE TABLE `kpi_evidence` (
  `evidence_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `result_detail_id` int(11) NOT NULL,
  `evidence_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`evidence_id`),
  KEY `kpi_result_detail_kpi_evidence_fk` (`result_detail_id`),
  CONSTRAINT `kpi_result_detail_kpi_evidence_fk` FOREIGN KEY (`result_detail_id`) REFERENCES `kpi_result_detail` (`result_detail_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for kpi_group
-- ----------------------------
DROP TABLE IF EXISTS `kpi_group`;
CREATE TABLE `kpi_group` (
  `kpi_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `kpi_group_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_group_short_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `org_type_id` int(11) NOT NULL,
  `kpi_group_type_id` int(11) NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`kpi_group_id`),
  KEY `org_type_kpi_group_fk` (`org_type_id`),
  KEY `kpi_group_type_kpi_group_fk` (`kpi_group_type_id`),
  CONSTRAINT `kpi_group_type_kpi_group_fk` FOREIGN KEY (`kpi_group_type_id`) REFERENCES `kpi_group_type` (`kpi_group_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `org_type_kpi_group_fk` FOREIGN KEY (`org_type_id`) REFERENCES `org_type` (`org_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='กลุ่มตัวบ่งชี้';

-- ----------------------------
-- Table structure for kpi_group_type
-- ----------------------------
DROP TABLE IF EXISTS `kpi_group_type`;
CREATE TABLE `kpi_group_type` (
  `kpi_group_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `kpi_group_type_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`kpi_group_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ประเภทกลุ่มตัวบ่งชี้';

-- ----------------------------
-- Table structure for kpi_level
-- ----------------------------
DROP TABLE IF EXISTS `kpi_level`;
CREATE TABLE `kpi_level` (
  `kpi_level_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `kpi_level_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `level_no` int(11) NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`kpi_level_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ระดับตัวบ่งชี้';

-- ----------------------------
-- Table structure for kpi_org_mapping
-- ----------------------------
DROP TABLE IF EXISTS `kpi_org_mapping`;
CREATE TABLE `kpi_org_mapping` (
  `mapping_id` int(11) NOT NULL,
  `academic_year` int(11) NOT NULL,
  `kpi_id` int(11) NOT NULL,
  `org_id` int(11) NOT NULL,
  `updated_dttm` datetime NOT NULL,
  `created_dttm` datetime NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`mapping_id`),
  KEY `org_kpi_org_mapping_fk` (`org_id`),
  KEY `kpi_kpi_org_mapping_fk` (`kpi_id`),
  CONSTRAINT `kpi_kpi_org_mapping_fk` FOREIGN KEY (`kpi_id`) REFERENCES `kpi` (`kpi_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `org_kpi_org_mapping_fk` FOREIGN KEY (`org_id`) REFERENCES `org` (`org_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for kpi_recommend
-- ----------------------------
DROP TABLE IF EXISTS `kpi_recommend`;
CREATE TABLE `kpi_recommend` (
  `recommend_id` int(11) NOT NULL AUTO_INCREMENT,
  `org_id` int(11) NOT NULL,
  `academic_year` int(11) NOT NULL,
  `recommend_flag` char(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'S = จุดเด่น\r\nW = จุดอ่อน โอกาสในการพัฒนา',
  `recommend` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  `kpi_group_id` int(11) NOT NULL,
  PRIMARY KEY (`recommend_id`),
  KEY `org_kpi_recommend_fk` (`org_id`),
  CONSTRAINT `org_kpi_recommend_fk` FOREIGN KEY (`org_id`) REFERENCES `org` (`org_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for kpi_result
-- ----------------------------
DROP TABLE IF EXISTS `kpi_result`;
CREATE TABLE `kpi_result` (
  `result_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `month_id` int(11) NOT NULL,
  `org_id` int(11) NOT NULL,
  `org_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_level_id` int(11) NOT NULL,
  `kpi_level_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_group_id` int(11) NOT NULL,
  `kpi_group_short_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_group_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_structure_id` int(11) DEFAULT NULL COMMENT 'By King \r\n28/07/2015',
  `kpi_structure_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_type_id` int(11) NOT NULL,
  `kpi_type_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_type_short_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_id` int(11) NOT NULL,
  `kpi_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `criteria_type_id` int(11) NOT NULL,
  `formula_desc` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `calendar_type_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `period_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_uom_id` int(11) DEFAULT NULL COMMENT 'By King \r\n28/07/2015',
  `kpi_uom_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `multiplicand` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `denominator` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `benchmark_value` decimal(15,2) NOT NULL,
  `target_value` decimal(15,2) DEFAULT '0.00',
  `actual_value` decimal(15,2) DEFAULT '0.00',
  `percent_actual_vs_target` decimal(5,2) DEFAULT '0.00',
  `percent_actual_change` decimal(5,2) DEFAULT '0.00',
  `score` decimal(5,2) DEFAULT '0.00',
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`result_id`),
  KEY `criteria_type_kpi_result_fk` (`criteria_type_id`),
  KEY `organization_kpi_result_fk` (`org_id`),
  KEY `kpi_kpi_result_fk` (`kpi_id`),
  KEY `sys_month_kpi_result_fk` (`month_id`),
  CONSTRAINT `criteria_type_kpi_result_fk` FOREIGN KEY (`criteria_type_id`) REFERENCES `criteria_type` (`criteria_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_kpi_result_fk` FOREIGN KEY (`kpi_id`) REFERENCES `kpi` (`kpi_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `organization_kpi_result_fk` FOREIGN KEY (`org_id`) REFERENCES `org` (`org_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sys_month_kpi_result_fk` FOREIGN KEY (`month_id`) REFERENCES `sys_month` (`month_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7338 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for kpi_result_detail
-- ----------------------------
DROP TABLE IF EXISTS `kpi_result_detail`;
CREATE TABLE `kpi_result_detail` (
  `result_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `result_id` int(11) NOT NULL,
  `criteria_id` int(11) NOT NULL,
  `action_flag` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '1 ทำแล้ว/ผ่าน\r\n0 ยังไม่ทำ/ไม่ผ่าน',
  `evidence_flag` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'R = Standard Report\r\nL = URL \r\nF = Attached Files',
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`result_detail_id`),
  KEY `qualitative_criteria_kpi_result_detail_fk1` (`criteria_id`),
  KEY `kpi_result_kpi_result_detail_fk` (`result_id`),
  CONSTRAINT `kpi_result_kpi_result_detail_fk` FOREIGN KEY (`result_id`) REFERENCES `kpi_result` (`result_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `qualitative_criteria_kpi_result_detail_fk1` FOREIGN KEY (`criteria_id`) REFERENCES `qualitative_criteria` (`criteria_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='คุณภาพ';

-- ----------------------------
-- Table structure for kpi_structure
-- ----------------------------
DROP TABLE IF EXISTS `kpi_structure`;
CREATE TABLE `kpi_structure` (
  `kpi_structure_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `kpi_structure_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_group_id` int(11) NOT NULL,
  `strucuture_type_id` int(11) NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`kpi_structure_id`),
  KEY `structure_type_kpi_structure_fk` (`strucuture_type_id`),
  KEY `kpi_group_kpi_structure_fk` (`kpi_group_id`),
  CONSTRAINT `kpi_group_kpi_structure_fk` FOREIGN KEY (`kpi_group_id`) REFERENCES `kpi_group` (`kpi_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `structure_type_kpi_structure_fk` FOREIGN KEY (`strucuture_type_id`) REFERENCES `structure_type` (`strucuture_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='องค์ประกอบ';

-- ----------------------------
-- Table structure for kpi_type
-- ----------------------------
DROP TABLE IF EXISTS `kpi_type`;
CREATE TABLE `kpi_type` (
  `kpi_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `kpi_type_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_type_short_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`kpi_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ชนิดตัวบ่งชี้';

-- ----------------------------
-- Table structure for kpi_uom
-- ----------------------------
DROP TABLE IF EXISTS `kpi_uom`;
CREATE TABLE `kpi_uom` (
  `kpi_uom_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `kpi_uom_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`kpi_uom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for org
-- ----------------------------
DROP TABLE IF EXISTS `org`;
CREATE TABLE `org` (
  `org_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `org_code` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `org_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_level_id` int(11) NOT NULL,
  `criteria_group_detail_id` int(11) NOT NULL,
  `university_code` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `university_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `faculty_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `faculty_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `course_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `course_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mis_id` int(11) DEFAULT NULL,
  `reg_id` int(11) DEFAULT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  `parent_org_id` int(11) NOT NULL,
  `path` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`org_id`),
  KEY `kpi_level_organization_fk` (`kpi_level_id`),
  KEY `criteria_group_detail_org_fk` (`criteria_group_detail_id`),
  CONSTRAINT `criteria_group_detail_org_fk` FOREIGN KEY (`criteria_group_detail_id`) REFERENCES `criteria_group_detail` (`criteria_group_detail_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_level_organization_fk` FOREIGN KEY (`kpi_level_id`) REFERENCES `kpi_level` (`kpi_level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='หน่วยงานของมหาวิทยาลัย สถาบัน,คณะ,หลักสูตร';

-- ----------------------------
-- Table structure for org_result
-- ----------------------------
DROP TABLE IF EXISTS `org_result`;
CREATE TABLE `org_result` (
  `result_id` int(11) NOT NULL,
  `academic_year` int(11) NOT NULL,
  `month_id` int(11) NOT NULL,
  `org_id` int(11) NOT NULL,
  `org_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_level_id` int(11) NOT NULL,
  `kpi_level_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `score` decimal(5,2) NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`result_id`),
  KEY `org_university_result_fk` (`org_id`),
  KEY `sys_month_university_result_fk` (`month_id`),
  CONSTRAINT `org_university_result_fk` FOREIGN KEY (`org_id`) REFERENCES `org` (`org_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sys_month_university_result_fk` FOREIGN KEY (`month_id`) REFERENCES `sys_month` (`month_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for org_structure_result
-- ----------------------------
DROP TABLE IF EXISTS `org_structure_result`;
CREATE TABLE `org_structure_result` (
  `result_id` int(11) NOT NULL,
  `academic_year` int(11) NOT NULL,
  `month_id` int(11) NOT NULL,
  `org_id` int(11) NOT NULL,
  `org_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_level_id` int(11) NOT NULL,
  `kpi_level_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kpi_group_id` int(11) NOT NULL,
  `kpi_structure_id` int(11) NOT NULL,
  `kpi_structure_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `score` decimal(5,2) NOT NULL,
  `threshold_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`result_id`),
  KEY `kpi_structure_org_structure_result_fk` (`kpi_structure_id`),
  KEY `org_org_structure_result_fk` (`org_id`),
  KEY `sys_month_org_structure_result_fk` (`month_id`),
  CONSTRAINT `kpi_structure_org_structure_result_fk` FOREIGN KEY (`kpi_structure_id`) REFERENCES `kpi_structure` (`kpi_structure_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `org_org_structure_result_fk` FOREIGN KEY (`org_id`) REFERENCES `org` (`org_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sys_month_org_structure_result_fk` FOREIGN KEY (`month_id`) REFERENCES `sys_month` (`month_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for org_type
-- ----------------------------
DROP TABLE IF EXISTS `org_type`;
CREATE TABLE `org_type` (
  `org_type_id` int(11) NOT NULL,
  `org_type_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'หน่วยงานภายใน\r\nหน่วยงานภายนอก',
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`org_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ประเภทหน่วยงาน';

-- ----------------------------
-- Table structure for period
-- ----------------------------
DROP TABLE IF EXISTS `period`;
CREATE TABLE `period` (
  `period_id` int(11) NOT NULL AUTO_INCREMENT,
  `period_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '1 เดือน\r\n2 เดือน\r\n3 เดือน\r\n.\r\n.\r\n12 เดือน',
  `no_of_month` int(11) NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`period_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ช่วงเวลา\r\n1 เดือน\r\n2 เดือน\r\n3 เดือน\r\n.\r\n.\r\n12 เดือน';

-- ----------------------------
-- Table structure for qualitative_criteria
-- ----------------------------
DROP TABLE IF EXISTS `qualitative_criteria`;
CREATE TABLE `qualitative_criteria` (
  `criteria_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `running_no` int(11) DEFAULT NULL,
  `kpi_id` int(11) NOT NULL,
  `criteria_group_detail_id` int(11) NOT NULL,
  `cds_id` int(11) DEFAULT NULL,
  `criteria_desc` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`criteria_id`),
  KEY `criteria_group_detail_qualitative_criteria_fk` (`criteria_group_detail_id`),
  KEY `kpi_qualitative_criteria_fk` (`kpi_id`),
  KEY `common_data_set_qualitative_criteria_fk` (`cds_id`),
  CONSTRAINT `common_data_set_qualitative_criteria_fk` FOREIGN KEY (`cds_id`) REFERENCES `cds` (`cds_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `criteria_group_detail_qualitative_criteria_fk` FOREIGN KEY (`criteria_group_detail_id`) REFERENCES `criteria_group_detail` (`criteria_group_detail_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_qualitative_criteria_fk` FOREIGN KEY (`kpi_id`) REFERENCES `kpi` (`kpi_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='เกณฑ์มาตรฐาน';

-- ----------------------------
-- Table structure for quantitative_baseline
-- ----------------------------
DROP TABLE IF EXISTS `quantitative_baseline`;
CREATE TABLE `quantitative_baseline` (
  `baseline_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `kpi_id` int(11) NOT NULL,
  `criteria_group_detail_id` int(11) NOT NULL,
  `subtract_value` int(11) DEFAULT NULL,
  `percentage_conversion_value` int(11) NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`baseline_id`),
  KEY `criteria_group_detail_kpi_baseline_fk` (`criteria_group_detail_id`),
  KEY `kpi_kpi_baseline_fk` (`kpi_id`),
  CONSTRAINT `criteria_group_detail_kpi_baseline_fk` FOREIGN KEY (`criteria_group_detail_id`) REFERENCES `criteria_group_detail` (`criteria_group_detail_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_kpi_baseline_fk` FOREIGN KEY (`kpi_id`) REFERENCES `kpi` (`kpi_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for range_baseline
-- ----------------------------
DROP TABLE IF EXISTS `range_baseline`;
CREATE TABLE `range_baseline` (
  `baseline_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `kpi_id` int(11) NOT NULL,
  `criteria_group_detail_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `begin_baseline` int(11) NOT NULL,
  `end_baseline` int(11) NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  `baseline_desc` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`baseline_id`),
  KEY `criteria_group_detail_range_baseline_fk` (`criteria_group_detail_id`),
  KEY `kpi_qualitative_baseline_fk` (`kpi_id`),
  CONSTRAINT `criteria_group_detail_range_baseline_fk` FOREIGN KEY (`criteria_group_detail_id`) REFERENCES `criteria_group_detail` (`criteria_group_detail_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_qualitative_baseline_fk` FOREIGN KEY (`kpi_id`) REFERENCES `kpi` (`kpi_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for specified_baseline
-- ----------------------------
DROP TABLE IF EXISTS `specified_baseline`;
CREATE TABLE `specified_baseline` (
  `baseline_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `kpi_id` int(11) NOT NULL,
  `criteria_group_detail_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  `criteria_id` int(11) NOT NULL,
  PRIMARY KEY (`baseline_id`),
  KEY `criteria_group_detail_specified_baseline_fk` (`criteria_group_detail_id`),
  KEY `kpi_qualitative_baseline_specify_fk` (`kpi_id`),
  CONSTRAINT `criteria_group_detail_specified_baseline_fk` FOREIGN KEY (`criteria_group_detail_id`) REFERENCES `criteria_group_detail` (`criteria_group_detail_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kpi_qualitative_baseline_specify_fk` FOREIGN KEY (`kpi_id`) REFERENCES `kpi` (`kpi_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for specified_baseline_detail
-- ----------------------------
DROP TABLE IF EXISTS `specified_baseline_detail`;
CREATE TABLE `specified_baseline_detail` (
  `baseline_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `baseline_id` int(11) NOT NULL,
  `criteria_id` int(11) NOT NULL,
  `action_flag` char(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'เก็บทุกข้อแล้วมี flag บอกว่าข้อนี้ต้องทำหรือไม่ต้องทำ',
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`baseline_detail_id`),
  KEY `specified_baseline_specified_baseline_detail_fk` (`baseline_id`),
  KEY `qualitative_criteria_specified_baseline_detail_fk` (`criteria_id`),
  CONSTRAINT `qualitative_criteria_specified_baseline_detail_fk` FOREIGN KEY (`criteria_id`) REFERENCES `qualitative_criteria` (`criteria_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `specified_baseline_specified_baseline_detail_fk` FOREIGN KEY (`baseline_id`) REFERENCES `specified_baseline` (`baseline_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for structure_type
-- ----------------------------
DROP TABLE IF EXISTS `structure_type`;
CREATE TABLE `structure_type` (
  `strucuture_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `structure_type_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ผ่าน/ไม่ผ่าน\r\nคะแนน',
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`strucuture_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='เกณฑ์องค์ประกอบ';

-- ----------------------------
-- Table structure for sys_month
-- ----------------------------
DROP TABLE IF EXISTS `sys_month`;
CREATE TABLE `sys_month` (
  `month_id` int(11) NOT NULL AUTO_INCREMENT,
  `calendar_year` int(11) NOT NULL,
  `academic_year` int(11) DEFAULT NULL,
  `fiscal_year` int(11) DEFAULT NULL,
  `calendar_month_no` int(11) NOT NULL,
  `academic_month_no` int(11) DEFAULT NULL,
  `fiscal_month_no` int(11) DEFAULT NULL,
  `th_month_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `calendar2month` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calendar3month` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calendar4month` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calendar5month` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calendar6month` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calendar7month` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calendar8month` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calendar9month` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calendar10month` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calendar11month` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calendar12month` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `academic2month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `academic3month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `academic4month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `academic5month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `academic6month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `academic7month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `academic8month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `academic9month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `academic10month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `academic11month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `academic12month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fiscal2month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fiscal3month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fiscal4month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fiscal5month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fiscal6month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fiscal7month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fiscal8month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fiscal9month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fiscal10month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fiscal11month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fiscal12month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'SYSTEM',
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'SYSTEM',
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`month_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for sys_year
-- ----------------------------
DROP TABLE IF EXISTS `sys_year`;
CREATE TABLE `sys_year` (
  `year_id` int(11) NOT NULL AUTO_INCREMENT,
  `master_setup_academic_year` int(11) DEFAULT NULL COMMENT 'จับกับปีการศึกษา',
  `appraisal_academic_year` int(11) DEFAULT NULL COMMENT 'จับกับปีการศึกษา',
  `first_month_fiscal_year` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `first_month_academic_year` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`year_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for threshold
-- ----------------------------
DROP TABLE IF EXISTS `threshold`;
CREATE TABLE `threshold` (
  `threshold_id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` int(11) NOT NULL,
  `kpi_level_id` int(11) NOT NULL,
  `threshold_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `begin_threshold` decimal(5,2) NOT NULL,
  `end_threshold` decimal(5,2) NOT NULL,
  `color_code` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `updated_dttm` datetime NOT NULL,
  PRIMARY KEY (`threshold_id`),
  KEY `kpi_level_threshold_fk` (`kpi_level_id`),
  CONSTRAINT `kpi_level_threshold_fk` FOREIGN KEY (`kpi_level_id`) REFERENCES `kpi_level` (`kpi_level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for user_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(200) NOT NULL,
  `Roles` varchar(100) NOT NULL,
  `created_by` varchar(75) NOT NULL,
  `created_dttm` datetime NOT NULL,
  `updated_by` varchar(75) NOT NULL,
  `updated_dttm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for yearperiod
-- ----------------------------
DROP TABLE IF EXISTS `yearperiod`;
CREATE TABLE `yearperiod` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `monthNo` int(11) NOT NULL,
  `monthText` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Procedure structure for generateSysYearBySystemSetup
-- ----------------------------
DROP PROCEDURE IF EXISTS `generateSysYearBySystemSetup`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `generateSysYearBySystemSetup`(IN paramYear int, IN inCalendarMonthNo int, IN inFiscalMonth int)
BEGIN
	
DECLARE vAcademic_year_exist INT DEFAULT NULL;
DECLARE vLoopNo, vCalendarYearNo, vCalendarMonthNo  INT;
DECLARE vUser VARCHAR(50) DEFAULT "EDUQA_SYS";
SET vAcademic_year_exist := (SELECT distinct academic_year FROM sys_month WHERE academic_year = paramYear );
SET vLoopNo = 1;
SET vCalendarYearNo = paramYear;
SET vCalendarMonthNo = inCalendarMonthNo;
IF(vAcademic_year_exist IS NULL) THEN
	
	WHILE vLoopNo <= 12 DO
		
		IF(vCalendarMonthNo > 12) THEN 
			SET vCalendarMonthNo = 1;
			SET vCalendarYearNo = paramYear + 1;
		END IF;

		
		
		
		
		
		INSERT INTO sys_month (
			calendar_year,
			academic_year,
			fiscal_year,
			calendar_month_no,
			academic_month_no,
			fiscal_month_no,
			th_month_name,
			
			created_by,
			created_dttm,
			updated_by,
			updated_dttm	
			
		)VALUES(
			vCalendarYearNo,
			paramYear,	
			vCalendarYearNo, 
			vCalendarMonthNo,
			vLoopNo, 	
			fiscalMonthNo(inFiscalMonth, vCalendarMonthNo), 
			calendarMonthNameTh(vCalendarMonthNo),

			vUser,
			now(),
			vUser,
			now()
		);
	
	
	SET vCalendarMonthNo = vCalendarMonthNo + 1;
	SET vLoopNo = vLoopNo + 1;
	END WHILE;
	SELECT "Insert to sys_month is success.";
ELSE SELECT concat("Academic year (", paramYear,") is exist.");
END IF;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SysMonth_Generator
-- ----------------------------
DROP PROCEDURE IF EXISTS `SysMonth_Generator`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `SysMonth_Generator`(
in paramYear int(11)
)
BEGIN 
DECLARE done INT DEFAULT FALSE;
DECLARE calendarYear, yearLoop INT;
DECLARE monthName VARCHAR(50);
DECLARE cursor_years CURSOR FOR 
	select master_setup_academic_year+1 as years from sys_year
	union all select master_setup_academic_year as years from sys_year
	union all select master_setup_academic_year-1 as years from sys_year;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

SET yearLoop = 1;
OPEN cursor_years;
	REPEAT
		FETCH cursor_years INTO calendarYear;
		IF NOT done THEN

			
			
			insert_month_loop:LOOP
				block_month:BEGIN
					DECLARE doneMonth INT DEFAULT FALSE;
					DECLARE monthNo, monthLoop int;
					DECLARE monthName VARCHAR(50);
					DECLARE cursor_months CURSOR FOR
						select 1 as monthNo, 'มกราคม' as monthName
						union all select 2 as monthNo, 'กุมภาพันธ์' as monthName
						union all select 3 as monthNo, 'มีนาคม' as monthName
						union all select 4 as monthNo, 'เมษายน' as monthName
						union all select 5 as monthNo, 'พฤษภาคม' as monthName
						union all select 6 as monthNo, 'มิถุนายน' as monthName
						union all select 7 as monthNo, 'กรกฎาคม' as monthName
						union all select 8 as monthNo, 'สิงหาคม' as monthName
						union all select 9 as monthNo, 'กันยายน' as monthName
						union all select 10 as monthNo, 'ตุลาคม' as monthName
						union all select 11 as monthNo, 'พฤศจิกายน' as monthName
						union all select 12 as monthNo, 'ธันวาคม' as monthName;
					DECLARE CONTINUE HANDLER FOR NOT FOUND SET doneMonth = TRUE;

					SET monthLoop = 0;
					OPEN cursor_months;
					REPEAT
						FETCH cursor_months INTO monthNo, monthName;
						SET monthLoop = monthLoop + 1;
					
						IF NOT doneMonth THEN
							INSERT INTO sys_month_tt (
								calendar_year,
								academic_year, 
								fiscal_year,
								calendar_month_no,
								th_month_name
							)VALUES (
								calendarYear,
								calendarYear-1,
								YEAR(CURDATE())+543,
								monthNo,
								monthName
							);
						END IF;

						IF monthLoop = 12 THEN LEAVE insert_month_loop; END IF;
					UNTIL doneMonth END REPEAT;
					CLOSE cursor_months;
				END block_month;
			END LOOP insert_month_loop;
			

		END IF;
	UNTIL done END REPEAT;
CLOSE cursor_years;

END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for calendarMonthNameTh
-- ----------------------------
DROP FUNCTION IF EXISTS `calendarMonthNameTh`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calendarMonthNameTh`(monthNo integer) RETURNS varchar(50) CHARSET utf8 COLLATE utf8_unicode_ci
BEGIN
	DECLARE v_monthName VARCHAR(50) DEFAULT NULL;
	CASE monthNo
		WHEN 1 THEN SET v_monthName = "มกราคม";
		WHEN 2 THEN SET v_monthName = "กุมภาพันธ์";
		WHEN 3 THEN SET v_monthName = "มีนาคม";
		WHEN 4 THEN SET v_monthName = "เมษายน";
		WHEN 5 THEN SET v_monthName = "พฤษภาคม";
		WHEN 6 THEN SET v_monthName = "มิถุนายน";
		WHEN 7 THEN SET v_monthName = "กรกฎาคม";
		WHEN 8 THEN SET v_monthName = "สิงหาคม";
		WHEN 9 THEN SET v_monthName = "กันยายน";
		WHEN 10 THEN SET v_monthName = "ตุลาคม";
		WHEN 11 THEN SET v_monthName = "พฤศจิกายน";
		WHEN 12 THEN SET v_monthName = "ธันวาคม";
		ELSE SET v_monthName = "ไม่ระบุ";
	END CASE;

	RETURN v_monthName;

END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for fiscalMonthNo
-- ----------------------------
DROP FUNCTION IF EXISTS `fiscalMonthNo`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fiscalMonthNo`(parambeginMonth INTEGER, paramcalendarMonth INTEGER) RETURNS int(11)
BEGIN
	DECLARE V_FiscalMonthMo INTEGER DEFAULT NULL;

	CASE parambeginMonth
		WHEN 1 THEN 
			CASE paramcalendarMonth
				WHEN 1 THEN SET V_FiscalMonthMo = paramcalendarMonth;
				WHEN 2 THEN SET V_FiscalMonthMo = paramcalendarMonth;
				WHEN 3 THEN SET V_FiscalMonthMo = paramcalendarMonth;
				WHEN 4 THEN SET V_FiscalMonthMo = paramcalendarMonth;
				WHEN 5 THEN SET V_FiscalMonthMo = paramcalendarMonth;
				WHEN 6 THEN SET V_FiscalMonthMo = paramcalendarMonth;
				WHEN 7 THEN SET V_FiscalMonthMo = paramcalendarMonth;
				WHEN 8 THEN SET V_FiscalMonthMo = paramcalendarMonth;
				WHEN 9 THEN SET V_FiscalMonthMo = paramcalendarMonth;
				WHEN 10 THEN SET V_FiscalMonthMo = paramcalendarMonth;
				WHEN 11 THEN SET V_FiscalMonthMo = paramcalendarMonth;
				WHEN 12 THEN SET V_FiscalMonthMo = paramcalendarMonth;
				ELSE SET V_FiscalMonthMo = 0;
			END CASE;

		WHEN 2 THEN 
			CASE paramcalendarMonth
				WHEN 1 THEN SET V_FiscalMonthMo = 12;
				WHEN 2 THEN SET V_FiscalMonthMo = 1;
				WHEN 3 THEN SET V_FiscalMonthMo = 2;
				WHEN 4 THEN SET V_FiscalMonthMo = 3;
				WHEN 5 THEN SET V_FiscalMonthMo = 4;
				WHEN 6 THEN SET V_FiscalMonthMo = 5;
				WHEN 7 THEN SET V_FiscalMonthMo = 6;
				WHEN 8 THEN SET V_FiscalMonthMo = 7;
				WHEN 9 THEN SET V_FiscalMonthMo = 8;
				WHEN 10 THEN SET V_FiscalMonthMo = 9;
				WHEN 11 THEN SET V_FiscalMonthMo = 10;
				WHEN 12 THEN SET V_FiscalMonthMo = 11;
				ELSE SET V_FiscalMonthMo = 0;
			END CASE;

		WHEN 3 THEN 
			CASE paramcalendarMonth
				WHEN 1 THEN SET V_FiscalMonthMo = 11;
				WHEN 2 THEN SET V_FiscalMonthMo = 12;
				WHEN 3 THEN SET V_FiscalMonthMo = 1;
				WHEN 4 THEN SET V_FiscalMonthMo = 2;
				WHEN 5 THEN SET V_FiscalMonthMo = 3;
				WHEN 6 THEN SET V_FiscalMonthMo = 4;
				WHEN 7 THEN SET V_FiscalMonthMo = 5;
				WHEN 8 THEN SET V_FiscalMonthMo = 6;
				WHEN 9 THEN SET V_FiscalMonthMo = 7;
				WHEN 10 THEN SET V_FiscalMonthMo = 8;
				WHEN 11 THEN SET V_FiscalMonthMo = 9;
				WHEN 12 THEN SET V_FiscalMonthMo = 10;
				ELSE SET V_FiscalMonthMo = 0;
			END CASE;

		WHEN 4 THEN 
			CASE paramcalendarMonth
				WHEN 1 THEN SET V_FiscalMonthMo = 10;
				WHEN 2 THEN SET V_FiscalMonthMo = 11;
				WHEN 3 THEN SET V_FiscalMonthMo = 12;
				WHEN 4 THEN SET V_FiscalMonthMo = 1;
				WHEN 5 THEN SET V_FiscalMonthMo = 2;
				WHEN 6 THEN SET V_FiscalMonthMo = 3;
				WHEN 7 THEN SET V_FiscalMonthMo = 4;
				WHEN 8 THEN SET V_FiscalMonthMo = 5;
				WHEN 9 THEN SET V_FiscalMonthMo = 6;
				WHEN 10 THEN SET V_FiscalMonthMo = 7;
				WHEN 11 THEN SET V_FiscalMonthMo = 8;
				WHEN 12 THEN SET V_FiscalMonthMo = 9;
				ELSE SET V_FiscalMonthMo = 0;
			END CASE;

		WHEN 5 THEN 
			CASE paramcalendarMonth
				WHEN 1 THEN SET V_FiscalMonthMo = 9;
				WHEN 2 THEN SET V_FiscalMonthMo = 10;
				WHEN 3 THEN SET V_FiscalMonthMo = 11;
				WHEN 4 THEN SET V_FiscalMonthMo = 12;
				WHEN 5 THEN SET V_FiscalMonthMo = 1;
				WHEN 6 THEN SET V_FiscalMonthMo = 2;
				WHEN 7 THEN SET V_FiscalMonthMo = 3;
				WHEN 8 THEN SET V_FiscalMonthMo = 4;
				WHEN 9 THEN SET V_FiscalMonthMo = 5;
				WHEN 10 THEN SET V_FiscalMonthMo = 6;
				WHEN 11 THEN SET V_FiscalMonthMo = 7;
				WHEN 12 THEN SET V_FiscalMonthMo = 8;
				ELSE SET V_FiscalMonthMo = 0;
			END CASE;

		WHEN 6 THEN 
			CASE paramcalendarMonth
				WHEN 1 THEN SET V_FiscalMonthMo = 8;
				WHEN 2 THEN SET V_FiscalMonthMo = 9;
				WHEN 3 THEN SET V_FiscalMonthMo = 10;
				WHEN 4 THEN SET V_FiscalMonthMo = 11;
				WHEN 5 THEN SET V_FiscalMonthMo = 12;
				WHEN 6 THEN SET V_FiscalMonthMo = 1;
				WHEN 7 THEN SET V_FiscalMonthMo = 2;
				WHEN 8 THEN SET V_FiscalMonthMo = 3;
				WHEN 9 THEN SET V_FiscalMonthMo = 4;
				WHEN 10 THEN SET V_FiscalMonthMo = 5;
				WHEN 11 THEN SET V_FiscalMonthMo = 6;
				WHEN 12 THEN SET V_FiscalMonthMo = 7;
				ELSE SET V_FiscalMonthMo = 0;
			END CASE;

		WHEN 7 THEN 
			CASE paramcalendarMonth
				WHEN 1 THEN SET V_FiscalMonthMo = 7;
				WHEN 2 THEN SET V_FiscalMonthMo = 8;
				WHEN 3 THEN SET V_FiscalMonthMo = 9;
				WHEN 4 THEN SET V_FiscalMonthMo = 10;
				WHEN 5 THEN SET V_FiscalMonthMo = 11;
				WHEN 6 THEN SET V_FiscalMonthMo = 12;
				WHEN 7 THEN SET V_FiscalMonthMo = 1;
				WHEN 8 THEN SET V_FiscalMonthMo = 2;
				WHEN 9 THEN SET V_FiscalMonthMo = 3;
				WHEN 10 THEN SET V_FiscalMonthMo = 4;
				WHEN 11 THEN SET V_FiscalMonthMo = 5;
				WHEN 12 THEN SET V_FiscalMonthMo = 6;
				ELSE SET V_FiscalMonthMo = 0;
			END CASE;

		WHEN 8 THEN 
			CASE paramcalendarMonth
				WHEN 1 THEN SET V_FiscalMonthMo = 6;
				WHEN 2 THEN SET V_FiscalMonthMo = 7;
				WHEN 3 THEN SET V_FiscalMonthMo = 8;
				WHEN 4 THEN SET V_FiscalMonthMo = 9;
				WHEN 5 THEN SET V_FiscalMonthMo = 10;
				WHEN 6 THEN SET V_FiscalMonthMo = 11;
				WHEN 7 THEN SET V_FiscalMonthMo = 12;
				WHEN 8 THEN SET V_FiscalMonthMo = 1;
				WHEN 9 THEN SET V_FiscalMonthMo = 2;
				WHEN 10 THEN SET V_FiscalMonthMo = 3;
				WHEN 11 THEN SET V_FiscalMonthMo = 4;
				WHEN 12 THEN SET V_FiscalMonthMo = 5;
				ELSE SET V_FiscalMonthMo = 0;
			END CASE;

		WHEN 9 THEN 
			CASE paramcalendarMonth
				WHEN 1 THEN SET V_FiscalMonthMo = 5;
				WHEN 2 THEN SET V_FiscalMonthMo = 6;
				WHEN 3 THEN SET V_FiscalMonthMo = 7;
				WHEN 4 THEN SET V_FiscalMonthMo = 8;
				WHEN 5 THEN SET V_FiscalMonthMo = 9;
				WHEN 6 THEN SET V_FiscalMonthMo = 10;
				WHEN 7 THEN SET V_FiscalMonthMo = 11;
				WHEN 8 THEN SET V_FiscalMonthMo = 12;
				WHEN 9 THEN SET V_FiscalMonthMo = 1;
				WHEN 10 THEN SET V_FiscalMonthMo = 2;
				WHEN 11 THEN SET V_FiscalMonthMo = 3;
				WHEN 12 THEN SET V_FiscalMonthMo = 4;
				ELSE SET V_FiscalMonthMo = 0;
			END CASE;

		WHEN 10 THEN 
			CASE paramcalendarMonth
				WHEN 1 THEN SET V_FiscalMonthMo = 4;
				WHEN 2 THEN SET V_FiscalMonthMo = 5;
				WHEN 3 THEN SET V_FiscalMonthMo = 6;
				WHEN 4 THEN SET V_FiscalMonthMo = 7;
				WHEN 5 THEN SET V_FiscalMonthMo = 8;
				WHEN 6 THEN SET V_FiscalMonthMo = 9;
				WHEN 7 THEN SET V_FiscalMonthMo = 10;
				WHEN 8 THEN SET V_FiscalMonthMo = 11;
				WHEN 9 THEN SET V_FiscalMonthMo = 12;
				WHEN 10 THEN SET V_FiscalMonthMo = 1;
				WHEN 11 THEN SET V_FiscalMonthMo = 2;
				WHEN 12 THEN SET V_FiscalMonthMo = 3;
				ELSE SET V_FiscalMonthMo = 0;
			END CASE;

		WHEN 11 THEN 
			CASE paramcalendarMonth
				WHEN 1 THEN SET V_FiscalMonthMo = 3;
				WHEN 2 THEN SET V_FiscalMonthMo = 4;
				WHEN 3 THEN SET V_FiscalMonthMo = 5;
				WHEN 4 THEN SET V_FiscalMonthMo = 6;
				WHEN 5 THEN SET V_FiscalMonthMo = 7;
				WHEN 6 THEN SET V_FiscalMonthMo = 8;
				WHEN 7 THEN SET V_FiscalMonthMo = 9;
				WHEN 8 THEN SET V_FiscalMonthMo = 10;
				WHEN 9 THEN SET V_FiscalMonthMo = 11;
				WHEN 10 THEN SET V_FiscalMonthMo = 12;
				WHEN 11 THEN SET V_FiscalMonthMo = 1;
				WHEN 12 THEN SET V_FiscalMonthMo = 2;
				ELSE SET V_FiscalMonthMo = 0;
			END CASE;

		WHEN 12 THEN 
			CASE paramcalendarMonth
				WHEN 1 THEN SET V_FiscalMonthMo = 2;
				WHEN 2 THEN SET V_FiscalMonthMo = 3;
				WHEN 3 THEN SET V_FiscalMonthMo = 4;
				WHEN 4 THEN SET V_FiscalMonthMo = 5;
				WHEN 5 THEN SET V_FiscalMonthMo = 6;
				WHEN 6 THEN SET V_FiscalMonthMo = 7;
				WHEN 7 THEN SET V_FiscalMonthMo = 8;
				WHEN 8 THEN SET V_FiscalMonthMo = 9;
				WHEN 9 THEN SET V_FiscalMonthMo = 10;
				WHEN 10 THEN SET V_FiscalMonthMo = 11;
				WHEN 11 THEN SET V_FiscalMonthMo = 12;
				WHEN 12 THEN SET V_FiscalMonthMo = 1;
				ELSE SET V_FiscalMonthMo = 0;
			END CASE;
		ELSE SET V_FiscalMonthMo = 0;
	END CASE;
	
RETURN V_FiscalMonthMo;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for retriveLineParent
-- ----------------------------
DROP FUNCTION IF EXISTS `retriveLineParent`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `retriveLineParent`(orgid INTEGER) RETURNS text CHARSET utf8
BEGIN
DECLARE str TEXT;

select group_concat(org_id order by org_id asc) INTO str
from (
	select t.org_id, @p:=t.parent_org_id as parent_org_id 
from ( select * from org  order by org_id desc) t
join
(select @p:=orgid)tmp
where  t.org_id=@p
)tmp ;

RETURN str;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeCALENDAR_TYPE`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeCALENDAR_TYPE` BEFORE INSERT ON `calendar_type` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeCriteria_Group`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeCriteria_Group` BEFORE INSERT ON `criteria_group` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeCriteria_Group_Detail`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeCriteria_Group_Detail` BEFORE INSERT ON `criteria_group_detail` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeCriteria_Method`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeCriteria_Method` BEFORE INSERT ON `criteria_method` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeCriteria_Type`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeCriteria_Type` BEFORE INSERT ON `criteria_type` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeKpi_Group_Type`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeKpi_Group_Type` BEFORE INSERT ON `kpi_group_type` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeKpi_org_map`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeKpi_org_map` BEFORE INSERT ON `kpi_org_mapping` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeKpi_Structure`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeKpi_Structure` BEFORE INSERT ON `kpi_structure` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeKpi_Type`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeKpi_Type` BEFORE INSERT ON `kpi_type` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeKpi_Uom`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeKpi_Uom` BEFORE INSERT ON `kpi_uom` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeOrg_Result`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeOrg_Result` BEFORE INSERT ON `org_result` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeOrg_Stru_Result`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeOrg_Stru_Result` BEFORE INSERT ON `org_structure_result` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeOrg_Type`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeOrg_Type` BEFORE INSERT ON `org_type` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimePreiod`;
DELIMITER ;;
CREATE TRIGGER `setDateTimePreiod` BEFORE INSERT ON `period` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeSpecified_Baseline_d`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeSpecified_Baseline_d` BEFORE INSERT ON `specified_baseline_detail` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeStruc_Type`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeStruc_Type` BEFORE INSERT ON `structure_type` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeSysMonth`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeSysMonth` BEFORE INSERT ON `sys_month` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `setDateTimeSYS_YEAR`;
DELIMITER ;;
CREATE TRIGGER `setDateTimeSYS_YEAR` BEFORE INSERT ON `sys_year` FOR EACH ROW SET new.created_dttm = NOW(),
	new.updated_dttm = now(),
	new.created_by = "BY_TRIGGER",
	new.updated_by = "BY_TRIGGER"
;;
DELIMITER ;
