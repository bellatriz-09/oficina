-- ============================================================
-- Esquema Lógico — Oficina Mecânica
-- Mapeamento do modelo conceitual (DER) para o modelo relacional.
-- ============================================================

CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

CREATE TABLE cliente (
    id_cliente      INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(150) NOT NULL,
    endereco        VARCHAR(200),
    telefone        VARCHAR(20)
);

CREATE TABLE veiculo (
    id_veiculo      INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente      INT NOT NULL,
    placa           VARCHAR(8) NOT NULL UNIQUE,
    modelo          VARCHAR(80) NOT NULL,
    marca           VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE equipe (
    id_equipe       INT AUTO_INCREMENT PRIMARY KEY,
    nome_equipe     VARCHAR(80) NOT NULL
);

CREATE TABLE mecanico (
    id_mecanico     INT AUTO_INCREMENT PRIMARY KEY,
    id_equipe       INT NOT NULL,
    nome            VARCHAR(120) NOT NULL,
    endereco        VARCHAR(200),
    especialidade   VARCHAR(80),
    FOREIGN KEY (id_equipe) REFERENCES equipe(id_equipe)
);

CREATE TABLE ordem_servico (
    id_os           INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo      INT NOT NULL,
    id_equipe       INT NOT NULL,
    data_emissao    DATE NOT NULL,
    valor           DECIMAL(10,2) NOT NULL DEFAULT 0,
    status          ENUM('aberta','em_execucao','concluida','cancelada') NOT NULL DEFAULT 'aberta',
    data_conclusao  DATE,
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo),
    FOREIGN KEY (id_equipe) REFERENCES equipe(id_equipe)
);

CREATE TABLE servico (
    id_servico          INT AUTO_INCREMENT PRIMARY KEY,
    descricao           VARCHAR(150) NOT NULL,
    valor_referencia    DECIMAL(10,2) NOT NULL
);

CREATE TABLE peca (
    id_peca         INT AUTO_INCREMENT PRIMARY KEY,
    descricao       VARCHAR(150) NOT NULL,
    valor_unitario  DECIMAL(10,2) NOT NULL
);

-- Associação N:N entre ordem_servico e servico (uma OS tem vários serviços,
-- um serviço pode estar em várias OS); valor_cobrado pode variar por OS.
CREATE TABLE item_servico (
    id_os           INT NOT NULL,
    id_servico      INT NOT NULL,
    valor_cobrado   DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_os, id_servico),
    FOREIGN KEY (id_os) REFERENCES ordem_servico(id_os),
    FOREIGN KEY (id_servico) REFERENCES servico(id_servico)
);

-- Associação N:N entre ordem_servico e peca, com a quantidade usada.
CREATE TABLE item_peca (
    id_os           INT NOT NULL,
    id_peca         INT NOT NULL,
    quantidade      INT NOT NULL,
    valor_cobrado   DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_os, id_peca),
    FOREIGN KEY (id_os) REFERENCES ordem_servico(id_os),
    FOREIGN KEY (id_peca) REFERENCES peca(id_peca)
);
