CREATE DATABASE IF NOT EXISTS sistema_agendamentos;
USE sistema_agendamentos;

-- 1. Tabela Cliente
CREATE TABLE Cliente (
    CPF VARCHAR(14) PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    Data_Nascimento DATE NOT NULL,
    Email VARCHAR(150),
    Telefone VARCHAR(20)
);

-- 2. Tabela Profissional
CREATE TABLE Profissional (
    ID_Profissional INT AUTO_INCREMENT PRIMARY KEY,
    CPF VARCHAR(14) NOT NULL UNIQUE,
    Nome VARCHAR(150) NOT NULL,
    Email VARCHAR(150),
    Telefone VARCHAR(20),
    Especialidade VARCHAR(100)
);

-- 3. Tabela Servico
CREATE TABLE Servico (
    ID_Servico INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Duracao TIME NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL,
    Descricao TEXT
);

-- 4. Tabela Agendamento
CREATE TABLE Agendamento (
    ID_Agendamento INT AUTO_INCREMENT,
    Data_Hora DATETIME NOT NULL,
    Servico_Agendado VARCHAR(100),
    Preco_Cobrado DECIMAL(10, 2) NOT NULL,
    Alergias TEXT,
    CPF_Cliente VARCHAR(14) NOT NULL,
    ID_Profissional INT NOT NULL,
    ID_Servico INT NOT NULL,

    PRIMARY KEY (ID_Agendamento, Data_Hora),
    
    CONSTRAINT fk_agendamento_cliente 
        FOREIGN KEY (CPF_Cliente) REFERENCES Cliente(CPF),
    CONSTRAINT fk_agendamento_profissional 
        FOREIGN KEY (ID_Profissional) REFERENCES Profissional(ID_Profissional),
    CONSTRAINT fk_agendamento_servico 
        FOREIGN KEY (ID_Servico) REFERENCES Servico(ID_Servico)
);

-- 5. Tabela Pagamento
CREATE TABLE Pagamento (
    NF_Paulista VARCHAR(50) PRIMARY KEY,
    Status_Pagamento VARCHAR(50) NOT NULL,
    Metodo VARCHAR(50) NOT NULL,
    Data DATE NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL,
    ID_Agendamento INT NOT NULL UNIQUE,
    Data_Hora_Agendamento DATETIME NOT NULL,
    
    CONSTRAINT fk_pagamento_agendamento 
        FOREIGN KEY (ID_Agendamento, Data_Hora_Agendamento) 
        REFERENCES Agendamento(ID_Agendamento, Data_Hora)
);

-- 6. Tabela Controle_Financeiro
CREATE TABLE Controle_Financeiro (
    ID_Lancamento INT AUTO_INCREMENT PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL,
    Categoria VARCHAR(100),
    Descricao TEXT,
    Data DATE NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL,
    Forma_Pagamento VARCHAR(50),
    NF_Paulista VARCHAR(50),
    
    CONSTRAINT fk_financeiro_pagamento 
        FOREIGN KEY (NF_Paulista) REFERENCES Pagamento(NF_Paulista)
);
