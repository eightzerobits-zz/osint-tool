SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `hottub` DEFAULT CHARACTER SET utf8 ;
USE `hottub` ;

-- -----------------------------------------------------
-- Table `hottub`.`twitter_keywords`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `hottub`.`twitter_keywords` (
  `idtwitter_keywords` INT NOT NULL ,
  `twitter_keywords_keyword` VARCHAR(255) NULL ,
  PRIMARY KEY (`idtwitter_keywords`) ,
  UNIQUE INDEX `idtwitter_keywords_UNIQUE` (`idtwitter_keywords` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hottub`.`twitter_tweets`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `hottub`.`twitter_tweets` (
  `idtwitter_tweets` BIGINT UNSIGNED NOT NULL ,
  `idtwitter_users` BIGINT NULL ,
  `twitter_tweets_text` VARCHAR(255) NULL ,
  `twitter_tweets_timestamp` VARCHAR(45) NULL ,
  `twitter_tweets_coordinates` VARCHAR(255) NULL ,
  `twitter_tweets_retweeted` TINYINT(1) NULL ,
  `twitter_tweets_retweet+count` INT NULL ,
  PRIMARY KEY (`idtwitter_tweets`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hottub`.`twitter_users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `hottub`.`twitter_users` (
  `idtwitter_users` BIGINT UNSIGNED NOT NULL ,
  `twitter_users_name` VARCHAR(45) NULL ,
  `twitter_users_image` BLOB NULL ,
  `twitter_users_location` VARCHAR(255) NULL ,
  `twitter_users_created` DATETIME NULL ,
  `twitter_users_url` VARCHAR(255) NULL ,
  `twitter_users_followers_count` INT NULL ,
  `twitter_users_description` TEXT NULL ,
  `twitter_users_verified` TINYINT(1) NULL ,
  `twitter_users_screen_name` VARCHAR(45) NULL ,
  PRIMARY KEY (`idtwitter_users`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hottub`.`twitter_hashtags`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `hottub`.`twitter_hashtags` (
  `idtwitter_hashtags` INT NOT NULL ,
  `twitter_hashtags_hashtag` VARCHAR(255) NULL ,
  PRIMARY KEY (`idtwitter_hashtags`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hottub`.`twitter_urls`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `hottub`.`twitter_urls` (
  `idtwitter_urls` INT NOT NULL ,
  `twitter_urls_expanded_url` TEXT NULL ,
  PRIMARY KEY (`idtwitter_urls`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hottub`.`twitter_users_to_twitter_tweets`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `hottub`.`twitter_users_to_twitter_tweets` (
  `twitter_users_idtwitter_users` BIGINT UNSIGNED NOT NULL ,
  `twitter_tweets_idtwitter_tweets` BIGINT UNSIGNED NOT NULL ,
  PRIMARY KEY (`twitter_users_idtwitter_users`, `twitter_tweets_idtwitter_tweets`) ,
  INDEX `fk_twitter_users_has_twitter_tweets_twitter_tweets1_idx` (`twitter_tweets_idtwitter_tweets` ASC) ,
  INDEX `fk_twitter_users_has_twitter_tweets_twitter_users1_idx` (`twitter_users_idtwitter_users` ASC) ,
  CONSTRAINT `fk_twitter_users_has_twitter_tweets_twitter_users1`
    FOREIGN KEY (`twitter_users_idtwitter_users` )
    REFERENCES `hottub`.`twitter_users` (`idtwitter_users` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_twitter_users_has_twitter_tweets_twitter_tweets1`
    FOREIGN KEY (`twitter_tweets_idtwitter_tweets` )
    REFERENCES `hottub`.`twitter_tweets` (`idtwitter_tweets` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hottub`.`twitter_users_twitter_mentions`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `hottub`.`twitter_users_twitter_mentions` (
  `twitter_users_idtwitter_users` BIGINT UNSIGNED NOT NULL ,
  `twitter_tweets_idtwitter_tweets` BIGINT UNSIGNED NOT NULL ,
  PRIMARY KEY (`twitter_users_idtwitter_users`, `twitter_tweets_idtwitter_tweets`) ,
  INDEX `fk_twitter_users_has_twitter_tweets1_twitter_tweets1_idx` (`twitter_tweets_idtwitter_tweets` ASC) ,
  INDEX `fk_twitter_users_has_twitter_tweets1_twitter_users1_idx` (`twitter_users_idtwitter_users` ASC) ,
  CONSTRAINT `fk_twitter_users_has_twitter_tweets1_twitter_users1`
    FOREIGN KEY (`twitter_users_idtwitter_users` )
    REFERENCES `hottub`.`twitter_users` (`idtwitter_users` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_twitter_users_has_twitter_tweets1_twitter_tweets1`
    FOREIGN KEY (`twitter_tweets_idtwitter_tweets` )
    REFERENCES `hottub`.`twitter_tweets` (`idtwitter_tweets` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hottub`.`twitter_urls_to_twitter_tweets`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `hottub`.`twitter_urls_to_twitter_tweets` (
  `twitter_urls_idtwitter_urls` INT NOT NULL ,
  `twitter_tweets_idtwitter_tweets` BIGINT UNSIGNED NOT NULL ,
  PRIMARY KEY (`twitter_urls_idtwitter_urls`, `twitter_tweets_idtwitter_tweets`) ,
  INDEX `fk_twitter_urls_has_twitter_tweets_twitter_tweets1_idx` (`twitter_tweets_idtwitter_tweets` ASC) ,
  INDEX `fk_twitter_urls_has_twitter_tweets_twitter_urls1_idx` (`twitter_urls_idtwitter_urls` ASC) ,
  CONSTRAINT `fk_twitter_urls_has_twitter_tweets_twitter_urls1`
    FOREIGN KEY (`twitter_urls_idtwitter_urls` )
    REFERENCES `hottub`.`twitter_urls` (`idtwitter_urls` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_twitter_urls_has_twitter_tweets_twitter_tweets1`
    FOREIGN KEY (`twitter_tweets_idtwitter_tweets` )
    REFERENCES `hottub`.`twitter_tweets` (`idtwitter_tweets` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hottub`.`twitter_hashtags_to_twitter_tweets`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `hottub`.`twitter_hashtags_to_twitter_tweets` (
  `twitter_hashtags_idtwitter_hashtags` INT NOT NULL ,
  `twitter_tweets_idtwitter_tweets` BIGINT UNSIGNED NOT NULL ,
  PRIMARY KEY (`twitter_hashtags_idtwitter_hashtags`, `twitter_tweets_idtwitter_tweets`) ,
  INDEX `fk_twitter_hashtags_has_twitter_tweets_twitter_tweets1_idx` (`twitter_tweets_idtwitter_tweets` ASC) ,
  INDEX `fk_twitter_hashtags_has_twitter_tweets_twitter_hashtags1_idx` (`twitter_hashtags_idtwitter_hashtags` ASC) ,
  CONSTRAINT `fk_twitter_hashtags_has_twitter_tweets_twitter_hashtags1`
    FOREIGN KEY (`twitter_hashtags_idtwitter_hashtags` )
    REFERENCES `hottub`.`twitter_hashtags` (`idtwitter_hashtags` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_twitter_hashtags_has_twitter_tweets_twitter_tweets1`
    FOREIGN KEY (`twitter_tweets_idtwitter_tweets` )
    REFERENCES `hottub`.`twitter_tweets` (`idtwitter_tweets` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hottub`.`twitter_keywords_to_twitter_tweets`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `hottub`.`twitter_keywords_to_twitter_tweets` (
  `twitter_keywords_idtwitter_keywords` INT NOT NULL ,
  `twitter_tweets_idtwitter_tweets` BIGINT UNSIGNED NOT NULL ,
  PRIMARY KEY (`twitter_keywords_idtwitter_keywords`, `twitter_tweets_idtwitter_tweets`) ,
  INDEX `fk_twitter_keywords_has_twitter_tweets_twitter_tweets1_idx` (`twitter_tweets_idtwitter_tweets` ASC) ,
  INDEX `fk_twitter_keywords_has_twitter_tweets_twitter_keywords1_idx` (`twitter_keywords_idtwitter_keywords` ASC) ,
  CONSTRAINT `fk_twitter_keywords_has_twitter_tweets_twitter_keywords1`
    FOREIGN KEY (`twitter_keywords_idtwitter_keywords` )
    REFERENCES `hottub`.`twitter_keywords` (`idtwitter_keywords` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_twitter_keywords_has_twitter_tweets_twitter_tweets1`
    FOREIGN KEY (`twitter_tweets_idtwitter_tweets` )
    REFERENCES `hottub`.`twitter_tweets` (`idtwitter_tweets` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `hottub` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
