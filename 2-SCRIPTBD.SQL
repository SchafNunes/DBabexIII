-- Drop Tables
DROP TABLE IF EXISTS dbadeec.usuarios CASCADE;
DROP TABLE IF EXISTS dbadeec.tipo_usuario CASCADE;
DROP TABLE IF EXISTS dbadeec.demanda CASCADE;
DROP TABLE IF EXISTS dbadeec.inscricao_demanda CASCADE;
DROP TABLE IF EXISTS dbadeec.atividade CASCADE;
DROP TABLE IF EXISTS dbadeec.entrega_atividade CASCADE;
DROP TABLE IF EXISTS dbadeec.localizacao CASCADE;
DROP TABLE IF EXISTS dbadeec.certificado CASCADE;
DROP TABLE IF EXISTS dbadeec.certificado_modelo CASCADE;
DROP SEQUENCE IF EXISTS dbadeec.seq_cd_demanda CASCADE;
DROP SEQUENCE IF EXISTS seq_cd_usuario CASCADE;
DROP SEQUENCE IF EXISTS seq_cd_localizacao CASCADE;
DROP SEQUENCE IF EXISTS seq_cd_inscricao_demanda CASCADE;

-- Create Tables
CREATE TABLE dbadeec.usuarios (
    cd_usuario INT,
    nm_usuario VARCHAR(200),
    nr_cpf VARCHAR(200),
    ds_email VARCHAR(200),
    nr_ddd VARCHAR(200),
    nr_telefone VARCHAR(200),
    cd_tp_usuario INT,
    sn_ativo VARCHAR(200),
    dt_cadastro DATE,
    hr_cadastro TIME,
    CONSTRAINT pk_usuarios PRIMARY KEY (cd_usuario)
);

CREATE TABLE dbadeec.tipo_usuario (
    cd_tp_usuario INT,
    ds_tp_usuario VARCHAR(200),
    CONSTRAINT pk_tipo_usuario PRIMARY KEY (cd_tp_usuario)
);

CREATE TABLE dbadeec.demanda (
    cd_demanda INT,
    nm_demanda VARCHAR(200),
    ds_descricao VARCHAR(200),
    qt_horas DATE,
    qt_vagas INT,
    dt_inicio DATE,
    dt_fim DATE,
    sn_finalizada VARCHAR(2),
    dt_cadastro DATE,
    hr_cadastro TIME,
    dt_fim_inscricao DATE,
    cd_usuario INT,
    cd_imagem oid,
    cd_localizacao INT,
    CONSTRAINT pk_demanda PRIMARY KEY (cd_demanda)
);

CREATE TABLE dbadeec.inscricao_demanda (
    cd_demanda INT,
    cd_inscricao_demanda INT,
    cd_usuario INT,
    dt_cadastro DATE,
    hr_cadastro TIME,
    CONSTRAINT pk_inscricao_demanda PRIMARY KEY (cd_demanda, cd_inscricao_demanda),
    CONSTRAINT uk_inscricao_demanda_cd_inscricao UNIQUE (cd_inscricao_demanda),
    CONSTRAINT uk_inscricao_demanda_cd_usuario UNIQUE (cd_usuario),
    CONSTRAINT fk_inscricao_demanda_demanda
        FOREIGN KEY (cd_demanda)
        REFERENCES dbadeec.demanda (cd_demanda)
);


CREATE TABLE dbadeec.atividade (
    cd_demanda INT,
    cd_atividade INT,
    dt_cadastro DATE,
    hr_cadastro DATE,
    cd_usuario INT,
    dc_material_apoio oid,
    CONSTRAINT pk_atividade PRIMARY KEY (cd_atividade)
);

