-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema openFruit
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema openFruit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `openFruit` DEFAULT CHARACTER SET utf8 ;
USE `openFruit` ;

-- -----------------------------------------------------
-- Table `openFruit`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `openFruit`.`user` (
  `iduser` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(255) NULL,
  `lastname` VARCHAR(255) NOT NULL,
  `longitude` FLOAT NOT NULL,
  `latitude` FLOAT NOT NULL,
  PRIMARY KEY (`iduser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `openFruit`.`offer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `openFruit`.`offer` (
  `idoffer` INT NOT NULL AUTO_INCREMENT,
  `amount` INT NOT NULL,
  `product` VARCHAR(255) NOT NULL,
  `date_time_of_entry` DATETIME NOT NULL,
  `unit` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`idoffer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `openFruit`.`offer_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `openFruit`.`offer_has_user` (
  `offer_idoffer` INT NOT NULL,
  `user_iduser` INT NOT NULL,
  PRIMARY KEY (`offer_idoffer`, `user_iduser`),
  INDEX `fk_offer_has_user_user1_idx` (`user_iduser` ASC),
  INDEX `fk_offer_has_user_offer_idx` (`offer_idoffer` ASC),
  CONSTRAINT `fk_offer_has_user_offer`
    FOREIGN KEY (`offer_idoffer`)
    REFERENCES `openFruit`.`offer` (`idoffer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_offer_has_user_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `openFruit`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
