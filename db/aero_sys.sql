/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : aero_sys

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 13/09/2021 15:36:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `right` tinyint(0) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`account`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('11111111111', '123456', 0);
INSERT INTO `account` VALUES ('13225079670', '123456', 0);
INSERT INTO `account` VALUES ('13515070051', '123456', 0);
INSERT INTO `account` VALUES ('admin01', '888', 1);
INSERT INTO `account` VALUES ('admin02', '888', 1);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `right` tinyint(1) NOT NULL,
  `adminName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `adminIDCard` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`account`) USING BTREE,
  CONSTRAINT `FK_继承2` FOREIGN KEY (`account`) REFERENCES `account` (`account`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('admin01', '888', 1, '管理员01', '1999-01-01');
INSERT INTO `admin` VALUES ('admin02', '888', 1, '管理员02', '1999-01-01');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `memberID` int(0) NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `right` tinyint(0) UNSIGNED NOT NULL DEFAULT 0,
  `userName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `birthdate` date NOT NULL,
  `userIDCard` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `userTel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `point` int(0) NOT NULL,
  `userSex` tinyint(1) NOT NULL,
  PRIMARY KEY (`account`) USING BTREE,
  INDEX `FK_属于`(`memberID`) USING BTREE,
  CONSTRAINT `FK_属于` FOREIGN KEY (`memberID`) REFERENCES `member` (`memberID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_继承` FOREIGN KEY (`account`) REFERENCES `account` (`account`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('11111111111', 0, '123456', 0, '13515070051', '2021-09-01', '111111111111111111', '11111111111', '123@qq.com', 0, 1);
INSERT INTO `customer` VALUES ('13225079670', 2, '123456', 0, '用户2', '1999-01-01', '360428199901010102', '13225079670', '888888@163.com', 30000, 1);
INSERT INTO `customer` VALUES ('13515070051', 1, '123456', 0, '用户1', '1999-01-01', '360428199901010101', '13515070051', '888888@qq.com', 30000, 1);

-- ----------------------------
-- Table structure for exflight
-- ----------------------------
DROP TABLE IF EXISTS `exflight`;
CREATE TABLE `exflight`  (
  `flightID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `exFlightDate` date NOT NULL,
  `flightStateID` int(0) NULL DEFAULT NULL,
  `foodTypeID` int(0) NULL DEFAULT NULL,
  `totalTime` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `departTime` time(0) NULL DEFAULT NULL,
  `arriveTime` time(0) NULL DEFAULT NULL,
  `onRevise` tinyint(1) NOT NULL,
  `onRefund` tinyint(1) NOT NULL,
  PRIMARY KEY (`flightID`, `exFlightDate`) USING BTREE,
  INDEX `FK_提供`(`foodTypeID`) USING BTREE,
  INDEX `FK_航班状态`(`flightStateID`) USING BTREE,
  CONSTRAINT `FK_提供` FOREIGN KEY (`foodTypeID`) REFERENCES `foodtype` (`foodTypeID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_航班状态` FOREIGN KEY (`flightStateID`) REFERENCES `flightstate` (`flightStateID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_该日航班` FOREIGN KEY (`flightID`) REFERENCES `flight` (`flightID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exflight
-- ----------------------------
INSERT INTO `exflight` VALUES ('MF1235', '2019-01-21', 1, 2, '3:30:00', '19:40:00', '23:10:00', 1, 1);
INSERT INTO `exflight` VALUES ('MF1235', '2019-01-22', 1, 2, '3:30:00', '19:40:00', '23:10:00', 1, 1);
INSERT INTO `exflight` VALUES ('MF1235', '2021-09-11', 1, 2, '3:30:00', '19:40:00', '23:10:00', 1, 0);
INSERT INTO `exflight` VALUES ('MF2310', '2019-01-20', 1, 2, '2:10:00', '08:40:00', '10:50:00', 1, 1);
INSERT INTO `exflight` VALUES ('MF2310', '2019-01-21', 1, 2, '2:10:00', '08:40:00', '10:50:00', 1, 1);
INSERT INTO `exflight` VALUES ('MF2332', '2019-01-21', 1, 2, '3:30:00', '17:10:00', '20:40:00', 1, 1);
INSERT INTO `exflight` VALUES ('MF2332', '2019-01-22', 1, 2, '3:30:00', '17:10:00', '20:40:00', 1, 1);
INSERT INTO `exflight` VALUES ('MF2332', '2019-01-23', 1, 2, '3:30:00', '17:10:00', '20:40:00', 1, 1);
INSERT INTO `exflight` VALUES ('MF3456', '2019-01-23', 1, 2, '2:30:00', '09:10:00', '11:40:00', 1, 1);
INSERT INTO `exflight` VALUES ('MF3456', '2019-01-24', 1, 2, '2:30:00', '09:10:00', '11:40:00', 1, 1);
INSERT INTO `exflight` VALUES ('MF3461', '2019-01-22', 1, 2, '3:25:00', '19:40:00', '23:05:00', 1, 1);
INSERT INTO `exflight` VALUES ('MF3461', '2019-01-23', 1, 2, '3:25:00', '19:40:00', '23:05:00', 1, 1);
INSERT INTO `exflight` VALUES ('MF3461', '2019-01-24', 1, 2, '3:25:00', '19:40:00', '23:05:00', 1, 1);

-- ----------------------------
-- Table structure for exflightproduct
-- ----------------------------
DROP TABLE IF EXISTS `exflightproduct`;
CREATE TABLE `exflightproduct`  (
  `flightID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `exFlightDate` date NOT NULL,
  `flightProductID` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `price` int(0) NOT NULL,
  `pointPrice` int(0) NOT NULL,
  `leftTicketNum` int(0) NOT NULL,
  `onSale` tinyint(1) NOT NULL,
  PRIMARY KEY (`flightID`, `exFlightDate`, `flightProductID`) USING BTREE,
  INDEX `FK_该日舱位`(`flightProductID`) USING BTREE,
  CONSTRAINT `FK_具有_1` FOREIGN KEY (`flightID`, `exFlightDate`) REFERENCES `exflight` (`flightID`, `exFlightDate`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_该日舱位` FOREIGN KEY (`flightProductID`) REFERENCES `flightproduct` (`flightProductID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exflightproduct
-- ----------------------------
INSERT INTO `exflightproduct` VALUES ('MF1235', '2019-01-21', 'A', 520, 4500, 120, 1);
INSERT INTO `exflightproduct` VALUES ('MF1235', '2019-01-21', 'B', 800, 6000, 60, 1);
INSERT INTO `exflightproduct` VALUES ('MF1235', '2019-01-21', 'C', 1100, 7500, 20, 1);
INSERT INTO `exflightproduct` VALUES ('MF1235', '2019-01-22', 'A', 520, 4500, 120, 1);
INSERT INTO `exflightproduct` VALUES ('MF1235', '2019-01-22', 'B', 800, 6000, 60, 1);
INSERT INTO `exflightproduct` VALUES ('MF1235', '2019-01-22', 'C', 1100, 7500, 20, 1);
INSERT INTO `exflightproduct` VALUES ('MF1235', '2021-09-11', 'A', 520, 4500, 120, 1);
INSERT INTO `exflightproduct` VALUES ('MF1235', '2021-09-11', 'B', 800, 6000, 60, 1);
INSERT INTO `exflightproduct` VALUES ('MF1235', '2021-09-11', 'C', 1100, 7500, 20, 1);
INSERT INTO `exflightproduct` VALUES ('MF2310', '2019-01-20', 'A', 680, 5500, 120, 1);
INSERT INTO `exflightproduct` VALUES ('MF2310', '2019-01-20', 'B', 802, 6602, 60, 1);
INSERT INTO `exflightproduct` VALUES ('MF2310', '2019-01-20', 'C', 1205, 8200, 20, 1);
INSERT INTO `exflightproduct` VALUES ('MF2310', '2019-01-21', 'A', 680, 5500, 120, 1);
INSERT INTO `exflightproduct` VALUES ('MF2310', '2019-01-21', 'B', 802, 6602, 60, 1);
INSERT INTO `exflightproduct` VALUES ('MF2310', '2019-01-21', 'C', 1205, 8200, 20, 1);
INSERT INTO `exflightproduct` VALUES ('MF2332', '2019-01-21', 'A', 600, 5200, 180, 1);
INSERT INTO `exflightproduct` VALUES ('MF2332', '2019-01-21', 'B', 820, 6230, 60, 1);
INSERT INTO `exflightproduct` VALUES ('MF2332', '2019-01-21', 'C', 1020, 7030, 20, 1);
INSERT INTO `exflightproduct` VALUES ('MF2332', '2019-01-22', 'A', 600, 5200, 180, 1);
INSERT INTO `exflightproduct` VALUES ('MF2332', '2019-01-22', 'B', 820, 6230, 60, 1);
INSERT INTO `exflightproduct` VALUES ('MF2332', '2019-01-22', 'C', 1020, 7030, 20, 1);
INSERT INTO `exflightproduct` VALUES ('MF2332', '2019-01-23', 'A', 600, 5200, 180, 1);
INSERT INTO `exflightproduct` VALUES ('MF2332', '2019-01-23', 'B', 820, 6230, 60, 1);
INSERT INTO `exflightproduct` VALUES ('MF2332', '2019-01-23', 'C', 1020, 7030, 20, 1);
INSERT INTO `exflightproduct` VALUES ('MF3456', '2019-01-23', 'A', 580, 4580, 160, 1);
INSERT INTO `exflightproduct` VALUES ('MF3456', '2019-01-23', 'B', 685, 5300, 80, 1);
INSERT INTO `exflightproduct` VALUES ('MF3456', '2019-01-23', 'C', 950, 8420, 20, 1);
INSERT INTO `exflightproduct` VALUES ('MF3456', '2019-01-24', 'A', 580, 4580, 160, 1);
INSERT INTO `exflightproduct` VALUES ('MF3456', '2019-01-24', 'B', 685, 5300, 80, 1);
INSERT INTO `exflightproduct` VALUES ('MF3456', '2019-01-24', 'C', 950, 8420, 20, 1);
INSERT INTO `exflightproduct` VALUES ('MF3461', '2019-01-22', 'A', 560, 4300, 120, 1);
INSERT INTO `exflightproduct` VALUES ('MF3461', '2019-01-22', 'B', 700, 5200, 60, 1);
INSERT INTO `exflightproduct` VALUES ('MF3461', '2019-01-22', 'C', 1050, 7030, 20, 1);
INSERT INTO `exflightproduct` VALUES ('MF3461', '2019-01-23', 'A', 560, 4300, 120, 1);
INSERT INTO `exflightproduct` VALUES ('MF3461', '2019-01-23', 'B', 700, 5200, 60, 1);
INSERT INTO `exflightproduct` VALUES ('MF3461', '2019-01-23', 'C', 1050, 7030, 20, 1);
INSERT INTO `exflightproduct` VALUES ('MF3461', '2019-01-24', 'A', 560, 4300, 120, 1);
INSERT INTO `exflightproduct` VALUES ('MF3461', '2019-01-24', 'B', 700, 5200, 60, 1);
INSERT INTO `exflightproduct` VALUES ('MF3461', '2019-01-24', 'C', 1050, 7030, 20, 1);

-- ----------------------------
-- Table structure for ffp
-- ----------------------------
DROP TABLE IF EXISTS `ffp`;
CREATE TABLE `ffp`  (
  `flightProductID` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `flightID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `seatNum` int(0) NOT NULL,
  `prePrice` int(0) NOT NULL,
  `prePointPrice` int(0) NOT NULL,
  `rewardPoint` int(0) NOT NULL,
  PRIMARY KEY (`flightProductID`, `flightID`) USING BTREE,
  INDEX `FK_FFP2`(`flightID`) USING BTREE,
  CONSTRAINT `FK_FFP` FOREIGN KEY (`flightProductID`) REFERENCES `flightproduct` (`flightProductID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_FFP2` FOREIGN KEY (`flightID`) REFERENCES `flight` (`flightID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ffp
-- ----------------------------
INSERT INTO `ffp` VALUES ('A', 'MF1235', 120, 520, 4500, 500);
INSERT INTO `ffp` VALUES ('A', 'MF2310', 120, 680, 5500, 720);
INSERT INTO `ffp` VALUES ('A', 'MF2332', 180, 600, 5200, 580);
INSERT INTO `ffp` VALUES ('A', 'MF3456', 160, 580, 4580, 450);
INSERT INTO `ffp` VALUES ('A', 'MF3461', 120, 560, 4300, 500);
INSERT INTO `ffp` VALUES ('A', 'MF3780', 60, 468, 4820, 582);
INSERT INTO `ffp` VALUES ('A', 'MF4258', 160, 380, 3890, 400);
INSERT INTO `ffp` VALUES ('A', 'MF4862', 120, 680, 5430, 580);
INSERT INTO `ffp` VALUES ('A', 'MF6115', 120, 620, 5530, 820);
INSERT INTO `ffp` VALUES ('A', 'MF7132', 120, 820, 6530, 820);
INSERT INTO `ffp` VALUES ('A', 'MF7520', 120, 598, 5300, 590);
INSERT INTO `ffp` VALUES ('A', 'MF7843', 80, 350, 3560, 349);
INSERT INTO `ffp` VALUES ('A', 'MF8778', 100, 820, 5530, 820);
INSERT INTO `ffp` VALUES ('A', 'MF8864', 180, 502, 4203, 480);
INSERT INTO `ffp` VALUES ('A', 'MF9400', 120, 502, 4203, 480);
INSERT INTO `ffp` VALUES ('A', 'MF9500', 120, 450, 4203, 523);
INSERT INTO `ffp` VALUES ('A', 'MF9510', 180, 549, 4690, 450);
INSERT INTO `ffp` VALUES ('A', 'MF9513', 160, 580, 6890, 670);
INSERT INTO `ffp` VALUES ('A', 'MF9520', 120, 550, 4200, 389);
INSERT INTO `ffp` VALUES ('B', 'MF1235', 60, 800, 6000, 600);
INSERT INTO `ffp` VALUES ('B', 'MF2310', 60, 802, 6602, 900);
INSERT INTO `ffp` VALUES ('B', 'MF2332', 60, 820, 6230, 650);
INSERT INTO `ffp` VALUES ('B', 'MF3456', 80, 685, 5300, 680);
INSERT INTO `ffp` VALUES ('B', 'MF3461', 60, 700, 5200, 720);
INSERT INTO `ffp` VALUES ('B', 'MF3780', 40, 720, 5030, 783);
INSERT INTO `ffp` VALUES ('B', 'MF4258', 80, 682, 4300, 792);
INSERT INTO `ffp` VALUES ('B', 'MF4862', 60, 910, 6820, 850);
INSERT INTO `ffp` VALUES ('B', 'MF6115', 60, 843, 7600, 1000);
INSERT INTO `ffp` VALUES ('B', 'MF7132', 60, 1002, 7600, 1000);
INSERT INTO `ffp` VALUES ('B', 'MF7520', 60, 890, 6870, 800);
INSERT INTO `ffp` VALUES ('B', 'MF7843', 40, 458, 4800, 520);
INSERT INTO `ffp` VALUES ('B', 'MF8778', 60, 1002, 7600, 1000);
INSERT INTO `ffp` VALUES ('B', 'MF8864', 60, 720, 5230, 600);
INSERT INTO `ffp` VALUES ('B', 'MF9400', 60, 720, 5230, 600);
INSERT INTO `ffp` VALUES ('B', 'MF9500', 60, 729, 6210, 720);
INSERT INTO `ffp` VALUES ('B', 'MF9510', 60, 690, 5700, 602);
INSERT INTO `ffp` VALUES ('B', 'MF9513', 80, 982, 7300, 892);
INSERT INTO `ffp` VALUES ('B', 'MF9520', 60, 689, 5843, 630);
INSERT INTO `ffp` VALUES ('C', 'MF1235', 20, 1100, 7500, 700);
INSERT INTO `ffp` VALUES ('C', 'MF2310', 20, 1205, 8200, 1000);
INSERT INTO `ffp` VALUES ('C', 'MF2332', 20, 1020, 7030, 950);
INSERT INTO `ffp` VALUES ('C', 'MF3456', 20, 950, 8420, 890);
INSERT INTO `ffp` VALUES ('C', 'MF3461', 20, 1050, 7030, 880);
INSERT INTO `ffp` VALUES ('C', 'MF3780', 20, 1020, 7200, 850);
INSERT INTO `ffp` VALUES ('C', 'MF4258', 20, 1010, 7500, 1000);
INSERT INTO `ffp` VALUES ('C', 'MF4862', 20, 1020, 7050, 879);
INSERT INTO `ffp` VALUES ('C', 'MF6115', 20, 1103, 9230, 1240);
INSERT INTO `ffp` VALUES ('C', 'MF7132', 20, 1400, 9230, 1800);
INSERT INTO `ffp` VALUES ('C', 'MF7520', 20, 923, 7600, 1020);
INSERT INTO `ffp` VALUES ('C', 'MF7843', 30, 702, 5600, 680);
INSERT INTO `ffp` VALUES ('C', 'MF8778', 20, 1400, 9230, 1800);
INSERT INTO `ffp` VALUES ('C', 'MF8864', 20, 900, 7030, 950);
INSERT INTO `ffp` VALUES ('C', 'MF9400', 20, 900, 7030, 950);
INSERT INTO `ffp` VALUES ('C', 'MF9500', 20, 992, 7030, 902);
INSERT INTO `ffp` VALUES ('C', 'MF9510', 20, 890, 7200, 829);
INSERT INTO `ffp` VALUES ('C', 'MF9513', 20, 1120, 8500, 1020);
INSERT INTO `ffp` VALUES ('C', 'MF9520', 20, 983, 7304, 823);

-- ----------------------------
-- Table structure for flight
-- ----------------------------
DROP TABLE IF EXISTS `flight`;
CREATE TABLE `flight`  (
  `flightID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `preDepartTime` time(0) NOT NULL,
  `preTotalTime` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `flightType` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `totalSeatNum` int(0) NOT NULL,
  `departCity` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `arriveCity` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `insurancePrice` int(0) NOT NULL,
  PRIMARY KEY (`flightID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flight
-- ----------------------------
INSERT INTO `flight` VALUES ('MF1235', '19:40:00', '3:30:00', '波音747', 200, '北京市', '上海市', 50);
INSERT INTO `flight` VALUES ('MF2310', '08:40:00', '2:10:00', '波音747', 200, '北京市', '上海市', 35);
INSERT INTO `flight` VALUES ('MF2332', '17:10:00', '3:30:00', '空客A300', 260, '广州市', '南京市', 40);
INSERT INTO `flight` VALUES ('MF3456', '09:10:00', '2:30:00', '空客A300', 260, '深圳市', '北京市', 40);
INSERT INTO `flight` VALUES ('MF3461', '19:40:00', '3:25:00', '波音747', 200, '南京市', '上海市', 25);
INSERT INTO `flight` VALUES ('MF3780', '07:30:00', '2:40:00', '波音737', 120, '北京市', '杭州市', 20);
INSERT INTO `flight` VALUES ('MF4258', '17:10:00', '1:50:00', '空客A300', 260, '北京市', '重庆市', 25);
INSERT INTO `flight` VALUES ('MF4862', '12:32:00', '5:30:00', '空客A321', 200, '杭州市', '天津市', 30);
INSERT INTO `flight` VALUES ('MF6115', '19:40:00', '4:20:00', '波音747', 200, '杭州市', '青岛市', 30);
INSERT INTO `flight` VALUES ('MF7132', '19:32:00', '2:10:00', '空客A321', 200, '苏州市', '天津市', 25);
INSERT INTO `flight` VALUES ('MF7520', '05:40:00', '3:10:00', '波音747', 200, '上海市', '武汉市', 20);
INSERT INTO `flight` VALUES ('MF7843', '07:35:00', '6:30:00', '空客A321', 150, '杭州市', '重庆市', 30);
INSERT INTO `flight` VALUES ('MF8778', '12:35:00', '3:30:00', '空客A321', 180, '武汉市', '天津市', 45);
INSERT INTO `flight` VALUES ('MF8864', '17:10:00', '4:30:00', '空客A300', 260, '武汉市', '北京市', 20);
INSERT INTO `flight` VALUES ('MF9400', '08:10:00', '3:20:00', '空客A300', 200, '常州市', '广州市', 40);
INSERT INTO `flight` VALUES ('MF9500', '16:40:00', '4:00:00', '波音747', 200, '武汉市', '青岛市', 55);
INSERT INTO `flight` VALUES ('MF9510', '11:10:00', '5:10:00', '空客A300', 260, '广州市', '无锡市', 15);
INSERT INTO `flight` VALUES ('MF9513', '13:10:00', '6:30:00', '空客A300', 260, '温州市', '青岛市', 30);
INSERT INTO `flight` VALUES ('MF9520', '19:40:00', '2:25:00', '波音747', 200, '武汉市', '南京市', 25);
INSERT INTO `flight` VALUES ('MF9853', '12:30:00', '3:30:00', '空客321', 200, '深圳市', '武汉市', 40);

-- ----------------------------
-- Table structure for flightproduct
-- ----------------------------
DROP TABLE IF EXISTS `flightproduct`;
CREATE TABLE `flightproduct`  (
  `flightProductID` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `flightProductName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`flightProductID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flightproduct
-- ----------------------------
INSERT INTO `flightproduct` VALUES ('A', '经济舱');
INSERT INTO `flightproduct` VALUES ('B', '商务舱');
INSERT INTO `flightproduct` VALUES ('C', '头等舱');

-- ----------------------------
-- Table structure for flightstate
-- ----------------------------
DROP TABLE IF EXISTS `flightstate`;
CREATE TABLE `flightstate`  (
  `flightStateID` int(0) NOT NULL,
  `flightStateContext` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`flightStateID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flightstate
-- ----------------------------
INSERT INTO `flightstate` VALUES (1, '计划');
INSERT INTO `flightstate` VALUES (2, '到达');
INSERT INTO `flightstate` VALUES (3, '取消');
INSERT INTO `flightstate` VALUES (4, '延误');

-- ----------------------------
-- Table structure for foodtype
-- ----------------------------
DROP TABLE IF EXISTS `foodtype`;
CREATE TABLE `foodtype`  (
  `foodTypeID` int(0) NOT NULL,
  `foodName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`foodTypeID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of foodtype
-- ----------------------------
INSERT INTO `foodtype` VALUES (1, '正餐');
INSERT INTO `foodtype` VALUES (2, '点心');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `memberID` int(0) NOT NULL,
  `memberName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`memberID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (0, '普通会员');
INSERT INTO `member` VALUES (1, '黄金会员');
INSERT INTO `member` VALUES (2, '白金会员');

-- ----------------------------
-- Table structure for orderlist
-- ----------------------------
DROP TABLE IF EXISTS `orderlist`;
CREATE TABLE `orderlist`  (
  `account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `orderID` int(0) NOT NULL,
  `orderTime` datetime(0) NOT NULL,
  PRIMARY KEY (`account`, `orderID`) USING BTREE,
  CONSTRAINT `FK_查询` FOREIGN KEY (`account`) REFERENCES `customer` (`account`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderlist
-- ----------------------------
INSERT INTO `orderlist` VALUES ('13225079670', 1, '2019-01-10 12:00:00');
INSERT INTO `orderlist` VALUES ('13225079670', 2, '2019-01-11 12:00:00');
INSERT INTO `orderlist` VALUES ('13225079670', 3, '2019-01-11 12:00:00');
INSERT INTO `orderlist` VALUES ('13515070051', 1, '2019-01-12 10:00:00');
INSERT INTO `orderlist` VALUES ('13515070051', 2, '2019-01-13 10:00:00');

-- ----------------------------
-- Table structure for rulelist
-- ----------------------------
DROP TABLE IF EXISTS `rulelist`;
CREATE TABLE `rulelist`  (
  `ruleID` int(0) NOT NULL,
  `ruleContext` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `reviseTime` datetime(0) NOT NULL,
  PRIMARY KEY (`ruleID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rulelist
-- ----------------------------
INSERT INTO `rulelist` VALUES (1, '\r\n1、由于天气、空中交通管制、机务维修、航班调配等原因，BlueSky网站可能会调整原来的航班。包括更改机型或航线、取消、中断、推迟或延期航班飞行。\r\n2、在航班起飞时间2小时前（含2小时）退票，收取未使用航段经济舱全票价（Y）的30%，最高不超过未使用航段的票面价；若在航班起飞时间前2小时内（不含2小时）及航班起飞后办理仅退还机场建设费及燃油附加费。 \r\n3、特价机票当班有效，不得升舱、不得签转、不得变更。\r\n4、在客票的有效期内，误机费是按次收取，即每次误机后如需改期，按已误机航班舱位的限制条件收取相应误机费。 \r\n5、特价机票当班有效，不得升/降舱、不得签转、不得变更。 \r\n6、BlueSky网站于航班起飞前3小时停止对外销售机票。\r\n', '2019-01-05 00:00:00');

-- ----------------------------
-- Table structure for statement
-- ----------------------------
DROP TABLE IF EXISTS `statement`;
CREATE TABLE `statement`  (
  `flightID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `year` int(0) NOT NULL,
  `month` int(0) NOT NULL,
  `ticketNum` int(0) NOT NULL,
  `income` int(0) NOT NULL,
  `rate` float NOT NULL,
  `exNum` int(0) NOT NULL,
  PRIMARY KEY (`flightID`, `year`, `month`) USING BTREE,
  CONSTRAINT `FK_该月报表` FOREIGN KEY (`flightID`) REFERENCES `flight` (`flightID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of statement
-- ----------------------------
INSERT INTO `statement` VALUES ('MF1235', 2018, 12, 4500, 60000, 0.956, 45);
INSERT INTO `statement` VALUES ('MF2310', 2018, 12, 3856, 53000, 0.914, 39);
INSERT INTO `statement` VALUES ('MF2332', 2018, 12, 5642, 71500, 0.974, 41);
INSERT INTO `statement` VALUES ('MF3456', 2018, 12, 2980, 46200, 0.897, 31);
INSERT INTO `statement` VALUES ('MF3461', 2018, 12, 3420, 48520, 0.923, 42);

-- ----------------------------
-- Table structure for ticket
-- ----------------------------
DROP TABLE IF EXISTS `ticket`;
CREATE TABLE `ticket`  (
  `account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `orderID` int(0) NOT NULL,
  `ticketID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `flightID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `exFlightDate` date NOT NULL,
  `flightProductID` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `passengerName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `passengerTel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `passengerIDCard` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `insurance` tinyint(1) NOT NULL,
  `payment` tinyint(1) NOT NULL,
  `ticketPrice` int(0) NOT NULL,
  `passengerSex` tinyint(1) NOT NULL,
  PRIMARY KEY (`account`, `orderID`, `ticketID`) USING BTREE,
  INDEX `FK_舱位机票`(`flightID`, `exFlightDate`, `flightProductID`) USING BTREE,
  CONSTRAINT `FK_舱位机票` FOREIGN KEY (`flightID`, `exFlightDate`, `flightProductID`) REFERENCES `exflightproduct` (`flightID`, `exFlightDate`, `flightProductID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_订单项目详情` FOREIGN KEY (`account`, `orderID`) REFERENCES `orderlist` (`account`, `orderID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ticket
-- ----------------------------
INSERT INTO `ticket` VALUES ('13225079670', 1, '731-01234567-001', 'MF1235', '2021-09-11', 'A', '乘客01', '13225079670', '360428199901010101', 35, 1, 520, 1);
INSERT INTO `ticket` VALUES ('13225079670', 1, '731-01234567-002', 'MF2310', '2019-01-21', 'A', '乘客02', '13225079670', '360428199901010102', 35, 1, 680, 0);
INSERT INTO `ticket` VALUES ('13225079670', 2, '731-01234567-003', 'MF2332', '2019-01-23', 'B', '乘客01', '13225079670', '360428199901010103', 40, 1, 820, 1);
INSERT INTO `ticket` VALUES ('13225079670', 3, '731-01234567-004', 'MF3456', '2019-01-23', 'C', '乘客04', '13225079670', '360428199901010104', 40, 1, 950, 0);
INSERT INTO `ticket` VALUES ('13225079670', 3, '731-01234567-005', 'MF3461', '2019-01-22', 'C', '乘客05', '13225079670', '360428199901010105', 25, 1, 1050, 1);
INSERT INTO `ticket` VALUES ('13515070051', 1, '731-01234567-006', 'MF1235', '2021-09-11', 'B', '乘客07', '13515070051', '360428199901010106', 35, 0, 800, 1);
INSERT INTO `ticket` VALUES ('13515070051', 1, '731-01234567-007', 'MF2332', '2019-01-21', 'A', '乘客08', '13515070051', '360428199901010107', 40, 1, 600, 0);
INSERT INTO `ticket` VALUES ('13515070051', 2, '731-01234567-008', 'MF3461', '2019-01-22', 'C', '乘客09', '13515070051', '360428199901010108', 25, 1, 1050, 1);

SET FOREIGN_KEY_CHECKS = 1;