CREATE TABLE dbadeec.entrega_atividade (
    cd_atividade INT,
    cd_entrega_atividade INT,
    cd_demanda INT,
    cd_inscricao_demanda INT,
    hr_cadastro DATE,
    sn_entregue VARCHAR(1),
    dt_entegra DATE,
    hr_entegra DATE,
    sn_entrega_atraso VARCHAR(1),
    dc_entrega oid,
    CONSTRAINT pk_entrega_atividade PRIMARY KEY (cd_entrega_atividade),
    CONSTRAINT fk_entrega_atividade_cd_inscricao_demanda FOREIGN KEY (cd_demanda, cd_inscricao_demanda)
    REFERENCES dbadeec.inscricao_demanda (cd_demanda, cd_inscricao_demanda)
);


CREATE TABLE dbadeec.localizacao (
    cd_localizacao INT,
    ds_logradouro VARCHAR(200),
    nr_endereco VARCHAR(50),
    ds_complemento VARCHAR(200),
    ds_bairro VARCHAR(200),
    ds_cidade VARCHAR(200),
    ds_estado VARCHAR(200),
    ds_pais VARCHAR(200),
    ds_cep VARCHAR(20),
    CONSTRAINT pk_localizacao PRIMARY KEY (cd_localizacao)
);

CREATE TABLE dbadeec.certificado (
    cd_certificado INT,
    cd_demanda INT,
    cd_usuario INT,
    dt_geracao DATE,
    hr_geracao DATE,
    ds_certificado oid,
    CONSTRAINT pk_certificado PRIMARY KEY (cd_certificado)
);

CREATE TABLE dbadeec.certificado_modelo (
    cd_modelo INT,
    ds_documento oid,
    CONSTRAINT pk_certificado_modelo PRIMARY KEY (cd_modelo)
);

-- Add Foreign Key Constraints
ALTER TABLE dbadeec.usuarios ADD CONSTRAINT fk_usuarios_cd_tp_usuario FOREIGN KEY (cd_tp_usuario)
REFERENCES dbadeec.tipo_usuario (cd_tp_usuario);

ALTER TABLE dbadeec.demanda ADD CONSTRAINT fk_demanda_cd_usuario FOREIGN KEY (cd_usuario)
REFERENCES dbadeec.usuarios (cd_usuario);

ALTER TABLE dbadeec.inscricao_demanda ADD CONSTRAINT fk_inscricao_demanda_cd_usuario FOREIGN KEY (cd_usuario)
REFERENCES dbadeec.usuarios (cd_usuario);

ALTER TABLE dbadeec.atividade ADD CONSTRAINT fk_atividade_cd_demanda FOREIGN KEY (cd_demanda)
REFERENCES dbadeec.demanda (cd_demanda);

ALTER TABLE dbadeec.atividade ADD CONSTRAINT fk_atividade_cd_usuario FOREIGN KEY (cd_usuario)
REFERENCES dbadeec.usuarios (cd_usuario);

ALTER TABLE dbadeec.entrega_atividade ADD CONSTRAINT fk_entrega_atividade_cd_atividade FOREIGN KEY (cd_atividade)
REFERENCES dbadeec.atividade (cd_atividade);

ALTER TABLE dbadeec.demanda ADD CONSTRAINT fk_demanda_cd_localizacao FOREIGN KEY (cd_localizacao)
REFERENCES dbadeec.localizacao (cd_localizacao);

ALTER TABLE dbadeec.certificado ADD CONSTRAINT fk_certificado_cd_usuario FOREIGN KEY (cd_usuario)
REFERENCES dbadeec.usuarios (cd_usuario);


CREATE SEQUENCE seq_cd_usuario
    INCREMENT 1
    START 1
    MINVALUE 1
    CYCLE;
   
   
CREATE SEQUENCE seq_cd_demanda 
    INCREMENT 1
    START 1
    MINVALUE 1
    CYCLE;

CREATE SEQUENCE seq_cd_localizacao
    INCREMENT 1
    START 1
    MINVALUE 1
    CYCLE;
  
CREATE SEQUENCE seq_cd_inscricao_demanda
    INCREMENT 1
    START 1
    MINVALUE 1
    CYCLE;
