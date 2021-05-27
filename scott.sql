/*
 Navicat Premium Data Transfer

 Source Server         : LAMP虚拟机
 Source Server Type    : MariaDB
 Source Server Version : 50568
 Source Host           : 192.168.174.132:3306
 Source Schema         : scott

 Target Server Type    : MariaDB
 Target Server Version : 50568
 File Encoding         : 65001

 Date: 27/05/2021 17:44:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dept
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept`  (
  `deptno` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '部门编号',
  `dname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `loc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`deptno`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO `dept` VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO `dept` VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO `dept` VALUES (40, 'OPERATIONS', 'BOSTON');

-- ----------------------------
-- Table structure for emp
-- ----------------------------
DROP TABLE IF EXISTS `emp`;
CREATE TABLE `emp`  (
  `empno` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '雇员编号',
  `ename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '雇员名称',
  `job` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '岗位工种',
  `mgr` int(11) NULL DEFAULT NULL COMMENT '上级',
  `hiredate` date NULL DEFAULT NULL COMMENT '雇佣日期',
  `sal` decimal(11, 2) NULL DEFAULT NULL COMMENT '工资',
  `comm` decimal(11, 2) NULL DEFAULT NULL COMMENT '奖金|准贴',
  `deptno` int(11) NULL DEFAULT NULL COMMENT '外键，dept表的deptno关联',
  PRIMARY KEY (`empno`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '雇员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of emp
-- ----------------------------
INSERT INTO `emp` VALUES (1, 'SMITH', 'CLERK', 3, '1980-12-17', 800.00, NULL, 10);
INSERT INTO `emp` VALUES (2, 'ALLEM', 'SALESMAN', 3, '2021-05-29', 1600.00, 300.00, 30);
INSERT INTO `emp` VALUES (3, 'FORD', 'ANALYST', NULL, '1981-12-03', 3000.00, NULL, 20);

-- ----------------------------
-- Table structure for salgrade
-- ----------------------------
DROP TABLE IF EXISTS `salgrade`;
CREATE TABLE `salgrade`  (
  `grade` int(11) NULL DEFAULT NULL COMMENT '等级',
  `losal` decimal(11, 2) NULL DEFAULT NULL COMMENT '最低',
  `hisal` decimal(11, 2) NULL DEFAULT NULL COMMENT '最高'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '工资等级表' ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
