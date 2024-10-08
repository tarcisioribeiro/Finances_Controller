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
  `id_beneficiado` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `cpf_cnpj` bigint NOT NULL,
  `tel_celular` varchar(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_beneficiado`),
  UNIQUE KEY `chave_beneficiado` (`nome`,`cpf_cnpj`,`tel_celular`),
  UNIQUE KEY `idx_beneficiado` (`nome`,`cpf_cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beneficiados`
--

LOCK TABLES `beneficiados` WRITE;
/*!40000 ALTER TABLE `beneficiados` DISABLE KEYS */;
/*!40000 ALTER TABLE `beneficiados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cartao_credito`
--

DROP TABLE IF EXISTS `cartao_credito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartao_credito` (
  `id_cartao` int NOT NULL AUTO_INCREMENT,
  `nome_cartao` varchar(100) NOT NULL,
  `numero_cartao` varchar(16) NOT NULL,
  `nome_titular` varchar(100) NOT NULL,
  `proprietario_cartao` varchar(100) NOT NULL,
  `documento_titular` bigint NOT NULL,
  `data_validade` date NOT NULL,
  `codigo_seguranca` int NOT NULL,
  `limite_credito` decimal(10,2) NOT NULL DEFAULT '0.00',
  `limite_maximo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `conta_associada` varchar(100) NOT NULL,
  `inativo` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`id_cartao`),
  UNIQUE KEY `chave_cartao` (`numero_cartao`,`documento_titular`,`conta_associada`),
  UNIQUE KEY `unq_cartao_credito_nome_cartao` (`nome_cartao`,`numero_cartao`),
  KEY `fk_cartao_credito_usuarios` (`proprietario_cartao`,`documento_titular`),
  KEY `fk_cartao_credito_contas` (`conta_associada`),
  CONSTRAINT `fk_cartao_credito_contas` FOREIGN KEY (`conta_associada`) REFERENCES `contas` (`nome_conta`) ON DELETE RESTRICT,
  CONSTRAINT `fk_cartao_credito_usuarios` FOREIGN KEY (`proprietario_cartao`, `documento_titular`) REFERENCES `usuarios` (`nome`, `cpf`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartao_credito`
--

LOCK TABLES `cartao_credito` WRITE;
/*!40000 ALTER TABLE `cartao_credito` DISABLE KEYS */;
/*!40000 ALTER TABLE `cartao_credito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contas`
--

DROP TABLE IF EXISTS `contas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contas` (
  `id_conta` int NOT NULL AUTO_INCREMENT,
  `nome_conta` varchar(100) NOT NULL,
  `tipo_conta` varchar(50) NOT NULL,
  `proprietario_conta` varchar(100) NOT NULL,
  `documento_proprietario_conta` bigint NOT NULL,
  `inativa` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id_conta`),
  UNIQUE KEY `chave_conta` (`nome_conta`,`tipo_conta`,`proprietario_conta`,`documento_proprietario_conta`),
  KEY `fk_contas_usuarios` (`proprietario_conta`,`documento_proprietario_conta`),
  CONSTRAINT `fk_contas_usuarios` FOREIGN KEY (`proprietario_conta`, `documento_proprietario_conta`) REFERENCES `usuarios` (`nome`, `cpf`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contas`
--

LOCK TABLES `contas` WRITE;
/*!40000 ALTER TABLE `contas` DISABLE KEYS */;
/*!40000 ALTER TABLE `contas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credores`
--

DROP TABLE IF EXISTS `credores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credores` (
  `id_credor` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf_cnpj` bigint NOT NULL,
  `tel_celular` varchar(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_credor`),
  UNIQUE KEY `chave_credor` (`nome`,`cpf_cnpj`,`tel_celular`),
  UNIQUE KEY `idx_credor` (`nome`,`cpf_cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credores`
--

LOCK TABLES `credores` WRITE;
/*!40000 ALTER TABLE `credores` DISABLE KEYS */;
/*!40000 ALTER TABLE `credores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `despesas`
--

DROP TABLE IF EXISTS `despesas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `despesas` (
  `id_despesa` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL DEFAULT 'Despesa',
  `valor` decimal(10,2) NOT NULL DEFAULT '0.00',
  `data` date NOT NULL DEFAULT (curdate()),
  `horario` time NOT NULL DEFAULT (curtime()),
  `categoria` varchar(100) NOT NULL,
  `conta` varchar(100) NOT NULL,
  `proprietario_despesa` varchar(100) NOT NULL,
  `documento_proprietario_despesa` bigint NOT NULL,
  `pago` char(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id_despesa`),
  UNIQUE KEY `chave_despesa` (`valor`,`data`,`horario`,`categoria`,`conta`,`proprietario_despesa`,`documento_proprietario_despesa`),
  KEY `fk_despesas_contas` (`conta`),
  CONSTRAINT `fk_despesas_contas` FOREIGN KEY (`conta`) REFERENCES `contas` (`nome_conta`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `despesas`
--

LOCK TABLES `despesas` WRITE;
/*!40000 ALTER TABLE `despesas` DISABLE KEYS */;
/*!40000 ALTER TABLE `despesas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `despesas_cartao_credito`
--

DROP TABLE IF EXISTS `despesas_cartao_credito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `despesas_cartao_credito` (
  `id_despesa_cartao` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL DEFAULT 'Despesa Cartão',
  `valor` decimal(10,2) NOT NULL DEFAULT '0.00',
  `data` date NOT NULL DEFAULT (curdate()),
  `horario` time NOT NULL DEFAULT (curtime()),
  `categoria` varchar(100) NOT NULL,
  `cartao` varchar(100) NOT NULL,
  `numero_cartao` varchar(16) NOT NULL,
  `proprietario_despesa_cartao` varchar(100) NOT NULL,
  `doc_proprietario_cartao` bigint NOT NULL,
  `parcela` int NOT NULL DEFAULT (_utf8mb4'1'),
  `pago` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id_despesa_cartao`),
  UNIQUE KEY `chave_despesa_cartao` (`valor`,`data`,`horario`,`categoria`,`cartao`,`parcela`),
  KEY `fk_despesas_cartao_credito` (`cartao`,`numero_cartao`),
  CONSTRAINT `fk_despesas_cartao_credito` FOREIGN KEY (`cartao`, `numero_cartao`) REFERENCES `cartao_credito` (`nome_cartao`, `numero_cartao`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `despesas_cartao_credito`
--

LOCK TABLES `despesas_cartao_credito` WRITE;
/*!40000 ALTER TABLE `despesas_cartao_credito` DISABLE KEYS */;
/*!40000 ALTER TABLE `despesas_cartao_credito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emprestimos`
--

DROP TABLE IF EXISTS `emprestimos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emprestimos` (
  `id_emprestimo` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `valor` decimal(10,2) NOT NULL DEFAULT '0.00',
  `valor_pago` decimal(10,2) NOT NULL DEFAULT '0.00',
  `data` date NOT NULL DEFAULT (curdate()),
  `horario` time NOT NULL DEFAULT (curtime()),
  `categoria` varchar(100) DEFAULT NULL,
  `conta` varchar(100) NOT NULL,
  `devedor` varchar(100) NOT NULL,
  `documento_devedor` bigint NOT NULL,
  `credor` varchar(100) NOT NULL,
  `documento_credor` bigint NOT NULL,
  `pago` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id_emprestimo`),
  UNIQUE KEY `chave_emprestimo` (`valor`,`data`,`horario`,`categoria`,`conta`,`devedor`,`credor`),
  KEY `fk_emprestimos_contas` (`conta`),
  KEY `fk_beneficiado_emprestimo` (`devedor`,`documento_devedor`),
  KEY `fk_credor_emprestimo` (`credor`,`documento_credor`),
  CONSTRAINT `fk_beneficiado_emprestimo` FOREIGN KEY (`devedor`, `documento_devedor`) REFERENCES `beneficiados` (`nome`, `cpf_cnpj`) ON DELETE RESTRICT,
  CONSTRAINT `fk_credor_emprestimo` FOREIGN KEY (`credor`, `documento_credor`) REFERENCES `credores` (`nome`, `cpf_cnpj`) ON DELETE RESTRICT,
  CONSTRAINT `fk_emprestimos_contas` FOREIGN KEY (`conta`) REFERENCES `contas` (`nome_conta`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emprestimos`
--

LOCK TABLES `emprestimos` WRITE;
/*!40000 ALTER TABLE `emprestimos` DISABLE KEYS */;
/*!40000 ALTER TABLE `emprestimos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fechamentos_cartao`
--

DROP TABLE IF EXISTS `fechamentos_cartao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fechamentos_cartao` (
  `id_fechamento_cartao` int NOT NULL AUTO_INCREMENT,
  `nome_cartao` varchar(100) NOT NULL,
  `numero_cartao` varchar(16) NOT NULL,
  `documento_titular` bigint NOT NULL,
  `ano` year NOT NULL,
  `mes` varchar(20) NOT NULL,
  `data_comeco_fatura` date NOT NULL,
  `data_fim_fatura` date NOT NULL,
  `fechado` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`id_fechamento_cartao`),
  UNIQUE KEY `chave_fechamento_cartao` (`numero_cartao`,`documento_titular`,`ano`,`mes`),
  KEY `fk_fechamentos_cartao` (`nome_cartao`,`numero_cartao`),
  CONSTRAINT `fk_fechamentos_cartao` FOREIGN KEY (`nome_cartao`, `numero_cartao`) REFERENCES `cartao_credito` (`nome_cartao`, `numero_cartao`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fechamentos_cartao`
--

LOCK TABLES `fechamentos_cartao` WRITE;
/*!40000 ALTER TABLE `fechamentos_cartao` DISABLE KEYS */;
/*!40000 ALTER TABLE `fechamentos_cartao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_atividades`
--

DROP TABLE IF EXISTS `logs_atividades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs_atividades` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `data_log` date NOT NULL DEFAULT (curdate()),
  `horario_log` time NOT NULL DEFAULT (curtime()),
  `usuario_log` varchar(25) NOT NULL,
  `tipo_log` varchar(100) NOT NULL,
  `conteudo_log` text NOT NULL,
  PRIMARY KEY (`id_log`),
  KEY `fk_logs_atividades_usuarios` (`usuario_log`),
  CONSTRAINT `fk_logs_atividades_usuarios` FOREIGN KEY (`usuario_log`) REFERENCES `usuarios` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_atividades`
--

LOCK TABLES `logs_atividades` WRITE;
/*!40000 ALTER TABLE `logs_atividades` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_atividades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receitas`
--

DROP TABLE IF EXISTS `receitas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receitas` (
  `id_receita` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL DEFAULT 'Receita',
  `valor` decimal(10,2) DEFAULT '0.00',
  `data` date NOT NULL DEFAULT (curdate()),
  `horario` time NOT NULL DEFAULT (curtime()),
  `categoria` varchar(100) NOT NULL,
  `conta` varchar(100) NOT NULL,
  `proprietario_receita` varchar(100) NOT NULL,
  `documento_proprietario_receita` bigint NOT NULL,
  `recebido` char(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id_receita`),
  UNIQUE KEY `chave_despesa` (`valor`,`data`,`horario`,`categoria`,`conta`,`proprietario_receita`,`documento_proprietario_receita`),
  KEY `fk_receitas_contas` (`conta`),
  CONSTRAINT `fk_receitas_contas` FOREIGN KEY (`conta`) REFERENCES `contas` (`nome_conta`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receitas`
--

LOCK TABLES `receitas` WRITE;
/*!40000 ALTER TABLE `receitas` DISABLE KEYS */;
/*!40000 ALTER TABLE `receitas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferencias`
--

DROP TABLE IF EXISTS `transferencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transferencias` (
  `id_transferencia` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL DEFAULT 'Transferência',
  `valor` decimal(10,2) NOT NULL,
  `data` date NOT NULL DEFAULT (curdate()),
  `horario` time NOT NULL DEFAULT (curtime()),
  `categoria` varchar(100) NOT NULL,
  `conta_origem` varchar(100) NOT NULL,
  `conta_destino` varchar(100) NOT NULL,
  `proprietario_transferencia` varchar(100) NOT NULL,
  `documento_proprietario_transferencia` varchar(100) NOT NULL,
  `transferido` char(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id_transferencia`),
  UNIQUE KEY `chave_transferencia` (`valor`,`data`,`horario`,`categoria`,`conta_origem`,`conta_destino`),
  KEY `fk_transferencias_despesas` (`conta_origem`),
  KEY `fk_transferencias_receitas` (`conta_destino`),
  CONSTRAINT `fk_transferencias_despesas` FOREIGN KEY (`conta_origem`) REFERENCES `despesas` (`conta`) ON DELETE RESTRICT,
  CONSTRAINT `fk_transferencias_receitas` FOREIGN KEY (`conta_destino`) REFERENCES `receitas` (`conta`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferencias`
--

LOCK TABLES `transferencias` WRITE;
/*!40000 ALTER TABLE `transferencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `login` varchar(25) NOT NULL,
  `senha` varchar(100) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cpf` bigint NOT NULL,
  `sexo` char(1) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `chave_usuario` (`login`,`senha`),
  UNIQUE KEY `unq_usuarios_nome` (`nome`,`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-28 20:19:00
