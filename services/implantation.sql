-- MySQL dump 10.13  Distrib 8.0.37, for Linux (x86_64)
--
-- Host: localhost    Database: financas
-- ------------------------------------------------------
-- Server version	8.0.37-0ubuntu0.22.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `financas`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `financas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `financas`;

--
-- Table structure for table `beneficiados`
--

DROP TABLE IF EXISTS `beneficiados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beneficiados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `cpf_cnpj` bigint DEFAULT NULL,
  `email` varchar(80) NOT NULL,
  `tel_celular` varchar(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave_beneficiado` (`nome`,`cpf_cnpj`,`email`,`tel_celular`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cartao_credito`
--

DROP TABLE IF EXISTS `cartao_credito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartao_credito` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome_cartao` varchar(255) NOT NULL,
  `numero_cartao` varchar(16) NOT NULL,
  `nome_titular` varchar(255) NOT NULL,
  `proprietario_cartao` varchar(100) DEFAULT NULL,
  `documento_titular` bigint NOT NULL,
  `data_validade` date NOT NULL,
  `codigo_seguranca` int NOT NULL,
  `limite_credito` decimal(10,2) NOT NULL,
  `limite_maximo` decimal(10,2) DEFAULT NULL,
  `conta_associada` varchar(255) NOT NULL,
  `inativo` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave_cartao` (`numero_cartao`,`documento_titular`,`conta_associada`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contas`
--

DROP TABLE IF EXISTS `contas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome_conta` varchar(100) DEFAULT NULL,
  `tipo_conta` varchar(50) DEFAULT NULL,
  `proprietario_conta` varchar(100) DEFAULT NULL,
  `documento_proprietario_conta` bigint DEFAULT NULL,
  `inativa` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave_conta` (`nome_conta`,`tipo_conta`,`proprietario_conta`,`documento_proprietario_conta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `credores`
--

DROP TABLE IF EXISTS `credores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `cpf_cnpj` bigint DEFAULT NULL,
  `email` varchar(80) NOT NULL,
  `tel_celular` varchar(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave_credor` (`nome`,`cpf_cnpj`,`email`,`tel_celular`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `despesas`
--

DROP TABLE IF EXISTS `despesas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `despesas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` text,
  `valor` decimal(10,2) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `horario` time DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `conta` varchar(50) DEFAULT NULL,
  `proprietario_despesa` varchar(100) DEFAULT NULL,
  `documento_proprietario_despesa` bigint DEFAULT NULL,
  `pago` char(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave_despesa` (`valor`,`data`,`horario`,`categoria`,`conta`,`proprietario_despesa`,`documento_proprietario_despesa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `despesas_cartao_credito`
--

DROP TABLE IF EXISTS `despesas_cartao_credito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `despesas_cartao_credito` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` text,
  `valor` decimal(10,2) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `horario` time DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `cartao` varchar(50) DEFAULT NULL,
  `numero_cartao` varchar(16) DEFAULT NULL,
  `proprietario_despesa_cartao` varchar(100) DEFAULT NULL,
  `doc_proprietario_cartao` bigint DEFAULT NULL,
  `parcela` int DEFAULT '1',
  `pago` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave_despesa_cartao` (`valor`,`data`,`horario`,`categoria`,`cartao`,`parcela`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emprestimos`
--

DROP TABLE IF EXISTS `emprestimos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emprestimos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` text,
  `valor` decimal(10,2) DEFAULT NULL,
  `valor_pago` decimal(10,2) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `horario` time DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `conta` varchar(50) DEFAULT NULL,
  `devedor` varchar(50) DEFAULT '',
  `documento_devedor` bigint DEFAULT NULL,
  `credor` varchar(50) DEFAULT 'Tarcísio',
  `documento_credor` bigint DEFAULT NULL,
  `pago` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave_emprestimo` (`valor`,`data`,`horario`,`categoria`,`conta`,`devedor`,`credor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fechamentos_cartao`
--

DROP TABLE IF EXISTS `fechamentos_cartao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fechamentos_cartao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome_cartao` varchar(255) DEFAULT NULL,
  `numero_cartao` varchar(16) DEFAULT NULL,
  `documento_titular` bigint DEFAULT NULL,
  `ano` varchar(4) DEFAULT NULL,
  `mes` varchar(20) DEFAULT NULL,
  `data_comeco_fatura` date DEFAULT NULL,
  `data_fim_fatura` date DEFAULT NULL,
  `fechado` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave_fechamento_cartao` (`numero_cartao`,`documento_titular`,`ano`,`mes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `receitas`
--

DROP TABLE IF EXISTS `receitas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receitas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` text,
  `valor` decimal(10,2) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `horario` time DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `conta` varchar(50) DEFAULT NULL,
  `proprietario_receita` varchar(100) DEFAULT NULL,
  `documento_proprietario_receita` bigint DEFAULT NULL,
  `recebido` char(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave_despesa` (`valor`,`data`,`horario`,`categoria`,`conta`,`proprietario_receita`,`documento_proprietario_receita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transferencias`
--

DROP TABLE IF EXISTS `transferencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transferencias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) DEFAULT NULL,
  `valor` float DEFAULT NULL,
  `data` date DEFAULT NULL,
  `horario` time DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `conta_origem` varchar(50) DEFAULT NULL,
  `conta_destino` varchar(50) DEFAULT NULL,
  `proprietario_transferencia` varchar(100) DEFAULT NULL,
  `documento_proprietario_transferencia` varchar(100) DEFAULT NULL,
  `transferido` char(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave_transferencia` (`valor`,`data`,`horario`,`categoria`,`conta_origem`,`conta_destino`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(15) NOT NULL,
  `senha` varchar(200) DEFAULT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `cpf` bigint DEFAULT NULL,
  `email` varchar(80) NOT NULL,
  `sexo` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave_usuario` (`login`,`senha`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin','123','John Doe',82666254682,'johndoe@fakeemail.com','M')
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-22 20:46:06
