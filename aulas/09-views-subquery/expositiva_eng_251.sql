CREATE OR REPLACE VIEW v_duracao_media AS
	SELECT
		a.Nome_Autor AS nome,
		AVG(m.Duracao) AS duracao_media
	FROM MUSICA AS m
	INNER JOIN MUSICA_AUTOR AS ma USING(Codigo_Musica)
	INNER JOIN AUTOR AS a USING(Codigo_Autor)
	WHERE m.Nome_Musica LIKE '%a%'
	GROUP BY a.Codigo_Autor
	-- HAVING AVG(m.Duracao) BETWEEN 3.5 AND 3.8
	ORDER BY duracao_media DESC;
    
SELECT * FROM v_duracao_media;

SELECT
	t.nome,
    t.duracao_media
FROM
(	SELECT
		a.Nome_Autor AS nome,
		AVG(m.Duracao) AS duracao_media
	FROM MUSICA AS m
	INNER JOIN MUSICA_AUTOR AS ma USING(Codigo_Musica)
	INNER JOIN AUTOR AS a USING(Codigo_Autor)
	WHERE m.Nome_Musica LIKE '%a%'
	GROUP BY a.Codigo_Autor
	ORDER BY duracao_media DESC
) AS t
WHERE t.duracao_media BETWEEN 3.5 AND 3.8;
-- HAVING AVG(m.Duracao) BETWEEN 3.5 AND 3.8

SELECT * FROM v_duracao_media AS v
WHERE v.duracao_media BETWEEN 3.5 AND 3.8;

SELECT a.Nome_Autor, COUNT(*) qtde_musicas
FROM AUTOR a
INNER JOIN MUSICA_AUTOR ma USING(Codigo_Autor)
GROUP BY Codigo_Autor;

SELECT 
    a.Nome_Autor,
    (SELECT COUNT(*)
        FROM MUSICA_AUTOR ma
        WHERE ma.Codigo_Autor = a.Codigo_Autor
	) qtde_musicas
FROM  AUTOR a;