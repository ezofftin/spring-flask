-- MySQL dump 10.13  Distrib 8.0.11, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sample
-- ------------------------------------------------------
-- Server version	8.0.11

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `member` (
  `uno` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(20) NOT NULL,
  `pw` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `age` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `tel` varchar(20) NOT NULL,
  PRIMARY KEY (`uno`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'user1','pass123','홍길동',30,'user1@example.com','010-1234-5678'),(2,'user2','pass456','김철수',25,'user2@example.com','010-5678-1234');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_board`
--

DROP TABLE IF EXISTS `tbl_board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tbl_board` (
  `bid` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(100) NOT NULL,
  `contents` varchar(3000) NOT NULL,
  `hit` int(11) DEFAULT '0',
  `writer` varchar(20) NOT NULL,
  `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` datetime DEFAULT NULL,
  `likes` int(11) DEFAULT '0',
  `replyCnt` int(11) DEFAULT '0',
  PRIMARY KEY (`bid`),
  KEY `fk_board_writer` (`writer`),
  CONSTRAINT `fk_board_writer` FOREIGN KEY (`writer`) REFERENCES `member` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_board`
--

LOCK TABLES `tbl_board` WRITE;
/*!40000 ALTER TABLE `tbl_board` DISABLE KEYS */;
INSERT INTO `tbl_board` VALUES (1,'첫 번째 게시글','이것은 첫 번째 글입니다.',21,'user1','2025-02-11 12:07:04',NULL,0,2),(2,'두 번째 게시글','이것은 두 번째 글입니다.',5,'user1','2025-02-11 12:07:04',NULL,0,1),(3,'세 번째 게시글','이것은 세 번째 글입니다.',3,'user2','2025-02-11 12:07:04',NULL,0,0),(4,'안녕하세요~~','하이',6,'user2','2025-02-11 12:43:32',NULL,0,0);
/*!40000 ALTER TABLE `tbl_board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_reply`
--

DROP TABLE IF EXISTS `tbl_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tbl_reply` (
  `rno` int(11) NOT NULL AUTO_INCREMENT,
  `bid` int(11) DEFAULT NULL,
  `r_contents` varchar(2000) NOT NULL,
  `replyer` varchar(20) NOT NULL,
  `r_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rno`),
  KEY `fk_reply_board` (`bid`),
  KEY `fk_reply_writer` (`replyer`),
  CONSTRAINT `fk_reply_board` FOREIGN KEY (`bid`) REFERENCES `tbl_board` (`bid`) ON DELETE CASCADE,
  CONSTRAINT `fk_reply_writer` FOREIGN KEY (`replyer`) REFERENCES `member` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_reply`
--

LOCK TABLES `tbl_reply` WRITE;
/*!40000 ALTER TABLE `tbl_reply` DISABLE KEYS */;
INSERT INTO `tbl_reply` VALUES (1,1,'첫 번째 게시글의 첫 번째 댓글','user2','2025-02-11 12:07:26','2025-02-11 12:07:26'),(2,1,'첫 번째 게시글의 두 번째 댓글','user1','2025-02-11 12:07:26','2025-02-11 12:07:26'),(3,2,'두 번째 게시글의 첫 번째 댓글','user1','2025-02-11 12:07:26','2025-02-11 12:07:26');
/*!40000 ALTER TABLE `tbl_reply` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-25 15:36:36
