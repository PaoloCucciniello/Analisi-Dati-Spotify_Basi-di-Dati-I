-- ESEMPI DI POPOLAMENTO
-- Suggerito prima:
-- ALTER SESSION SET nls_date_format = 'dd-mm-yyyy';

-- ARTISTI
INSERT INTO artisti (id_artista, nome, popolarita, follower_totali, genere, genere_1) VALUES ('1vgQksyJ0IVz8y9XerEOy3','Madame',72,395768,'italian pop','trap italiana');
INSERT INTO artisti (id_artista, nome, popolarita, follower_totali, genere, genere_1) VALUES ('056KMTw6IztdQjBmFfVyO3','Rkomi',75,1013640,'italian hip hop',NULL);
INSERT INTO artisti (id_artista, nome, popolarita, follower_totali, genere, genere_1) VALUES ('0Y5tJX1MQlPlqiwlOH1tJY','Travis Scott',92,19630834,'rap','slap house');
INSERT INTO artisti (id_artista, nome, popolarita, follower_totali, genere, genere_1) VALUES ('6M2wZ9GZgrQXHCFfjv46we','Dua Lipa',93,31696410,'dance pop','pop');

-- ALBUM
INSERT INTO album (id_album, nome, popolarita, tracce_totali, artista_id, data_rilascio) VALUES ('7oF6ed3aSHU6aDD4MD3LIr','MADAME',71,18,'1vgQksyJ0IVz8y9XerEOy3','03-06-2021');
INSERT INTO album (id_album, nome, popolarita, tracce_totali, artista_id, data_rilascio) VALUES ('4D04TN7Kw7Bq98kfDjUmgh','TAXI DRIVER',77,15,'056KMTw6IztdQjBmFfVyO3','30-11-2021');
INSERT INTO album (id_album, nome, popolarita, tracce_totali, artista_id, data_rilascio) VALUES ('41GuZcammIkupMPKH2OJ6I','ASTROWORLD',89,17,'0Y5tJX1MQlPlqiwlOH1tJY','03-08-2018');
INSERT INTO album (id_album, nome, popolarita, tracce_totali, artista_id, data_rilascio) VALUES ('0JeyP8r2hBxYIoxXv11XiX','Future Nostalgia (The Moonlight Edition)',86,19,'6M2wZ9GZgrQXHCFfjv46we','11-02-2021');

-- CANZONI
INSERT INTO canzoni (nome, id_canzone, artista_principale_id, album_id, popolarita, artista2_nome, artista3_nome, artista4_nome)
VALUES ('VERGOGNA','1AUpTSTEDbZpTG62HrSRXC','1vgQksyJ0IVz8y9XerEOy3','7oF6ed3aSHU6aDD4MD3LIr',48,NULL,NULL,NULL);

INSERT INTO canzoni (nome, id_canzone, artista_principale_id, album_id, popolarita, artista2_nome, artista3_nome, artista4_nome)
VALUES ('the ends','33zbOXJSwW7uf4VXXWow2O','0Y5tJX1MQlPlqiwlOH1tJY','42WVQWuf1teDysXiOupIZt',63,NULL,NULL,NULL);

-- CANZONISPEC
INSERT INTO canzonispec (id_canzonespec, danceability, energy, tonalita, loudness, modalita, speechiness, acousticness, instrumentalness, liveness, valence, tempo, durata_ms)
VALUES ('1AUpTSTEDbZpTG62HrSRXC',0.591,0.677,6,-5.964,1,0.15,0.241,0,0.202,0.429,75.153,156471);