SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema academia
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `academia` ;

-- -----------------------------------------------------
-- Schema academia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `academia` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `academia` ;

-- -----------------------------------------------------
-- Table `academia`.`pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `academia`.`pais` ;

CREATE TABLE IF NOT EXISTS `academia`.`pais` (
  `id_pais` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `academia`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `academia`.`estado` ;

CREATE TABLE IF NOT EXISTS `academia`.`estado` (
  `id_estado` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `sigla` CHAR(2) NOT NULL,
  `id_pais` INT NOT NULL,
  PRIMARY KEY (`id_estado`),
  INDEX `fk_estado_pais_idx` (`id_pais` ASC) VISIBLE,
  CONSTRAINT `fk_estado_pais`
    FOREIGN KEY (`id_pais`)
    REFERENCES `academia`.`pais` (`id_pais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `academia`.`cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `academia`.`cidade` ;

CREATE TABLE IF NOT EXISTS `academia`.`cidade` (
  `id_cidade` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_cidade`),
  INDEX `fk_cidade_estado_idx` (`id_estado` ASC) VISIBLE,
  CONSTRAINT `fk_cidade_estado`
    FOREIGN KEY (`id_estado`)
    REFERENCES `academia`.`estado` (`id_estado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `academia`.`cep`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `academia`.`cep` ;

CREATE TABLE IF NOT EXISTS `academia`.`cep` (
  `id_cep` INT NOT NULL AUTO_INCREMENT,
  `cep` CHAR(9) NOT NULL,
  `rua` VARCHAR(200) NOT NULL,
  `id_cidade` INT NOT NULL,
  PRIMARY KEY (`id_cep`),
  INDEX `fk_cep_cidade_idx` (`id_cidade` ASC) VISIBLE,
  CONSTRAINT `fk_cep_cidade`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `academia`.`cidade` (`id_cidade`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `academia`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `academia`.`cliente` ;

CREATE TABLE IF NOT EXISTS `academia`.`cliente` (
  `id_cliente` INT NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  `documento` VARCHAR(50) NOT NULL,
  `data_nasc` DATE NULL,
  `telefone` VARCHAR(11) NULL,
  `ativo` TINYINT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academia`.`plano`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `academia`.`plano` ;

CREATE TABLE IF NOT EXISTS `academia`.`plano` (
  `id_plano` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` TEXT NULL,
  `valor` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id_plano`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academia`.`membro_plano`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `academia`.`membro_plano` ;

CREATE TABLE IF NOT EXISTS `academia`.`membro_plano` (
  `id_cliente` INT NOT NULL,
  `id_plano` INT NOT NULL,
  `data_adesao` DATETIME NOT NULL,
  `ativo` TINYINT NULL,
  PRIMARY KEY (`id_cliente`, `id_plano`),
  INDEX `fk_membro_plano_plano1_idx` (`id_plano` ASC) VISIBLE,
  CONSTRAINT `fk_membro_plano_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `academia`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_membro_plano_plano1`
    FOREIGN KEY (`id_plano`)
    REFERENCES `academia`.`plano` (`id_plano`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `academia`.`rede`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `academia`.`rede` ;

CREATE TABLE IF NOT EXISTS `academia`.`rede` (
  `id_rede` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_rede`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `academia`.`unidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `academia`.`unidade` ;

CREATE TABLE IF NOT EXISTS `academia`.`unidade` (
  `id_unidade` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `id_rede` INT NOT NULL,
  `id_cep` INT NOT NULL,
  `numero` VARCHAR(10) NULL,
  PRIMARY KEY (`id_unidade`),
  INDEX `fk_unidade_rede_idx` (`id_rede` ASC) VISIBLE,
  INDEX `fk_unidade_cep_idx` (`id_cep` ASC) VISIBLE,
  CONSTRAINT `fk_unidade_cep`
    FOREIGN KEY (`id_cep`)
    REFERENCES `academia`.`cep` (`id_cep`),
  CONSTRAINT `fk_unidade_rede`
    FOREIGN KEY (`id_rede`)
    REFERENCES `academia`.`rede` (`id_rede`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `academia`.`rede_plano`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `academia`.`rede_plano` ;

CREATE TABLE IF NOT EXISTS `academia`.`rede_plano` (
  `rede_id_rede` INT NOT NULL,
  `plano_id_plano` INT NOT NULL,
  PRIMARY KEY (`rede_id_rede`, `plano_id_plano`),
  INDEX `fk_rede_has_plano_plano1_idx` (`plano_id_plano` ASC) VISIBLE,
  INDEX `fk_rede_has_plano_rede1_idx` (`rede_id_rede` ASC) VISIBLE,
  CONSTRAINT `fk_rede_has_plano_rede1`
    FOREIGN KEY (`rede_id_rede`)
    REFERENCES `academia`.`rede` (`id_rede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rede_has_plano_plano1`
    FOREIGN KEY (`plano_id_plano`)
    REFERENCES `academia`.`plano` (`id_plano`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO academia.pais (nome) VALUES
	 ('Brasil'),
	 ('Argentina'),
	 ('Peru'),
	 ('Equador');
INSERT INTO academia.estado (nome,sigla,id_pais) VALUES
	 ('São Paulo','SP',1),
	 ('Rio de Janeiro','RJ',1),
	 ('Buenos Aires','BA',2),
	 ('Lima','LI',3);
INSERT INTO academia.cidade (nome,id_estado) VALUES
	 ('São Paulo',1),
	 ('Campinas',1),
	 ('Santos',1),
	 ('Guarulhos',1),
	 ('São Bernardo',1),
	 ('Rio de Janeiro',2),
	 ('Niterói',2),
	 ('Petrópolis',2),
	 ('Duque de Caxias',2),
	 ('Nova Iguaçu',2),
	 ('Buenos Aires',3),
	 ('La Plata',3),
	 ('Mar del Plata',3),
	 ('Lima',4),
	 ('Cusco',4),
	 ('Jundiaí',1),
	 ('Trindade',2);
INSERT INTO academia.cep (cep,rua,id_cidade) VALUES
	 ('01000-000','Av Paulista',1),
	 ('13000-000','Rua das Flores',2),
	 ('20000-000','Rua Central',6),
	 ('19000-000','Calle Florida',11),
	 ('15000','Av Larco',14),
	 ('04546-042','R. Quatá',1),
	 ('04555-002','Av. Santo Amaro',1),
	 ('13041-670','Av. da Saudade',2),
	 ('15023','Av Javier Prado',14),
	 ('05503-970','Av Vital Brasil',1),
	 ('05401-450','Av Rebouças',1),
	 ('13211-160','R. Maestro Paulo Mario de Souza',16),
	 ('23970-000','R. Joao Possidonio',17);
INSERT INTO academia.cliente (id_cliente,nome,documento,data_nasc,telefone,ativo) VALUES
	 (1,'Maria Silva','111.111.111-11','1990-01-01','11999999999',1),
	 (2,'João Pereira','222.222.222-22','1985-05-20','21988888888',1),
	 (3,'Carlos Lima','333.333.333-33','1992-10-10','11977777777',1),
	 (4,'Ana Souza','444.444.444-44','1991-03-15','11966666666',1),
	 (5,'Lucas Gomes','555.555.555-55','1988-07-23','21955555555',0),
	 (6,'Pedro Mendes','666.666.666-66','1993-11-05','11944444444',1),
	 (7,'Laura Costa','777.777.777-77','1994-02-12','21933333333',1),
	 (8,'Ricardo Santos','888.888.888-88','1989-08-30','11922222222',1),
	 (9,'Carla Nunes','999.999.999-99','1995-04-14','21911111111',0),
	 (10,'Fernando Dias','000.000.000-00','1986-06-22','11900000000',1);
INSERT INTO academia.plano (id_plano,nome,descricao,valor) VALUES
	 (1,'Basic','Para quem quer pagar pouco',99.90),
	 (2,'Silver','Um UP no seu plano',129.90),
	 (3,'Gold','Agora voce pode treinar legal',169.90),
	 (4,'Premium','Para quem quer exclusividade',229.90),
	 (5,'Light','Sem grana, mas quero treinar',79.90);
INSERT INTO academia.membro_plano (id_cliente,id_plano,data_adesao,ativo) VALUES
	 (1,2,'2025-01-21 11:00:00',1),
	 (1,3,'2025-01-28 11:00:00',1),
	 (2,2,'2025-01-19 11:00:00',0),
	 (2,3,'2025-01-21 12:39:28',1),
	 (3,1,'2025-01-20 09:00:00',0),
	 (3,4,'2025-01-25 08:00:00',1),
	 (4,1,'2025-01-25 08:11:15',1),
	 (6,5,'2025-01-27 08:11:15',1),
	 (7,1,'2025-01-27 08:10:00',0),
	 (7,2,'2025-01-27 08:10:00',1),
	 (7,3,'2025-01-27 08:11:00',1),
	 (7,4,'2025-01-27 10:07:00',1),
	 (10,1,'2025-01-31 13:05:00',0);
INSERT INTO academia.rede (nome) VALUES
	 ('Smart Fit'),
	 ('BlueFit'),
	 ('BodyTech'),
	 ('JustFit'),
	 ('BioRitmo'),
	 ('ByNothing');
INSERT INTO academia.rede_plano (rede_id_rede,plano_id_plano) VALUES
	 (1,1),
	 (1,2),
	 (2,2),
	 (1,3),
	 (2,3),
	 (3,3),
	 (6,3),
	 (1,4),
	 (2,4),
	 (3,4),
	 (4,4),
	 (5,4),
	 (2,5);
INSERT INTO academia.unidade (nome,id_rede,id_cep,numero) VALUES
	 ('Smart Paulista',1,1,'100'),
	 ('Smart Campinas',1,2,'200'),
	 ('Smart Rio',1,3,'300'),
	 ('Smart Buenos Aires',1,4,'400'),
	 ('BlueFit Vila Olimpia',2,6,'705'),
	 ('BlueFit Campinas',2,2,'201'),
	 ('BlueFit Rio',2,3,'301'),
	 ('BlueFit Lima',2,5,'401'),
	 ('BodyTech Buenos Aires',3,4,'501'),
	 ('BodyTech Lima',3,5,'601'),
	 ('BodyTech Cusco',3,5,'701'),
	 ('BodyTech Paulista',3,1,'801'),
	 ('JustFit Campinas',4,2,'202'),
	 ('JustFit Rio',4,3,'302'),
	 ('JustFit Buenos Aires',4,4,'402'),
	 ('JustFit Lima',4,5,'502'),
	 ('BioRitmo Paulista',5,1,'103'),
	 ('BioRitmo Campinas',5,2,'203'),
	 ('BioRitmo Rio',5,3,'303'),
	 ('BioRitmo Lima',5,5,'403'),
	 ('Smart Vila Olimpia',1,6,'205'),
	 ('BlueFit Paulista',2,1,'105'),
	 ('BlueFit Campinas Av. Saudade',2,8,'201'),
	 ('ByNothing Interior 1',6,12,'300'),
	 ('ByNothing Interior 2',6,12,'400'),
	 ('ByNothing Rio',6,13,'103');
