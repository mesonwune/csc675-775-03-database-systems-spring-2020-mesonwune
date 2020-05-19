CREATE DATABASE  IF NOT EXISTS `LibrarySystemFinal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `LibrarySystemFinal`;
-- MySQL dump 10.13  Distrib 8.0.19, for macos10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: LibrarySystemFinal
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Account`
--

DROP TABLE IF EXISTS `Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Account` (
  `accountID` int NOT NULL AUTO_INCREMENT,
  `fk_userID` int NOT NULL,
  `fk_regionID` int NOT NULL,
  PRIMARY KEY (`accountID`,`fk_userID`),
  KEY `fk_Account_User_idx` (`fk_userID`),
  KEY `fk_Account_Region1_idx` (`fk_regionID`),
  CONSTRAINT `fk_Account_Region1` FOREIGN KEY (`fk_regionID`) REFERENCES `Region` (`regionID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Account_User` FOREIGN KEY (`fk_userID`) REFERENCES `User` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Adult`
--

DROP TABLE IF EXISTS `Adult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Adult` (
  `adultID` int NOT NULL AUTO_INCREMENT,
  `fk_accID` int NOT NULL,
  PRIMARY KEY (`adultID`,`fk_accID`),
  KEY `fk_accountID_idx` (`fk_accID`),
  CONSTRAINT `fk_accountID` FOREIGN KEY (`fk_accID`) REFERENCES `Account` (`accountID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Author`
--

DROP TABLE IF EXISTS `Author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Author` (
  `authorID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `Media_mediaID` int NOT NULL,
  PRIMARY KEY (`authorID`),
  KEY `fk_Author_Media1_idx` (`Media_mediaID`),
  CONSTRAINT `fk_Author_Media1` FOREIGN KEY (`Media_mediaID`) REFERENCES `Media` (`mediaID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Book`
--

DROP TABLE IF EXISTS `Book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Book` (
  `bookID` int NOT NULL AUTO_INCREMENT,
  `Media_mediaID` int NOT NULL,
  PRIMARY KEY (`bookID`,`Media_mediaID`),
  KEY `fk_Book_Media1_idx` (`Media_mediaID`),
  CONSTRAINT `fk_Book_Media1` FOREIGN KEY (`Media_mediaID`) REFERENCES `Media` (`mediaID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CD`
--

DROP TABLE IF EXISTS `CD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CD` (
  `cd_ID` int NOT NULL AUTO_INCREMENT,
  `Media_mediaID` int NOT NULL,
  PRIMARY KEY (`cd_ID`,`Media_mediaID`),
  KEY `fk_CD_Media1_idx` (`Media_mediaID`),
  CONSTRAINT `fk_CD_Media1` FOREIGN KEY (`Media_mediaID`) REFERENCES `Media` (`mediaID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Child`
--

DROP TABLE IF EXISTS `Child`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Child` (
  `childID` int NOT NULL AUTO_INCREMENT,
  `fk_accID` int NOT NULL,
  PRIMARY KEY (`childID`,`fk_accID`),
  KEY `fk_accountID_idx` (`fk_accID`),
  CONSTRAINT `fk_acctID` FOREIGN KEY (`fk_accID`) REFERENCES `Account` (`accountID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Historical_Media`
--

DROP TABLE IF EXISTS `Historical_Media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Historical_Media` (
  `historID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`historID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Librarian`
--

DROP TABLE IF EXISTS `Librarian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Librarian` (
  `libID` int NOT NULL AUTO_INCREMENT,
  `fk_userID` int NOT NULL,
  PRIMARY KEY (`libID`,`fk_userID`),
  KEY `UserId_idx` (`fk_userID`),
  CONSTRAINT `UserId` FOREIGN KEY (`fk_userID`) REFERENCES `User` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Librarian_blocks_Registered`
--

DROP TABLE IF EXISTS `Librarian_blocks_Registered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Librarian_blocks_Registered` (
  `Librarian_libID` int NOT NULL,
  `Librarian_fk_userID` int NOT NULL,
  `Registered_regID` int NOT NULL,
  `Registered_userID` int NOT NULL,
  `id_LibReg` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_LibReg`,`Librarian_libID`,`Librarian_fk_userID`,`Registered_regID`,`Registered_userID`),
  KEY `fk_Librarian_has_Registered_Registered1_idx` (`Registered_regID`,`Registered_userID`),
  KEY `fk_Librarian_has_Registered_Librarian1_idx` (`Librarian_libID`,`Librarian_fk_userID`),
  CONSTRAINT `fk_Librarian_has_Registered_Librarian1` FOREIGN KEY (`Librarian_libID`, `Librarian_fk_userID`) REFERENCES `Librarian` (`libID`, `fk_userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Librarian_has_Registered_Registered1` FOREIGN KEY (`Registered_regID`, `Registered_userID`) REFERENCES `Registered` (`regID`, `fk_userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Librarian_has_Historical_Media`
--

DROP TABLE IF EXISTS `Librarian_has_Historical_Media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Librarian_has_Historical_Media` (
  `Librarian_libID` int NOT NULL,
  `Librarian_fk_userID` int NOT NULL,
  `Historical_Media_historID` int NOT NULL,
  `id_LibHistory` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_LibHistory`,`Librarian_libID`,`Librarian_fk_userID`,`Historical_Media_historID`),
  KEY `fk_Librarian_has_Historical_Media_Historical_Media1_idx` (`Historical_Media_historID`),
  KEY `fk_Librarian_has_Historical_Media_Librarian1_idx` (`Librarian_libID`,`Librarian_fk_userID`),
  CONSTRAINT `fk_Librarian_has_Historical_Media_Historical_Media1` FOREIGN KEY (`Historical_Media_historID`) REFERENCES `Historical_Media` (`historID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Librarian_has_Historical_Media_Librarian1` FOREIGN KEY (`Librarian_libID`, `Librarian_fk_userID`) REFERENCES `Librarian` (`libID`, `fk_userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Media`
--

DROP TABLE IF EXISTS `Media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Media` (
  `mediaID` int NOT NULL AUTO_INCREMENT,
  `availability` tinyint NOT NULL,
  `Title` varchar(45) NOT NULL,
  PRIMARY KEY (`mediaID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Media_Published`
--

DROP TABLE IF EXISTS `Media_Published`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Media_Published` (
  `medPubID` int NOT NULL AUTO_INCREMENT,
  `Book_bookID` int DEFAULT NULL,
  `Newspaper_newsID` int DEFAULT NULL,
  `fk_pubID` int NOT NULL,
  PRIMARY KEY (`medPubID`,`fk_pubID`),
  KEY `fk_Media_Published_Book1_idx` (`Book_bookID`),
  KEY `fk_Media_Published_Newspaper1_idx` (`Newspaper_newsID`),
  KEY `fk_Media_Published_Publisher1_idx` (`fk_pubID`),
  CONSTRAINT `fk_Media_Published_Book1` FOREIGN KEY (`Book_bookID`) REFERENCES `Book` (`bookID`),
  CONSTRAINT `fk_Media_Published_Newspaper1` FOREIGN KEY (`Newspaper_newsID`) REFERENCES `Newspaper` (`newsID`),
  CONSTRAINT `fk_Media_Published_Publisher1` FOREIGN KEY (`fk_pubID`) REFERENCES `Publisher` (`pubID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Movie`
--

DROP TABLE IF EXISTS `Movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Movie` (
  `movieID` int NOT NULL AUTO_INCREMENT,
  `Media_mediaID` int NOT NULL,
  PRIMARY KEY (`movieID`,`Media_mediaID`),
  KEY `fk_Movie_Media1_idx` (`Media_mediaID`),
  CONSTRAINT `fk_Movie_Media1` FOREIGN KEY (`Media_mediaID`) REFERENCES `Media` (`mediaID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Newspaper`
--

DROP TABLE IF EXISTS `Newspaper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Newspaper` (
  `newsID` int NOT NULL AUTO_INCREMENT,
  `Media_mediaID` int NOT NULL,
  PRIMARY KEY (`newsID`,`Media_mediaID`),
  KEY `fk_Newspaper_Media1_idx` (`Media_mediaID`),
  CONSTRAINT `fk_Newspaper_Media1` FOREIGN KEY (`Media_mediaID`) REFERENCES `Media` (`mediaID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Publisher`
--

DROP TABLE IF EXISTS `Publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Publisher` (
  `pubID` int NOT NULL AUTO_INCREMENT,
  `street` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  `pubName` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`pubID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Region`
--

DROP TABLE IF EXISTS `Region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Region` (
  `regionID` int NOT NULL AUTO_INCREMENT,
  `region_Name` varchar(45) NOT NULL,
  PRIMARY KEY (`regionID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Registered`
--

DROP TABLE IF EXISTS `Registered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Registered` (
  `regID` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `fees_due` double DEFAULT NULL,
  `fk_userID` int NOT NULL,
  `pswd` varchar(45) NOT NULL,
  PRIMARY KEY (`regID`,`fk_userID`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_userID_idx` (`fk_userID`),
  CONSTRAINT `fk_userID` FOREIGN KEY (`fk_userID`) REFERENCES `User` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Registered_has_Media`
--

DROP TABLE IF EXISTS `Registered_has_Media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Registered_has_Media` (
  `Registered_regID` int NOT NULL,
  `Registered_fk_userID` int NOT NULL,
  `Media_mediaID` int NOT NULL,
  `id_RegMedia` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_RegMedia`,`Registered_regID`,`Registered_fk_userID`,`Media_mediaID`),
  KEY `fk_Registered_has_Media_Media1_idx` (`Media_mediaID`),
  KEY `fk_Registered_has_Media_Registered1_idx` (`Registered_regID`,`Registered_fk_userID`),
  CONSTRAINT `fk_Registered_has_Media_Media1` FOREIGN KEY (`Media_mediaID`) REFERENCES `Media` (`mediaID`),
  CONSTRAINT `fk_Registered_has_Media_Registered1` FOREIGN KEY (`Registered_regID`, `Registered_fk_userID`) REFERENCES `Registered` (`regID`, `fk_userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Superviors`
--

DROP TABLE IF EXISTS `Superviors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Superviors` (
  `supervisorID` int NOT NULL AUTO_INCREMENT,
  `fk_libID` int NOT NULL,
  PRIMARY KEY (`supervisorID`,`fk_libID`),
  KEY `fk_libID_idx` (`fk_libID`),
  CONSTRAINT `fk_libID` FOREIGN KEY (`fk_libID`) REFERENCES `Librarian` (`libID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `DOB` varchar(10) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'LibrarySystemFinal'
--

--
-- Dumping routines for database 'LibrarySystemFinal'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-16 22:02:19
