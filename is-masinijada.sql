-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema masinijada
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema masinijada
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `masinijada` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `masinijada` ;

-- -----------------------------------------------------
-- Table `masinijada`.`mesto_odrzavanja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`mesto_odrzavanja` (
  `id_mesta` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_mesta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`disciplina` (
  `id_discipline` INT NOT NULL AUTO_INCREMENT,
  `id_mesta` INT NULL DEFAULT NULL,
  `naziv` VARCHAR(45) NULL DEFAULT NULL,
  `prosecno_trajanje` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_discipline`),
  INDEX `id_mesta_idx` (`id_mesta` ASC) VISIBLE,
  CONSTRAINT `strani1`
    FOREIGN KEY (`id_mesta`)
    REFERENCES `masinijada`.`mesto_odrzavanja` (`id_mesta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`grad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`grad` (
  `ptt` INT NOT NULL,
  `naziv` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ptt`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = big5;


-- -----------------------------------------------------
-- Table `masinijada`.`masinijada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`masinijada` (
  `id_masinijade` INT NOT NULL AUTO_INCREMENT,
  `godina_odrzavanja` INT NULL DEFAULT NULL,
  `broj_ucesnika` INT NULL DEFAULT NULL,
  `ptt` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_masinijade`),
  INDEX `ptt_idx` (`ptt` ASC) VISIBLE,
  CONSTRAINT `ptt`
    FOREIGN KEY (`ptt`)
    REFERENCES `masinijada`.`grad` (`ptt`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`nagrada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`nagrada` (
  `id_nagrade` INT NOT NULL AUTO_INCREMENT,
  `id_masinijade` INT NOT NULL,
  `mesto` INT NULL DEFAULT NULL,
  `disciplina` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_nagrade`),
  INDEX `id_masinijade_idx` (`id_masinijade` ASC) VISIBLE,
  CONSTRAINT `strani8`
    FOREIGN KEY (`id_masinijade`)
    REFERENCES `masinijada`.`masinijada` (`id_masinijade`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`fakultet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`fakultet` (
  `id_fakulteta` INT NOT NULL AUTO_INCREMENT,
  `drzava` VARCHAR(45) NULL DEFAULT NULL,
  `naziv` VARCHAR(45) NULL DEFAULT NULL,
  `broj_studenata` INT NULL DEFAULT NULL,
  `broj_pojavljivanja` INT NULL DEFAULT NULL,
  `ptt` INT NOT NULL,
  PRIMARY KEY (`id_fakulteta`),
  INDEX `ptt_idx` (`ptt` ASC) VISIBLE,
  CONSTRAINT `strani4`
    FOREIGN KEY (`ptt`)
    REFERENCES `masinijada`.`grad` (`ptt`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`dobija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`dobija` (
  `id_nagrade` INT NOT NULL,
  `id_fakulteta` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_nagrade`),
  INDEX `id_fakulteta_idx` (`id_fakulteta` ASC) VISIBLE,
  CONSTRAINT `strani2`
    FOREIGN KEY (`id_nagrade`)
    REFERENCES `masinijada`.`nagrada` (`id_nagrade`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `strani3`
    FOREIGN KEY (`id_fakulteta`)
    REFERENCES `masinijada`.`fakultet` (`id_fakulteta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`gledalac`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`gledalac` (
  `JMBG` VARCHAR(45) NOT NULL,
  `ime` VARCHAR(45) NULL DEFAULT NULL,
  `prezime` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`JMBG`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`karta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`karta` (
  `redni_broj` INT NOT NULL AUTO_INCREMENT,
  `broj_dana` INT NOT NULL,
  PRIMARY KEY (`redni_broj`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`kupuje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`kupuje` (
  `redni_broj` INT NOT NULL,
  `JMBG` VARCHAR(45) NOT NULL,
  `popust` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`redni_broj`),
  INDEX `JMBG_idx` (`JMBG` ASC) VISIBLE,
  CONSTRAINT `strani5`
    FOREIGN KEY (`redni_broj`)
    REFERENCES `masinijada`.`karta` (`redni_broj`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `strani6`
    FOREIGN KEY (`JMBG`)
    REFERENCES `masinijada`.`gledalac` (`JMBG`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`ucesnik_masinijade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`ucesnik_masinijade` (
  `id_ucesnika` INT NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(45) NULL DEFAULT NULL,
  `prezime` VARCHAR(45) NULL DEFAULT NULL,
  `ptt` INT NOT NULL,
  PRIMARY KEY (`id_ucesnika`),
  INDEX `ptt_idx` (`ptt` ASC) VISIBLE,
  CONSTRAINT `strani23`
    FOREIGN KEY (`ptt`)
    REFERENCES `masinijada`.`grad` (`ptt`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`organizator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`organizator` (
  `id_ucesnika` INT NOT NULL,
  `radno_iskustvo` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_ucesnika`),
  CONSTRAINT `strani9`
    FOREIGN KEY (`id_ucesnika`)
    REFERENCES `masinijada`.`ucesnik_masinijade` (`id_ucesnika`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`predaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`predaje` (
  `id_ucesnika` INT NOT NULL,
  `id_fakulteta` INT NOT NULL,
  PRIMARY KEY (`id_ucesnika`, `id_fakulteta`),
  INDEX `id_fakulteta_idx` (`id_fakulteta` ASC) VISIBLE,
  CONSTRAINT `strani10`
    FOREIGN KEY (`id_ucesnika`)
    REFERENCES `masinijada`.`ucesnik_masinijade` (`id_ucesnika`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `strani11`
    FOREIGN KEY (`id_fakulteta`)
    REFERENCES `masinijada`.`fakultet` (`id_fakulteta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`sektor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`sektor` (
  `id_sektora` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_sektora`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`pripada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`pripada` (
  `id_ucesnika` INT NOT NULL,
  `id_sektora` INT NOT NULL,
  PRIMARY KEY (`id_ucesnika`, `id_sektora`),
  INDEX `id_sektora_idx` (`id_sektora` ASC) VISIBLE,
  CONSTRAINT `strani12`
    FOREIGN KEY (`id_ucesnika`)
    REFERENCES `masinijada`.`ucesnik_masinijade` (`id_ucesnika`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `strani13`
    FOREIGN KEY (`id_sektora`)
    REFERENCES `masinijada`.`sektor` (`id_sektora`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`prisustvuje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`prisustvuje` (
  `redni_broj` INT NOT NULL,
  `id_mesta` INT NOT NULL,
  PRIMARY KEY (`redni_broj`, `id_mesta`),
  INDEX `id_mesta_idx` (`id_mesta` ASC) VISIBLE,
  CONSTRAINT `strani14`
    FOREIGN KEY (`redni_broj`)
    REFERENCES `masinijada`.`kupuje` (`redni_broj`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `strani15`
    FOREIGN KEY (`id_mesta`)
    REFERENCES `masinijada`.`mesto_odrzavanja` (`id_mesta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`profesor` (
  `id_ucesnika` INT NOT NULL,
  `godine_iskustva` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_ucesnika`),
  CONSTRAINT `strani16`
    FOREIGN KEY (`id_ucesnika`)
    REFERENCES `masinijada`.`ucesnik_masinijade` (`id_ucesnika`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`sala` (
  `id_mesta` INT NOT NULL,
  `dostupna_mesta` INT NULL DEFAULT NULL,
  `snaga_ozvucenja` VARCHAR(45) NULL DEFAULT NULL,
  `dimenzije` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_mesta`),
  CONSTRAINT `strani17`
    FOREIGN KEY (`id_mesta`)
    REFERENCES `masinijada`.`mesto_odrzavanja` (`id_mesta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`se_takmici`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`se_takmici` (
  `id_ucesnika` INT NOT NULL,
  `id_discipline` INT NOT NULL,
  PRIMARY KEY (`id_ucesnika`, `id_discipline`),
  INDEX `id_discipline_idx` (`id_discipline` ASC) VISIBLE,
  CONSTRAINT `strani18`
    FOREIGN KEY (`id_ucesnika`)
    REFERENCES `masinijada`.`ucesnik_masinijade` (`id_ucesnika`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `strani19`
    FOREIGN KEY (`id_discipline`)
    REFERENCES `masinijada`.`disciplina` (`id_discipline`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`student` (
  `id_ucesnika` INT NOT NULL,
  `id_fakulteta` INT NOT NULL,
  `prosek` DECIMAL(10,0) NULL DEFAULT NULL,
  `godina` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_ucesnika`),
  INDEX `id_fakulteta_idx` (`id_fakulteta` ASC) VISIBLE,
  CONSTRAINT `strani20`
    FOREIGN KEY (`id_ucesnika`)
    REFERENCES `masinijada`.`ucesnik_masinijade` (`id_ucesnika`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `strani21`
    FOREIGN KEY (`id_fakulteta`)
    REFERENCES `masinijada`.`fakultet` (`id_fakulteta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`teren`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`teren` (
  `id_mesta` INT NOT NULL,
  `dostupna_mesta` INT NULL DEFAULT NULL,
  `dimenzije` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_mesta`),
  CONSTRAINT `strani22`
    FOREIGN KEY (`id_mesta`)
    REFERENCES `masinijada`.`mesto_odrzavanja` (`id_mesta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`ucestvuje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`ucestvuje` (
  `id_masinijade` INT NOT NULL,
  `id_ucesnika` INT NOT NULL,
  PRIMARY KEY (`id_masinijade`, `id_ucesnika`),
  INDEX `id_ucesnika_idx` (`id_ucesnika` ASC) VISIBLE,
  CONSTRAINT `strani24`
    FOREIGN KEY (`id_masinijade`)
    REFERENCES `masinijada`.`masinijada` (`id_masinijade`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `strani25`
    FOREIGN KEY (`id_ucesnika`)
    REFERENCES `masinijada`.`ucesnik_masinijade` (`id_ucesnika`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `masinijada`.`ucionica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `masinijada`.`ucionica` (
  `id_mesta` INT NOT NULL,
  `broj_klupa` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_mesta`),
  CONSTRAINT `strani26`
    FOREIGN KEY (`id_mesta`)
    REFERENCES `masinijada`.`mesto_odrzavanja` (`id_mesta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `masinijada`.`mesto_odrzavanja`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`mesto_odrzavanja` (`id_mesta`) VALUES (1);
INSERT INTO `masinijada`.`mesto_odrzavanja` (`id_mesta`) VALUES (2);
INSERT INTO `masinijada`.`mesto_odrzavanja` (`id_mesta`) VALUES (3);
INSERT INTO `masinijada`.`mesto_odrzavanja` (`id_mesta`) VALUES (4);
INSERT INTO `masinijada`.`mesto_odrzavanja` (`id_mesta`) VALUES (5);
INSERT INTO `masinijada`.`mesto_odrzavanja` (`id_mesta`) VALUES (6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`disciplina`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`disciplina` (`id_discipline`, `id_mesta`, `naziv`, `prosecno_trajanje`) VALUES (1, 3, 'Rukomet', '40min');
INSERT INTO `masinijada`.`disciplina` (`id_discipline`, `id_mesta`, `naziv`, `prosecno_trajanje`) VALUES (2, 1, 'Kosarka', '1h');
INSERT INTO `masinijada`.`disciplina` (`id_discipline`, `id_mesta`, `naziv`, `prosecno_trajanje`) VALUES (3, 1, 'Fudbal', '1h');
INSERT INTO `masinijada`.`disciplina` (`id_discipline`, `id_mesta`, `naziv`, `prosecno_trajanje`) VALUES (4, 2, 'Biohemija', '3h');

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`grad`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`grad` (`ptt`, `naziv`) VALUES (34000, 'Kragujevac');
INSERT INTO `masinijada`.`grad` (`ptt`, `naziv`) VALUES (11000, 'Beograd');
INSERT INTO `masinijada`.`grad` (`ptt`, `naziv`) VALUES (11400, 'Mladenovac');

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`masinijada`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`masinijada` (`id_masinijade`, `godina_odrzavanja`, `broj_ucesnika`, `ptt`) VALUES (1, 2019, 5000, 34000);
INSERT INTO `masinijada`.`masinijada` (`id_masinijade`, `godina_odrzavanja`, `broj_ucesnika`, `ptt`) VALUES (2, 2020, 5500, 11000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`nagrada`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`nagrada` (`id_nagrade`, `id_masinijade`, `mesto`, `disciplina`) VALUES (1, 1, 1, 'Rukomet');
INSERT INTO `masinijada`.`nagrada` (`id_nagrade`, `id_masinijade`, `mesto`, `disciplina`) VALUES (2, 1, 2, 'Rukomet');
INSERT INTO `masinijada`.`nagrada` (`id_nagrade`, `id_masinijade`, `mesto`, `disciplina`) VALUES (3, 1, 3, 'Rukomet');
INSERT INTO `masinijada`.`nagrada` (`id_nagrade`, `id_masinijade`, `mesto`, `disciplina`) VALUES (4, 2, 1, 'Kosarka');
INSERT INTO `masinijada`.`nagrada` (`id_nagrade`, `id_masinijade`, `mesto`, `disciplina`) VALUES (5, 2, 2, 'Kosarka');
INSERT INTO `masinijada`.`nagrada` (`id_nagrade`, `id_masinijade`, `mesto`, `disciplina`) VALUES (6, 2, 3, 'Kosarka');

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`fakultet`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`fakultet` (`id_fakulteta`, `drzava`, `naziv`, `broj_studenata`, `broj_pojavljivanja`, `ptt`) VALUES (1, 'Srbija', 'Fakultet inzenjerskih nauka', 1100, 12, 34000);
INSERT INTO `masinijada`.`fakultet` (`id_fakulteta`, `drzava`, `naziv`, `broj_studenata`, `broj_pojavljivanja`, `ptt`) VALUES (2, 'Srbija', 'Masinski Fakultet Beograd', 3000, 9, 11000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`dobija`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`dobija` (`id_nagrade`, `id_fakulteta`) VALUES (1, 2);
INSERT INTO `masinijada`.`dobija` (`id_nagrade`, `id_fakulteta`) VALUES (2, 1);
INSERT INTO `masinijada`.`dobija` (`id_nagrade`, `id_fakulteta`) VALUES (3, 1);
INSERT INTO `masinijada`.`dobija` (`id_nagrade`, `id_fakulteta`) VALUES (4, 2);
INSERT INTO `masinijada`.`dobija` (`id_nagrade`, `id_fakulteta`) VALUES (5, 2);
INSERT INTO `masinijada`.`dobija` (`id_nagrade`, `id_fakulteta`) VALUES (6, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`gledalac`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`gledalac` (`JMBG`, `ime`, `prezime`) VALUES ('190899', 'Mirko', 'Ivanovic');
INSERT INTO `masinijada`.`gledalac` (`JMBG`, `ime`, `prezime`) VALUES ('251000', 'Nikola', 'Urosevic');

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`karta`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`karta` (`redni_broj`, `broj_dana`) VALUES (1, 3);
INSERT INTO `masinijada`.`karta` (`redni_broj`, `broj_dana`) VALUES (2, 3);
INSERT INTO `masinijada`.`karta` (`redni_broj`, `broj_dana`) VALUES (3, 1);
INSERT INTO `masinijada`.`karta` (`redni_broj`, `broj_dana`) VALUES (4, 2);
INSERT INTO `masinijada`.`karta` (`redni_broj`, `broj_dana`) VALUES (5, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`kupuje`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`kupuje` (`redni_broj`, `JMBG`, `popust`) VALUES (1, '190899', NULL);
INSERT INTO `masinijada`.`kupuje` (`redni_broj`, `JMBG`, `popust`) VALUES (2, '251000', '15%');

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`ucesnik_masinijade`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`ucesnik_masinijade` (`id_ucesnika`, `ime`, `prezime`, `ptt`) VALUES (1, 'Petar', 'Petrovic', 34000);
INSERT INTO `masinijada`.`ucesnik_masinijade` (`id_ucesnika`, `ime`, `prezime`, `ptt`) VALUES (2, 'Milan', 'Milanovic', 11000);
INSERT INTO `masinijada`.`ucesnik_masinijade` (`id_ucesnika`, `ime`, `prezime`, `ptt`) VALUES (3, 'Danica', 'Miric', 11000);
INSERT INTO `masinijada`.`ucesnik_masinijade` (`id_ucesnika`, `ime`, `prezime`, `ptt`) VALUES (4, 'Natasa', 'Belojevic', 34000);
INSERT INTO `masinijada`.`ucesnik_masinijade` (`id_ucesnika`, `ime`, `prezime`, `ptt`) VALUES (5, 'Nikola', 'Mirovic', 11000);
INSERT INTO `masinijada`.`ucesnik_masinijade` (`id_ucesnika`, `ime`, `prezime`, `ptt`) VALUES (6, 'Anastasija', 'Milenkovic', 11000);
INSERT INTO `masinijada`.`ucesnik_masinijade` (`id_ucesnika`, `ime`, `prezime`, `ptt`) VALUES (7, 'Petko', 'Mihajlovic', 34000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`organizator`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`organizator` (`id_ucesnika`, `radno_iskustvo`) VALUES (6, 3);
INSERT INTO `masinijada`.`organizator` (`id_ucesnika`, `radno_iskustvo`) VALUES (7, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`predaje`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`predaje` (`id_ucesnika`, `id_fakulteta`) VALUES (4, 2);
INSERT INTO `masinijada`.`predaje` (`id_ucesnika`, `id_fakulteta`) VALUES (5, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`sektor`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`sektor` (`id_sektora`) VALUES (1);
INSERT INTO `masinijada`.`sektor` (`id_sektora`) VALUES (2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`pripada`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`pripada` (`id_ucesnika`, `id_sektora`) VALUES (6, 2);
INSERT INTO `masinijada`.`pripada` (`id_ucesnika`, `id_sektora`) VALUES (7, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`profesor`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`profesor` (`id_ucesnika`, `godine_iskustva`) VALUES (4, 15);
INSERT INTO `masinijada`.`profesor` (`id_ucesnika`, `godine_iskustva`) VALUES (5, 12);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`sala`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`sala` (`id_mesta`, `dostupna_mesta`, `snaga_ozvucenja`, `dimenzije`) VALUES (5, 250, '300W', '30x55');

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`se_takmici`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`se_takmici` (`id_ucesnika`, `id_discipline`) VALUES (1, 2);
INSERT INTO `masinijada`.`se_takmici` (`id_ucesnika`, `id_discipline`) VALUES (2, 2);
INSERT INTO `masinijada`.`se_takmici` (`id_ucesnika`, `id_discipline`) VALUES (1, 1);
INSERT INTO `masinijada`.`se_takmici` (`id_ucesnika`, `id_discipline`) VALUES (3, 3);
INSERT INTO `masinijada`.`se_takmici` (`id_ucesnika`, `id_discipline`) VALUES (2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`student`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`student` (`id_ucesnika`, `id_fakulteta`, `prosek`, `godina`) VALUES (1, 1, 8.5, 3);
INSERT INTO `masinijada`.`student` (`id_ucesnika`, `id_fakulteta`, `prosek`, `godina`) VALUES (2, 1, 9, 4);
INSERT INTO `masinijada`.`student` (`id_ucesnika`, `id_fakulteta`, `prosek`, `godina`) VALUES (3, 2, 8.7, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`teren`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`teren` (`id_mesta`, `dostupna_mesta`, `dimenzije`) VALUES (1, 100, '25x50');
INSERT INTO `masinijada`.`teren` (`id_mesta`, `dostupna_mesta`, `dimenzije`) VALUES (3, 120, '30x55');

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`ucestvuje`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`ucestvuje` (`id_masinijade`, `id_ucesnika`) VALUES (1, 1);
INSERT INTO `masinijada`.`ucestvuje` (`id_masinijade`, `id_ucesnika`) VALUES (1, 2);
INSERT INTO `masinijada`.`ucestvuje` (`id_masinijade`, `id_ucesnika`) VALUES (1, 3);
INSERT INTO `masinijada`.`ucestvuje` (`id_masinijade`, `id_ucesnika`) VALUES (2, 6);
INSERT INTO `masinijada`.`ucestvuje` (`id_masinijade`, `id_ucesnika`) VALUES (2, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `masinijada`.`ucionica`
-- -----------------------------------------------------
START TRANSACTION;
USE `masinijada`;
INSERT INTO `masinijada`.`ucionica` (`id_mesta`, `broj_klupa`) VALUES (2, 30);

COMMIT;

