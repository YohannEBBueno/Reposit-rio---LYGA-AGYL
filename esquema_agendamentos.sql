CREATE DATABASE IF NOT EXISTS sistema_agendamentos;
USE sistema_agendamentos;

-- 1. Tabela Cliente
CREATE TABLE Cliente (
    CPF CHAR(11) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Data_Nascimento DATE
);

-- 2. Tabela Servico
CREATE TABLE Servico (
    ID_Servico INT AUTO_INCREMENT PRIMARY KEY,
    Fotos_Antes TEXT,
    Fotos_Depois TEXT,
    Nome VARCHAR(100) NOT NULL,
    Duracao INT,
    Preco DECIMAL(10,2) NOT NULL,
    Descricao TEXT
);

-- 3. Tabela Agendamento
CREATE TABLE Agendamento (
    ID_Agendamento INT AUTO_INCREMENT PRIMARY KEY,
    Data_Hora DATETIME NOT NULL,
    Servico_Agendado INT NOT NULL,
    Alergias TEXT,
    CPF_Cliente CHAR(11) NOT NULL,

    CONSTRAINT fk_agendamento_cliente
        FOREIGN KEY (CPF_Cliente)
        REFERENCES Cliente(CPF),

    CONSTRAINT fk_agendamento_servico
        FOREIGN KEY (Servico_Agendado)
        REFERENCES Servico(ID_Servico)
);

-- 4. Tabela Pagamento
CREATE TABLE Pagamento (
    ID_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    NF_Paulista BOOLEAN DEFAULT FALSE,
    Data DATE NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    Metodo VARCHAR(30) NOT NULL,
    ID_Agendamento INT NOT NULL UNIQUE,

    CONSTRAINT fk_pagamento_agendamento
        FOREIGN KEY (ID_Agendamento)
        REFERENCES Agendamento(ID_Agendamento)
);

-- 5. Tabela Controle_Financeiro
CREATE TABLE Controle_Financeiro (
    ID_Lancamento INT AUTO_INCREMENT PRIMARY KEY,
    Tipo VARCHAR(30) NOT NULL,
    Data DATE NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    ID_Pagamento INT NOT NULL,

    CONSTRAINT fk_controle_pagamento
        FOREIGN KEY (ID_Pagamento)
        REFERENCES Pagamento(ID_Pagamento)
);
