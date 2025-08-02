-- Query di analisi

-- 1) Artisti con popolarità >= 90
SELECT nome, follower_totali, popolarita
FROM artisti
WHERE popolarita >= 90
ORDER BY popolarita DESC;

-- 2) Numero di brani per artista (usa la vista)
SELECT numero_canzoni, nome FROM numerocanzoni_artisti;

-- 3) Artisti che non hanno canzoni con popolarità < 50
SELECT a.nome
FROM canzoni c JOIN artisti a ON c.artista_principale_id = a.id_artista
WHERE c.id_canzone NOT IN (
  SELECT id_canzone FROM canzoni WHERE popolarita < 50
);

-- 4) Media delle specifiche per canzone (nome,popolarità)
SELECT AVG(danceability), AVG(energy), AVG(loudness), AVG(speechiness),
       AVG(acousticness), AVG(instrumentalness), AVG(liveness), AVG(valence),
       c.popolarita AS canzone_popolarita, c.nome AS canzone_nome
FROM canzonispec cs JOIN canzoni c ON c.id_canzone = cs.id_canzonespec
GROUP BY c.popolarita, c.nome
ORDER BY c.popolarita DESC;

-- 5) Massimi delle specifiche per canzoni con popolarità > 90
SELECT MAX(danceability), MAX(energy), MAX(loudness), MAX(speechiness),
       MAX(acousticness), MAX(instrumentalness), MAX(liveness), MAX(valence)
FROM canzonispec cs JOIN canzoni c ON c.id_canzone = cs.id_canzonespec
WHERE c.popolarita > 90;

-- 6) Artista con più brani
SELECT nome
FROM numerocanzoni_artisti
WHERE numero_canzoni >= ALL (SELECT numero_canzoni FROM numerocanzoni_artisti);

-- 7) Durata media brani per artisti con popolarità >90 e <60
SELECT AVG(cs.durata_ms) AS durata_media, a.popolarita
FROM (canzonispec cs JOIN canzoni c ON c.id_canzone = cs.id_canzonespec)
JOIN artisti a ON c.artista_principale_id = a.id_artista
GROUP BY a.popolarita
HAVING a.popolarita > 90
UNION
SELECT AVG(cs.durata_ms) AS durata_media, a.popolarita
FROM (canzonispec cs JOIN canzoni c ON c.id_canzone = cs.id_canzonespec)
JOIN artisti a ON c.artista_principale_id = a.id_artista
GROUP BY a.popolarita
HAVING a.popolarita < 60;

-- 8) Album con più canzoni
SELECT nome
FROM album
WHERE tracce_totali >= ALL (SELECT tracce_totali FROM album);

-- 9) Numero di tracce totali pubblicate per anno
SELECT SUM(tracce_totali) AS numero_canzoni, EXTRACT(YEAR FROM data_rilascio) AS anno_uscita
FROM album
GROUP BY EXTRACT(YEAR FROM data_rilascio);

-- 10) Anno/i di pubblicazione della canzone più popolare e meno popolare
SELECT EXTRACT(YEAR FROM al.data_rilascio) AS anno_uscita, c.nome
FROM album al JOIN canzoni c ON c.album_id = al.id_album
WHERE c.popolarita >= ALL (SELECT popolarita FROM canzoni)
UNION
SELECT EXTRACT(YEAR FROM al.data_rilascio) AS anno_uscita, c.nome
FROM album al JOIN canzoni c ON c.album_id = al.id_album
WHERE c.popolarita <= ALL (SELECT popolarita FROM canzoni);

-- 11) Popolarità media per genere
SELECT AVG(popolarita) AS popolarita_media, genere
FROM artisti
GROUP BY genere;