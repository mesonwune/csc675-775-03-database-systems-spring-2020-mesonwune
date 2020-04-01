-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LibrarySystem
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LibrarySystem
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LibrarySystem` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `LibrarySystem` ;

-- -----------------------------------------------------
-- Table `LibrarySystem`.`Region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Region` (
  `regionID` INT NOT NULL,
  `region_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`regionID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`User` (
  `userID` INT NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `DOB` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`userID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Account` (
  `accountID` INT NOT NULL,
  `fk_userID` INT NOT NULL,
  `fk_regionID` INT NOT NULL,
  PRIMARY KEY (`accountID`, `fk_userID`),
  INDEX `fk_Account_User_idx` (`fk_userID` ASC) VISIBLE,
  INDEX `fk_Account_Region1_idx` (`fk_regionID` ASC) VISIBLE,
  CONSTRAINT `fk_Account_Region1`
    FOREIGN KEY (`fk_regionID`)
    REFERENCES `LibrarySystem`.`Region` (`regionID`),
  CONSTRAINT `fk_Account_User`
    FOREIGN KEY (`fk_userID`)
    REFERENCES `LibrarySystem`.`User` (`userID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Adult`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Adult` (
  `adultID` INT NOT NULL,
  `fk_accID` INT NOT NULL,
  PRIMARY KEY (`adultID`, `fk_accID`),
  INDEX `fk_accountID_idx` (`fk_accID` ASC) VISIBLE,
  CONSTRAINT `fk_accountID`
    FOREIGN KEY (`fk_accID`)
    REFERENCES `LibrarySystem`.`Account` (`accountID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Registered`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Registered` (
  `regID` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `fees_due` DOUBLE NULL DEFAULT NULL,
  `fk_userID` INT NOT NULL,
  PRIMARY KEY (`regID`, `fk_userID`),
  INDEX `fk_userID_idx` (`fk_userID` ASC) VISIBLE,
  CONSTRAINT `fk_userID`
    FOREIGN KEY (`fk_userID`)
    REFERENCES `LibrarySystem`.`User` (`userID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Unregistered`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Unregistered` (
  `unregID` INT NOT NULL,
  `fk_userID` INT NOT NULL,
  PRIMARY KEY (`unregID`, `fk_userID`),
  INDEX `fk_userID_idx` (`fk_userID` ASC) VISIBLE,
  CONSTRAINT `fk_usrID`
    FOREIGN KEY (`fk_userID`)
    REFERENCES `LibrarySystem`.`User` (`userID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Media`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Media` (
  `mediaID` INT NOT NULL AUTO_INCREMENT,
  `availability` TINYINT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `fk_unregID` INT NULL DEFAULT NULL,
  `fk_regID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`mediaID`),
  INDEX `fk_Media_Unregistered1_idx` (`fk_unregID` ASC) VISIBLE,
  INDEX `fk_Media_Registered1_idx` (`fk_regID` ASC) VISIBLE,
  CONSTRAINT `fk_Media_Registered1`
    FOREIGN KEY (`fk_regID`)
    REFERENCES `LibrarySystem`.`Registered` (`regID`),
  CONSTRAINT `fk_Media_Unregistered1`
    FOREIGN KEY (`fk_unregID`)
    REFERENCES `LibrarySystem`.`Unregistered` (`unregID`))
ENGINE = InnoDB
AUTO_INCREMENT = 46
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Author` (
  `authorID` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NULL DEFAULT NULL,
  `lastName` VARCHAR(45) NULL DEFAULT NULL,
  `Media_mediaID` INT NOT NULL,
  PRIMARY KEY (`authorID`),
  INDEX `fk_Author_Media1_idx` (`Media_mediaID` ASC) VISIBLE,
  CONSTRAINT `fk_Author_Media1`
    FOREIGN KEY (`Media_mediaID`)
    REFERENCES `LibrarySystem`.`Media` (`mediaID`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Book` (
  `bookID` INT NOT NULL AUTO_INCREMENT,
  `Media_mediaID` INT NOT NULL,
  PRIMARY KEY (`bookID`, `Media_mediaID`),
  INDEX `Media_mediaID_idx` (`Media_mediaID` ASC) VISIBLE,
  CONSTRAINT `Media_mediaID`
    FOREIGN KEY (`Media_mediaID`)
    REFERENCES `LibrarySystem`.`Media` (`mediaID`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`CD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`CD` (
  `cd_ID` INT NOT NULL AUTO_INCREMENT,
  `Media_mediaID` INT NOT NULL,
  PRIMARY KEY (`cd_ID`, `Media_mediaID`),
  INDEX `fk_CD_Media1_idx` (`Media_mediaID` ASC) VISIBLE,
  CONSTRAINT `fk_CD_Media1`
    FOREIGN KEY (`Media_mediaID`)
    REFERENCES `LibrarySystem`.`Media` (`mediaID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Child`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Child` (
  `childID` INT NOT NULL,
  `fk_accID` INT NOT NULL,
  PRIMARY KEY (`childID`, `fk_accID`),
  INDEX `fk_accountID_idx` (`fk_accID` ASC) VISIBLE,
  CONSTRAINT `fk_acctID`
    FOREIGN KEY (`fk_accID`)
    REFERENCES `LibrarySystem`.`Account` (`accountID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Historical_Media`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Historical_Media` (
  `historID` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`historID`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Librarian`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Librarian` (
  `libID` INT NOT NULL,
  `fk_userID` INT NOT NULL,
  PRIMARY KEY (`libID`, `fk_userID`),
  INDEX `UserId_idx` (`fk_userID` ASC) VISIBLE,
  CONSTRAINT `UserId`
    FOREIGN KEY (`fk_userID`)
    REFERENCES `LibrarySystem`.`User` (`userID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Librarian_blocks_Registered`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Librarian_blocks_Registered` (
  `Librarian_libID` INT NOT NULL,
  `Librarian_fk_userID` INT NOT NULL,
  `Registered_regID` INT NOT NULL,
  `Registered_userID` INT NOT NULL,
  PRIMARY KEY (`Librarian_libID`, `Librarian_fk_userID`, `Registered_regID`, `Registered_userID`),
  INDEX `fk_Librarian_has_Registered_Registered1_idx` (`Registered_regID` ASC, `Registered_userID` ASC) VISIBLE,
  INDEX `fk_Librarian_has_Registered_Librarian1_idx` (`Librarian_libID` ASC, `Librarian_fk_userID` ASC) VISIBLE,
  CONSTRAINT `fk_Librarian_has_Registered_Librarian1`
    FOREIGN KEY (`Librarian_libID` , `Librarian_fk_userID`)
    REFERENCES `LibrarySystem`.`Librarian` (`libID` , `fk_userID`),
  CONSTRAINT `fk_Librarian_has_Registered_Registered1`
    FOREIGN KEY (`Registered_regID` , `Registered_userID`)
    REFERENCES `LibrarySystem`.`Registered` (`regID` , `fk_userID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Librarian_has_Historical_Media`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Librarian_has_Historical_Media` (
  `Librarian_libID` INT NOT NULL,
  `Librarian_fk_userID` INT NOT NULL,
  `Historical_Media_historID` INT NOT NULL,
  PRIMARY KEY (`Librarian_libID`, `Librarian_fk_userID`, `Historical_Media_historID`),
  INDEX `fk_Librarian_has_Historical_Media_Historical_Media1_idx` (`Historical_Media_historID` ASC) VISIBLE,
  INDEX `fk_Librarian_has_Historical_Media_Librarian1_idx` (`Librarian_libID` ASC, `Librarian_fk_userID` ASC) VISIBLE,
  CONSTRAINT `fk_Librarian_has_Historical_Media_Historical_Media1`
    FOREIGN KEY (`Historical_Media_historID`)
    REFERENCES `LibrarySystem`.`Historical_Media` (`historID`),
  CONSTRAINT `fk_Librarian_has_Historical_Media_Librarian1`
    FOREIGN KEY (`Librarian_libID` , `Librarian_fk_userID`)
    REFERENCES `LibrarySystem`.`Librarian` (`libID` , `fk_userID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Publisher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Publisher` (
  `pubID` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pubID`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Newspaper`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Newspaper` (
  `newsID` INT NOT NULL AUTO_INCREMENT,
  `Media_mediaID` INT NOT NULL,
  PRIMARY KEY (`newsID`, `Media_mediaID`),
  INDEX `fk_Newspaper_Media1_idx` (`Media_mediaID` ASC) VISIBLE,
  CONSTRAINT `fk_Newspaper_Media1`
    FOREIGN KEY (`Media_mediaID`)
    REFERENCES `LibrarySystem`.`Media` (`mediaID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Media_Published`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Media_Published` (
  `medPubID` INT NOT NULL AUTO_INCREMENT,
  `Book_bookID` INT NULL DEFAULT NULL,
  `Newspaper_newsID` INT NULL DEFAULT NULL,
  `fk_pubID` INT NOT NULL,
  PRIMARY KEY (`medPubID`, `fk_pubID`),
  INDEX `Book_bookID_idx` (`Book_bookID` ASC) VISIBLE,
  INDEX `Newspaper_newsID_idx` (`Newspaper_newsID` ASC) VISIBLE,
  INDEX `fk_Media_Published_Publisher1_idx` (`fk_pubID` ASC) VISIBLE,
  CONSTRAINT `Book_bookID`
    FOREIGN KEY (`Book_bookID`)
    REFERENCES `LibrarySystem`.`Book` (`bookID`),
  CONSTRAINT `fk_Media_Published_Publisher1`
    FOREIGN KEY (`fk_pubID`)
    REFERENCES `LibrarySystem`.`Publisher` (`pubID`),
  CONSTRAINT `Newspaper_newsID`
    FOREIGN KEY (`Newspaper_newsID`)
    REFERENCES `LibrarySystem`.`Newspaper` (`newsID`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Movie` (
  `movieID` INT NOT NULL AUTO_INCREMENT,
  `Media_mediaID` INT NOT NULL,
  PRIMARY KEY (`movieID`, `Media_mediaID`),
  INDEX `fk_Movie_Media1_idx` (`Media_mediaID` ASC) VISIBLE,
  CONSTRAINT `fk_Movie_Media1`
    FOREIGN KEY (`Media_mediaID`)
    REFERENCES `LibrarySystem`.`Media` (`mediaID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LibrarySystem`.`Superviors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LibrarySystem`.`Superviors` (
  `supervisorID` INT NOT NULL,
  `fk_libID` INT NOT NULL,
  PRIMARY KEY (`supervisorID`, `fk_libID`),
  INDEX `fk_libID_idx` (`fk_libID` ASC) VISIBLE,
  CONSTRAINT `fk_libID`
    FOREIGN KEY (`fk_libID`)
    REFERENCES `LibrarySystem`.`Librarian` (`libID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
