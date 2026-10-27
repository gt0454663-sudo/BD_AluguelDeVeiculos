CREATE DATABASE db_formula_1;
USE db_formula_1;

CREATE TABLE paises (
    cod_pais INT PRIMARY KEY,
    nome_pais VARCHAR(50) NOT NULL
);

CREATE TABLE corridas (
    sigla_gp INT PRIMARY KEY,
    nome_gp VARCHAR(100) NOT NULL,
    cod_pais INT NOT NULL,
    qtd_voltas INT NOT NULL,
    FOREIGN KEY (cod_pais) REFERENCES paises(cod_pais)
);

CREATE TABLE equipes (
    sigla_equipe INT PRIMARY KEY,
    nome_equipe VARCHAR(100) NOT NULL,
    cod_pais INT NOT NULL,
    FOREIGN KEY (cod_pais) REFERENCES paises(cod_pais)
);

CREATE TABLE pilotos (
    num_piloto INT PRIMARY KEY,
    nome_piloto VARCHAR(100) NOT NULL,
    cod_pais INT NOT NULL,
    sigla_equipe INT NOT NULL,
    salario DECIMAL(10,2),
    FOREIGN KEY (cod_pais) REFERENCES paises(cod_pais),
    FOREIGN KEY (sigla_equipe) REFERENCES equipes(sigla_equipe)
);

CREATE TABLE participantes (
    sigla_gp INT NOT NULL,
    num_piloto INT NOT NULL,
    posicao_largada INT NOT NULL,
    PRIMARY KEY (sigla_gp, num_piloto),
    FOREIGN KEY (sigla_gp) REFERENCES corridas(sigla_gp),
    FOREIGN KEY (num_piloto) REFERENCES pilotos(num_piloto)
);

INSERT INTO paises (cod_pais, nome_pais) VALUES
(1, 'Brasil'),
(2, 'Italia'),
(3, 'Franca'),
(4, 'Alemanha'),
(5, 'Espanha'),
(6, 'Portugal'),
(7, 'Japao'),
(8, 'Canada'),
(9, 'Australia'),
(10, 'Belgica');

INSERT INTO equipes (sigla_equipe, nome_equipe, cod_pais) VALUES
(1, 'Scuderia Brasil', 1),
(2, 'Ferrari', 2),
(3, 'Alpine', 3),
(4, 'Mercedes', 4),
(5, 'Aston Martin', 5),
(6, 'McLaren', 6),
(7, 'Honda Racing', 7),
(8, 'Canadian Motorsport', 8),
(9, 'Australia Racing', 9),
(10, 'Belgian GP Team', 10);

INSERT INTO pilotos
(num_piloto, nome_piloto, cod_pais, sigla_equipe) VALUES
(1, 'Ayrton Senna', 1, 1),
(2, 'Felipe Massa', 1, 1),
(3, 'Rubens Barrichello', 1, 1),
(4, 'Nelson Piquet', 1, 1),
(5, 'Emerson Fittipaldi', 1, 1),
(6, 'Andrea Kimi Antonelli', 2, 2),
(7, 'Jarno Trulli', 2, 2),
(8, 'Giancarlo Fisichella', 2, 2),
(9, 'Alain Prost', 3, 3),
(10, 'Pierre Gasly', 3, 3),
(11, 'Michael Schumacher', 4, 4),
(12, 'Fernando Alonso', 5, 5);

INSERT INTO corridas
(sigla_gp, nome_gp, cod_pais, qtd_voltas) VALUES
(1, 'GP do Brasil', 1, 71),
(2, 'GP da Italia', 2, 53),
(3, 'GP da Franca', 3, 53),
(4, 'GP da Alemanha', 4, 67),
(5, 'GP da Espanha', 5, 66),
(6, 'GP de Portugal', 6, 66),
(7, 'GP do Japao', 7, 53),
(8, 'GP do Canada', 8, 70),
(9, 'GP da Australia', 9, 58),
(10, 'GP da Belgica', 10, 44);

INSERT INTO participantes
(sigla_gp, num_piloto, posicao_largada) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2),
(5, 5, 3),
(6, 6, 3),
(7, 7, 4),
(8, 8, 4),
(9, 9, 5),
(10, 10, 5),
(1, 11, 6),
(2, 12, 6);

SELECT nome_pais
FROM paises
WHERE UPPER(nome_pais) LIKE 'B%L';

SELECT pi.nome_piloto
FROM pilotos AS pi
INNER JOIN paises AS pa
    ON pi.cod_pais = pa.cod_pais
WHERE UPPER(pa.nome_pais)
IN ('BRASIL', 'ITALIA', 'FRANCA');

SELECT nome_piloto
FROM pilotos;

SELECT nome_gp AS `Nome do GP`, qtd_voltas AS `Quantidade de Voltas`
FROM corridas;

SELECT pi.nome_piloto, pa.nome_pais
FROM pilotos AS pi
INNER JOIN paises AS pa
ON pi.cod_pais = pa.cod_pais;

UPDATE pilotos
SET salario = CASE num_piloto
    WHEN 1 THEN 95000
    WHEN 2 THEN 85000
    WHEN 3 THEN 75000
    WHEN 4 THEN 110000
    WHEN 5 THEN 90000
    WHEN 6 THEN 70000
    WHEN 7 THEN 65000
    WHEN 8 THEN 80000
    WHEN 9 THEN 120000
    WHEN 10 THEN 72000
    WHEN 11 THEN 150000
    WHEN 12 THEN 100000
    ELSE salario
END
WHERE num_piloto IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);

SELECT nome_piloto, salario
FROM pilotos
WHERE salario BETWEEN 70000 AND 100000;

SELECT cod_pais, AVG(salario) AS media_salarial
FROM pilotos
GROUP BY cod_pais;

SELECT DISTINCT salario
FROM pilotos
ORDER BY salario ASC;