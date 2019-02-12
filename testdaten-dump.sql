-- MySQL dump 10.16  Distrib 10.1.38-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 159.69.220.111    Database: openFruit
-- ------------------------------------------------------
-- Server version	10.1.37-MariaDB-0+deb9u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `offer`
--

DROP TABLE IF EXISTS `offer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer` (
  `idoffer` int(11) NOT NULL AUTO_INCREMENT,
  `amount` int(11) NOT NULL,
  `product` varchar(255) NOT NULL,
  `date_time_of_entry` datetime NOT NULL,
  `unit` varchar(32) NOT NULL,
  `deviceID` varchar(64) NOT NULL,
  PRIMARY KEY (`idoffer`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer`
--

LOCK TABLES `offer` WRITE;
/*!40000 ALTER TABLE `offer` DISABLE KEYS */;
INSERT INTO `offer` VALUES (1,15,'Äpfel','2019-02-06 15:44:34','Stück','ajsgdasjgbaorisl'),(2,10,'Bananen','2019-02-06 15:49:00','Stück','0001000'),(5,5,'Erdbeerenmarmelade','2019-02-06 16:56:59','L','samhuhel'),(6,15,'Äpfel','2019-02-08 10:00:55','Stück','000100'),(7,4,'Birnen','2019-02-08 10:00:56','kg','000100'),(8,30,'Karotten','2019-02-08 10:00:56','dag','000100'),(9,80,'Kartoffeln','2019-02-08 10:00:57','dag','000100'),(10,10,'Zwetschken','2019-02-08 10:01:17','Stück','000100'),(11,15,'Radieschen','2019-02-08 10:01:18','Stück','000100'),(12,7000,'Spargel','2019-02-08 10:01:19','g','000100'),(13,9,'Rhabarber','2019-02-08 10:01:19','Stück','000100'),(14,6000,'Apfelmost','2019-02-08 10:01:20','ml','000100'),(15,6,'Zwiebeln','2019-02-08 10:01:21','dag','000100');
/*!40000 ALTER TABLE `offer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_has_user`
--

DROP TABLE IF EXISTS `offer_has_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offer_has_user` (
  `offer_idoffer` int(11) NOT NULL,
  `user_iduser` int(11) NOT NULL,
  PRIMARY KEY (`offer_idoffer`,`user_iduser`),
  KEY `fk_offer_has_user_user1_idx` (`user_iduser`),
  KEY `fk_offer_has_user_offer_idx` (`offer_idoffer`),
  CONSTRAINT `fk_offer_has_user_offer` FOREIGN KEY (`offer_idoffer`) REFERENCES `offer` (`idoffer`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_offer_has_user_user1` FOREIGN KEY (`user_iduser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_has_user`
--

LOCK TABLES `offer_has_user` WRITE;
/*!40000 ALTER TABLE `offer_has_user` DISABLE KEYS */;
INSERT INTO `offer_has_user` VALUES (1,1),(2,2),(5,6),(6,7),(7,8),(8,9),(9,10),(10,11),(11,12);
/*!40000 ALTER TABLE `offer_has_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) NOT NULL,
  `longitude` float NOT NULL,
  `latitude` float NOT NULL,
  PRIMARY KEY (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Thomas','Kröpfl',9.76019,47.4043),(2,'David','Kuntner',9.72578,47.4073),(6,'Samuel','Haim',9.73968,47.435),(7,'Bernd','Kloser',9.72186,47.4401),(8,'Lukas','Mayer',9.78236,47.4253),(9,'Julia','Winkler',9.77669,47.384),(10,'Anna','Weber',9.69093,47.3948),(11,'Maximilian','Müller',9.67831,47.4103),(12,'Leonie','Huber',9.77556,47.3973),(13,'Julian','Hofer',9.77739,47.427),(14,'Laura','Schmid',9.76834,47.4052),(15,'Sarah','Leitner',9.79021,47.4144);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'openFruit'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-12 12:53:34
