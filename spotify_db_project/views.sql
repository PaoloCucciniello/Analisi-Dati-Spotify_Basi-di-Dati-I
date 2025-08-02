-- Viste utili

CREATE VIEW numerocanzoni_artisti AS
SELECT COUNT(c.id_canzone) AS numero_canzoni, a.nome
FROM canzoni c
JOIN artisti a ON a.id_artista = c.artista_principale_id
GROUP BY a.nome;