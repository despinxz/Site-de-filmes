CREATE DATABASE  IF NOT EXISTS `bd1` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_general_cs */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bd1`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: bd1
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `edicao`
--

DROP TABLE IF EXISTS `edicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `edicao` (
  `ID_edicao` int NOT NULL,
  `Nome_evento` varchar(50) DEFAULT NULL,
  `Localizacao` varchar(50) DEFAULT NULL,
  `Data` date DEFAULT NULL,
  `Ano` int GENERATED ALWAYS AS (year(`Data`)) STORED,
  PRIMARY KEY (`ID_edicao`),
  KEY `Nome_evento` (`Nome_evento`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edicao`
--

LOCK TABLES `edicao` WRITE;
/*!40000 ALTER TABLE `edicao` DISABLE KEYS */;
INSERT INTO `edicao` (`ID_edicao`, `Nome_evento`, `Localizacao`, `Data`) VALUES (1,'Academy Awards','Los Angeles','2022-02-27'),(2,'Sundance Film Festival','Park City','2022-01-20'),(3,'Emmy Awards','Los Angeles','2022-09-19'),(4,'Berlin International Film Festival','Berlin','2022-02-10'),(5,'Golden Globe Awards','Beverly Hills','2022-01-09'),(6,'Academy Awards','Los Angeles','2021-04-25'),(7,'Sundance Film Festival','Park City','2021-01-28'),(8,'Emmy Awards','Los Angeles','2021-09-19'),(9,'Berlin International Film Festival','Berlin','2021-03-01'),(10,'Golden Globe Awards','Beverly Hills','2021-02-28');
/*!40000 ALTER TABLE `edicao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventos`
--

DROP TABLE IF EXISTS `eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventos` (
  `Nome_evento` varchar(50) NOT NULL,
  `Nacionalidade` varchar(50) DEFAULT NULL,
  `Tipo` varchar(50) DEFAULT NULL,
  `Ano_inicio` int DEFAULT NULL,
  PRIMARY KEY (`Nome_evento`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventos`
--

LOCK TABLES `eventos` WRITE;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
INSERT INTO `eventos` VALUES ('Academy Awards','United States','Film Awards',1929),('Sundance Film Festival','United States','Film Festival',1978),('Emmy Awards','United States','Television Awards',1949),('Berlin International Film Festival','Germany','Film Festival',1951),('Golden Globe Awards','United States','Film and Television Awards',1944);
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filmes`
--

DROP TABLE IF EXISTS `filmes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filmes` (
  `ID_filme` int NOT NULL,
  `Titulo_original` varchar(50) NOT NULL,
  `Ano_producao` int NOT NULL,
  `Data_estreia` date DEFAULT NULL,
  `Titulo_brasil` varchar(50) DEFAULT NULL,
  `Local_estreia` varchar(50) DEFAULT NULL,
  `Idioma_original` varchar(50) DEFAULT NULL,
  `Sala_exibicao` varchar(50) DEFAULT NULL,
  `Arrecadacao_primeiro_ano` decimal(38,2) DEFAULT NULL,
  `Arrecadacao_total` decimal(38,2) DEFAULT NULL,
  `Genero` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_filme`),
  UNIQUE KEY `ID_filme` (`Titulo_original`,`Ano_producao`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filmes`
--

LOCK TABLES `filmes` WRITE;
/*!40000 ALTER TABLE `filmes` DISABLE KEYS */;
INSERT INTO `filmes` VALUES (1,'The Matrix',1999,'1999-03-31','Matrix','Los Angeles','English','Cinema 1',1500000.50,800000000.00,'Sci-Fi'),(2,'Pulp Fiction',1994,'1994-10-14','Pulp Fiction','New York','English','Main Hall',1200000.75,250000000.50,'Crime'),(3,'Inception',2010,'2010-07-08','A Origem','Paris','English','Premium Theater',2500000.25,800000000.00,'Sci-Fi'),(4,'The Shawshank Redemption',1994,'1994-09-10','Um Sonho de Liberdade','Chicago','English','Cell Block A',800000.00,45000000.00,'Drama'),(5,'The Godfather',1972,'1972-03-24','O Poderoso Chefão','New York','Italian','Corleone Theater',500000.00,250000000.00,'Crime'),(6,'Fight Club',1999,'1999-10-15','Clube da Luta','Los Angeles','English','Basement Hall',700000.50,100000000.25,'Drama'),(7,'Forrest Gump',1994,'1994-07-06','Forrest Gump','Alabama','English','Greenbow Theater',1500000.25,600000000.50,'Drama'),(8,'The Dark Knight',2008,'2008-07-18','O Cavaleiro das Trevas','Gotham','English','Wayne Manor Theater',3000000.00,1000000000.00,'Action'),(9,'Titanic',1997,'1997-11-01','Titanic','Atlantic Ocean','English','Rose Theater',2000000.75,2200000000.00,'Romance'),(10,'Avatar',2009,'2009-12-18','Avatar','Pandora','English','Tree of Souls Theater',4000000.50,2800000000.00,'Sci-Fi'),(11,'The Silence of the Lambs',1991,'1991-02-14','O Silêncio dos Inocentes','Baltimore','English','Hannibal Hall',900000.25,300000000.00,'Thriller'),(12,'The Lion King',1994,'1994-06-15','O Rei Leão','Pride Lands','English','Hakuna Matata Theater',1200000.00,968000000.50,'Animation'),(13,'Jurassic Park',1993,'1993-06-11','Parque dos Dinossauros','Isla Nublar','English','Dino Dome',1800000.50,900000000.00,'Adventure'),(14,'The Shining',1980,'1980-05-23','O Iluminado','Colorado','English','Overlook Theater',600000.75,44000000.00,'Horror'),(15,'Casablanca',1942,'1942-11-26','Casablanca','Morocco','English','Rick’s Café Theater',300000.00,104000000.00,'Romance'),(16,'Gone with the Wind',1939,'1939-12-15','E o Vento Levou','Atlanta','English','Tara Theater',500000.50,400000000.00,'Drama'),(17,'The Wizard of Oz',1939,'1939-08-25','O Mágico de Oz','Emerald City','English','Yellow Brick Road Theater',800000.25,290000000.00,'Fantasy'),(18,'E.T. the Extra-Terrestrial',1982,'1982-06-11','E.T. - O Extraterrestre','California','English','Elliot’s Bike Theater',1000000.00,793000000.50,'Sci-Fi'),(19,'The Grand Budapest Hotel',2014,'2014-02-06','O Grande Hotel Budapeste','Zubrowka','English','Lobby Lounge',1200000.50,172000000.00,'Comedy'),(20,'The Departed',2006,'2006-10-06','Os Infiltrados','Boston','English','Undercover Theater',2200000.75,290000000.25,'Crime');
/*!40000 ALTER TABLE `filmes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indicacoes_filme`
--

DROP TABLE IF EXISTS `indicacoes_filme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indicacoes_filme` (
  `ID_indicacoes_filme` int NOT NULL,
  `ID_premio` int DEFAULT NULL,
  `ID_filme` int DEFAULT NULL,
  PRIMARY KEY (`ID_indicacoes_filme`),
  KEY `ID_premio` (`ID_premio`),
  KEY `ID_filme` (`ID_filme`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indicacoes_filme`
--

LOCK TABLES `indicacoes_filme` WRITE;
/*!40000 ALTER TABLE `indicacoes_filme` DISABLE KEYS */;
INSERT INTO `indicacoes_filme` VALUES (1,3,1),(2,3,2),(3,3,3),(4,4,4),(5,4,5),(6,4,6);
/*!40000 ALTER TABLE `indicacoes_filme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indicacoes_pessoa`
--

DROP TABLE IF EXISTS `indicacoes_pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indicacoes_pessoa` (
  `ID_indicacoes_pessoa` int NOT NULL,
  `ID_premio` int DEFAULT NULL,
  `ID_participacao` int DEFAULT NULL,
  PRIMARY KEY (`ID_indicacoes_pessoa`),
  KEY `ID_premio` (`ID_premio`),
  KEY `ID_participacao` (`ID_participacao`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indicacoes_pessoa`
--

LOCK TABLES `indicacoes_pessoa` WRITE;
/*!40000 ALTER TABLE `indicacoes_pessoa` DISABLE KEYS */;
INSERT INTO `indicacoes_pessoa` VALUES (1,1,1),(2,1,2),(3,1,3),(4,2,6),(5,2,7),(6,2,9);
/*!40000 ALTER TABLE `indicacoes_pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `juri`
--

DROP TABLE IF EXISTS `juri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `juri` (
  `ID_juri` int NOT NULL,
  `ID_edicao` int DEFAULT NULL,
  `Nome_artistico` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_juri`),
  KEY `ID_edicao` (`ID_edicao`),
  KEY `Nome_artistico` (`Nome_artistico`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `juri`
--

LOCK TABLES `juri` WRITE;
/*!40000 ALTER TABLE `juri` DISABLE KEYS */;
/*!40000 ALTER TABLE `juri` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_ind_juri` BEFORE INSERT ON `juri` FOR EACH ROW BEGIN
    DECLARE fail BOOLEAN;
    SELECT COUNT(*) INTO fail
    FROM INDICACOES_PESSOA I
    JOIN PARTICIPACOES P ON I.ID_participacao = P.ID_participacao
    WHERE NEW.Nome_artistico = P.Nome_artistico AND I.ID_edicao = NEW.ID_edicao;
    
    IF fail THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A pessoa inserida como júri foi indicada a um prêmio nesta edição do evento.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `participacoes`
--

DROP TABLE IF EXISTS `participacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participacoes` (
  `ID_participacao` int NOT NULL,
  `Nome_artistico` varchar(50) DEFAULT NULL,
  `ID_filme` int DEFAULT NULL,
  `Cargo_filme` enum('Diretor','Produtor','Ator','Roteirista') DEFAULT NULL,
  PRIMARY KEY (`ID_participacao`),
  KEY `Nome_artistico` (`Nome_artistico`),
  KEY `ID_filme` (`ID_filme`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participacoes`
--

LOCK TABLES `participacoes` WRITE;
/*!40000 ALTER TABLE `participacoes` DISABLE KEYS */;
INSERT INTO `participacoes` VALUES (1,'Tom Hanks',1,'Ator'),(2,'Meryl Streep',2,'Ator'),(3,'Leonardo DiCaprio',3,'Ator'),(4,'Cate Blanchett',4,'Diretor'),(5,'Denzel Washington',5,'Produtor'),(6,'Julia Roberts',6,'Ator'),(7,'Will Smith',7,'Ator'),(8,'Jennifer Lawrence',8,'Diretor'),(9,'Robert De Niro',9,'Ator'),(10,'Brad Pitt',10,'Produtor');
/*!40000 ALTER TABLE `participacoes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_doc_part` BEFORE INSERT ON `participacoes` FOR EACH ROW BEGIN
    DECLARE isDocumentary BOOLEAN;
    SELECT Genero = 'Documentário' INTO isDocumentary FROM FILMES WHERE ID_filme = NEW.ID_filme;
    IF NEW.Cargo_filme = 'Ator' AND isDocumentary THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Um ator não pode ser inserido em um documentário.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pessoas`
--

DROP TABLE IF EXISTS `pessoas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoas` (
  `Nome_artistico` varchar(50) NOT NULL,
  `Nome_verdadeiro` varchar(50) DEFAULT NULL,
  `Sexo` enum('F','M') DEFAULT NULL,
  `Ano_nascimento` int DEFAULT NULL,
  `Site` varchar(50) DEFAULT NULL,
  `Ano_inicio` int DEFAULT NULL,
  `Total_anos` int DEFAULT NULL,
  `Situacao` enum('Ativo','Aposentado','Falecido') DEFAULT NULL,
  PRIMARY KEY (`Nome_artistico`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoas`
--

LOCK TABLES `pessoas` WRITE;
/*!40000 ALTER TABLE `pessoas` DISABLE KEYS */;
INSERT INTO `pessoas` VALUES ('Tom Hanks','Thomas Jeffrey Hanks','M',1956,'http://www.tomhanks.com',1978,44,'Ativo'),('Meryl Streep','Mary Louise Streep','F',1949,'http://www.merylstreep.com',1975,47,'Ativo'),('Leonardo DiCaprio','Leonardo Wilhelm DiCaprio','M',1974,'http://www.leonardodicaprio.com',1989,33,'Ativo'),('Cate Blanchett','Catherine Elise Blanchett','F',1969,'http://www.cateblanchett.com',1992,30,'Ativo'),('Denzel Washington','Denzel Hayes Washington Jr.','M',1954,'http://www.denzelwashington.com',1977,45,'Ativo'),('Julia Roberts','Julia Fiona Roberts','F',1967,'http://www.juliaroberts.com',1987,35,'Ativo'),('Brad Pitt','William Bradley Pitt','M',1963,'http://www.bradpitt.com',1987,35,'Ativo'),('Nicole Kidman','Nicole Mary Kidman','F',1967,'http://www.nicolekidman.com',1983,39,'Ativo'),('Will Smith','Willard Carroll Smith Jr.','M',1968,'http://www.willsmith.com',1986,36,'Ativo'),('Charlize Theron','Charlize Theron','F',1975,'http://www.charlizetheron.com',1995,27,'Ativo'),('George Clooney','George Timothy Clooney','M',1961,'http://www.georgeclooney.com',1978,44,'Ativo'),('Jennifer Lawrence','Jennifer Shrader Lawrence','F',1990,'http://www.jenniferlawrence.com',2010,12,'Ativo'),('Robert De Niro','Robert Anthony De Niro Jr.','M',1943,'http://www.robertdeniro.com',1965,57,'Ativo'),('Emma Stone','Emily Jean Stone','F',1988,'http://www.emmastone.com',2004,20,'Ativo'),('Johnny Depp','John Christopher Depp II','M',1963,'http://www.johnnydepp.com',1984,38,'Ativo'),('Anne Hathaway','Anne Jacqueline Hathaway','F',1982,'http://www.annehathaway.com',1999,23,'Ativo'),('Samuel L. Jackson','Samuel Leroy Jackson','M',1948,'http://www.samuelljackson.com',1972,50,'Ativo'),('Natalie Portman','Natalie Hershlag','F',1981,'http://www.natalieportman.com',1994,28,'Ativo'),('Matt Damon','Matthew Paige Damon','M',1970,'http://www.mattdamon.com',1988,34,'Ativo'),('Scarlett Johansson','Scarlett Ingrid Johansson','F',1984,'http://www.scarlettjohansson.com',1994,28,'Ativo');
/*!40000 ALTER TABLE `pessoas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `premio`
--

DROP TABLE IF EXISTS `premio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `premio` (
  `ID_premio` int NOT NULL,
  `ID_edicao` int DEFAULT NULL,
  `ID_pessoa_vencedora` int DEFAULT NULL,
  `ID_filme_vencedor` int DEFAULT NULL,
  `Tipo` varchar(50) DEFAULT NULL,
  `Nome` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_premio`),
  KEY `ID_edicao` (`ID_edicao`),
  KEY `ID_pessoa_vencedora` (`ID_pessoa_vencedora`),
  KEY `ID_filme_vencedor` (`ID_filme_vencedor`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `premio`
--

LOCK TABLES `premio` WRITE;
/*!40000 ALTER TABLE `premio` DISABLE KEYS */;
INSERT INTO `premio` VALUES (1,1,2,NULL,'Melhor Ator','Oscar de Melhor Ator'),(2,5,7,NULL,'Melhor Ator','Globo de Ouro de Melhor Ator'),(3,1,NULL,2,'Melhor Filme','Oscar de Melhor Filme'),(4,5,NULL,5,'Melhor Filme','Globo de Ouro de Melhor Filme'),(5,3,7,NULL,'Melhor Ator','Emmy de Melhor Ator'),(6,3,NULL,2,'Melhor Filme','Emmy de Melhor Filme');
/*!40000 ALTER TABLE `premio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bd1'
--

--
-- Dumping routines for database 'bd1'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-12 15:50:44
