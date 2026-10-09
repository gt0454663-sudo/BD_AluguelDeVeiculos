CREATE DATABASE AcdnRentalCar;
USE AcdnRentalCar;

CREATE TABLE sedes (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    endereco VARCHAR(80) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    nomeGerente VARCHAR(50) NOT NULL,
    multa DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE classesCarro (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    valorDiaria DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE clientes (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    cnh VARCHAR(20) NOT NULL,
    validadeCnh DATE NOT NULL,
    categoriaCnh VARCHAR(3) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE carros (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    placa VARCHAR(10) NOT NULL,
    modelo VARCHAR(40) NOT NULL,
    ano VARCHAR(9) NOT NULL,
    cor VARCHAR(20) NOT NULL,
    quilometragem DECIMAL(8,2) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    situacao VARCHAR(30) NOT NULL,
    origemCarro INT UNSIGNED NOT NULL,
    localizacaoCarro INT UNSIGNED,
    classeCarro INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (id), 
    CONSTRAINT fk_sedesOrigem 
    FOREIGN KEY (origemCarro)
	REFERENCES sedes(id),
    CONSTRAINT fk_sedesLocAtual
	FOREIGN KEY (localizacaoCarro)
	REFERENCES sedes(id),
    CONSTRAINT fk_classes
	FOREIGN KEY (classeCarro)
	REFERENCES classesCarro(id)
);

CREATE TABLE reservas (
    numero INT UNSIGNED NOT NULL AUTO_INCREMENT,
    diarias INT NOT NULL,
    dataLocacao DATE NOT NULL,
    dataRetorno DATE,
    quilometrosRodados DECIMAL(8,2),
    multa DECIMAL(8,2),
    situacao VARCHAR(15) NOT NULL,
    total DECIMAL(8,2),
    carro_reserva INT UNSIGNED NOT NULL,
    cliente_reserva INT UNSIGNED NOT NULL,
    sedeLocacao INT UNSIGNED NOT NULL,
    sedeDevolucao INT UNSIGNED,
    
    PRIMARY KEY (numero),
    CONSTRAINT fk_carros
	FOREIGN KEY (carro_reserva)
	REFERENCES carros(id),
    CONSTRAINT fk_clientes
	FOREIGN KEY (cliente_reserva)
	REFERENCES clientes(id),
    CONSTRAINT fk_sedesLocacao
	FOREIGN KEY (sedeLocacao)
	REFERENCES sedes(id),
    CONSTRAINT fk_sedesDevolucao
	FOREIGN KEY (sedeDevolucao)
	REFERENCES sedes(id)
);