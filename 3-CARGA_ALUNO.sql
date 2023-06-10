CREATE OR REPLACE PROCEDURE CARGA_ALUNO(CAMINHO TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
	COMANDO TEXT;
	REGISTRO RECORD;
BEGIN
	
	COMANDO := 'CREATE TEMPORARY TABLE TEMP_ALUNOS (nr_cpf VARCHAR, nm_usuario VARCHAR, nr_ddd VARCHAR, nr_telefone VARCHAR, ds_email VARCHAR)';
	EXECUTE COMANDO;
	
	CAMINHO := 'COPY TEMP_ALUNOS FROM ''' || CAMINHO || ''' DELIMITER '',''	CSV HEADER';
	EXECUTE CAMINHO;

    FOR REGISTRO IN SELECT nr_cpf, nm_usuario, nr_ddd, nr_telefone, ds_email FROM TEMP_ALUNOS
    LOOP
        INSERT INTO dbadeec.usuarios VALUES(NEXTVAL('SEQ_CD_USUARIO'), REGISTRO.nm_usuario, REGISTRO.nr_cpf, REGISTRO.ds_email, REGISTRO.nr_ddd, REGISTRO.nr_telefone, 1, 'S', CURRENT_DATE, CURRENT_TIMESTAMP);
    END LOOP;
	
	COMANDO := 'DROP TABLE TEMP_ALUNOS';
	EXECUTE COMANDO;

END;
$$;
