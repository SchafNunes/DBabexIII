
--Selects em cada tabela que o insert foi realizado.
SELECT * FROM usuarios u ;

SELECT * FROM demanda d ;

SELECT * FROM localizacao l ;

SELECT * FROM tipo_usuario tu ;

SELECT * FROM inscricao_demanda id ;


--Análise de todos os alunos que se inscreveram em uma demanda
SELECT 
	u.cd_usuario "Código do Usuário", 
	u.nm_usuario "Nome do Usuário", 
	d.cd_demanda "Codigo da Demanda", 
	d.nm_demanda "Nome da Demanda",
	(to_char(id.dt_cadastro, 'DD/MM/YYYY') || ' ' || TO_CHAR(id.hr_cadastro, 'HH24:MI')) "Data e Hora"
FROM inscricao_demanda id 
	JOIN demanda d 
		ON d.cd_demanda = id.cd_demanda 
	JOIN usuarios u 
		ON u.cd_usuario = id.cd_usuario
;

--Alguns indicadores utilizando subquerys
SELECT 
	SEM_INSCRICAO.TOTAL "Total de alunos não inscritos",
	COM_INSCRICAO.TOTAL "Total de alunos inscritos",
	round((SEM_INSCRICAO.TOTAL * 100.0 / TOTAL_DE_ALUNOS.TOTAL), 2) || '%' "Percentual de alunos não inscritos",
	round((COM_INSCRICAO.TOTAL * 100.0 / TOTAL_DE_ALUNOS.TOTAL), 2) || '%' "Percentual de alunos inscritos"
FROM (
	SELECT count(*) TOTAL FROM usuarios u 
	WHERE NOT EXISTS (
		SELECT 1 FROM inscricao_demanda id 
		WHERE cd_usuario = u.cd_usuario 
	) 
) SEM_INSCRICAO,
(
	SELECT count(*) TOTAL FROM usuarios u 
	WHERE EXISTS (
		SELECT 1 FROM inscricao_demanda id 
		WHERE cd_usuario = u.cd_usuario 
	)
) COM_INSCRICAO,
( 
	SELECT count(*) TOTAL FROM usuarios u2 
	WHERE cd_tp_usuario = 2
	AND sn_ativo = 'S'
) TOTAL_DE_ALUNOS
;


--Utilizando mais subquerys para extrair indicadores de percentual de inscrições
SELECT
	TOTAL_INSCRICAO_POR_DEMANDA.TOTAL "Total de inscrições", 
	D.NM_dEMANDA "Nome da demanda",
	(TOTAL_INSCRICAO_POR_DEMANDA.TOTAL * 100 / TOTAL_INSCRICAO_DEMANDA.TOTAL) || '%' "Percentual de inscrições por demanda"
FROM (
	SELECT count(*) AS TOTAL FROM usuarios u 
	WHERE EXISTS (
		SELECT 1 FROM inscricao_demanda id 
		WHERE cd_usuario = u.cd_usuario 
	) 
 ) TOTAL_INSCRICAO_DEMANDA,
(	
	SELECT 
		COUNT(CD_DEMANDA) AS TOTAL, 
		cd_demanda  
	FROM inscricao_demanda id 
	GROUP BY cd_demanda 
)  TOTAL_INSCRICAO_POR_DEMANDA
	LEFT JOIN demanda d ON d.cd_demanda = TOTAL_INSCRICAO_POR_DEMANDA.cd_demanda
;

--Analisando tabela demanda
SELECT * FROM demanda d;

--Ajustando usuário de criação das demandas
UPDATE demanda SET cd_usuario = 1;

--Demandas e suas respectivas localizações.
SELECT 
	d.nm_demanda "Nome da Demanda",
	qt_vagas "Quantidade de Vagas",
	'Logradouro: ' || l.ds_logradouro || ' Nº: ' || l.nr_endereco || ' Bairro: ' || l.ds_bairro   "Endreço",
	u.nm_usuario "Usuário que cadastrou"
FROM demanda d 
	JOIN usuarios u 
		ON u.cd_usuario = d.cd_usuario 
	JOIN tipo_usuario tu 
		ON tu.cd_tp_usuario = u.cd_tp_usuario 
	JOIN localizacao l 
		ON l.cd_localizacao = d.cd_localizacao
;


--Verificando quais usuários não se cadastraram em uma demanda
SELECT * FROM usuarios id 
WHERE NOT EXISTS (
	SELECT 1 FROM inscricao_demanda u 
	WHERE u.cd_usuario = id.cd_usuario 
);


--Deletando um usuário
DELETE FROM usuarios WHERE cd_usuario = 28;