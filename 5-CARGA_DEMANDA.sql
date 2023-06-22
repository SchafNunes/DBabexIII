CREATE OR REPLACE PROCEDURE dbadeec.CARGA_DEMANDA(   
    pnm_demanda VARCHAR(200),
    pds_descricao VARCHAR(200),
    pqt_horas DATE,
    pqt_vagas INT,
    pdt_inicio DATE,
    pdt_fim DATE,
    psn_finalizada VARCHAR(2),
    pdt_cadastro DATE,
    phr_cadastro TIME,
    pdt_fim_inscricao DATE,
    pcd_usuario INT,
    pcd_imagem INT,
    pcd_localizacao INT,
    pcd_certificado INT
)
LANGUAGE plpgsql
AS $$
BEGIN 
    INSERT INTO dbadeec.demanda (
        cd_demanda,
        nm_demanda,
        ds_descricao,
        qt_horas,
        qt_vagas,
        dt_inicio,
        dt_fim,
        sn_finalizada,
        dt_cadastro,
        hr_cadastro,
        dt_fim_inscricao,
        cd_usuario,
        cd_imagem,
        cd_localizacao
    ) VALUES (
        NEXTVAL('seq_cd_demanda'),
        pnm_demanda,
        pds_descricao,
        pqt_horas,
        pqt_vagas,
        pdt_inicio,
        pdt_fim,
        psn_finalizada,
        pdt_cadastro,
        phr_cadastro,
        pdt_fim_inscricao,
        pcd_usuario,
        pcd_imagem,
        pcd_localizacao
    );
END $$;
