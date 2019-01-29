-- MySQL Script generated by MySQL Workbench
-- Tue Jan 29 10:35:46 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema opneFruit
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `opneFruit` ;

-- -----------------------------------------------------
-- Schema opneFruit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `opneFruit` DEFAULT CHARACTER SET utf8 ;
USE `opneFruit` ;

-- -----------------------------------------------------
-- Table `opneFruit`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opneFruit`.`user` ;

CREATE TABLE IF NOT EXISTS `opneFruit`.`user` (
  `iduser` INT NOT NULL,
  `firstname` VARCHAR(255) NULL,
  `lastname` VARCHAR(255) NOT NULL,
  `longitude` VARCHAR(255) NOT NULL,
  `latitude` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`iduser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opneFruit`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opneFruit`.`products` ;

CREATE TABLE IF NOT EXISTS `opneFruit`.`products` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opneFruit`.`offer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opneFruit`.`offer` ;

CREATE TABLE IF NOT EXISTS `opneFruit`.`offer` (
  `idoffer` INT NOT NULL,
  `weight` DECIMAL NULL,
  `amount` INT NOT NULL,
  `price` DECIMAL NOT NULL,
  `product` VARCHAR(255) NULL,
  PRIMARY KEY (`idoffer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opneFruit`.`user_has_offer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opneFruit`.`user_has_offer` ;

CREATE TABLE IF NOT EXISTS `opneFruit`.`user_has_offer` (
  `user_iduser` INT NOT NULL,
  `offerings_idofferings` INT NOT NULL,
  PRIMARY KEY (`user_iduser`, `offerings_idofferings`),
  INDEX `fk_user_has_offerings_offerings1_idx` (`offerings_idofferings` ASC) VISIBLE,
  INDEX `fk_user_has_offerings_user_idx` (`user_iduser` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_offerings_user`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `opneFruit`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_offerings_offerings1`
    FOREIGN KEY (`offerings_idofferings`)
    REFERENCES `opneFruit`.`offer` (`idoffer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
