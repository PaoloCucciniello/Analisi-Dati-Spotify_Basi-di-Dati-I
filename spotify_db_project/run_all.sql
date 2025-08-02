-- RUN ALL — Script auto-contenuto per Oracle

ALTER SESSION SET nls_date_format = 'dd-mm-yyyy';
/


-- 1) SCHEMA

-- SCHEMA: Tabelle e vincoli

CREATE TABLE artisti (
  id_artista      VARCHAR2(50),
  nome            VARCHAR2(50),
  popolarita      INTEGER CHECK (popolarita >= 0 AND popolarita <= 100),
  follower_totali INTEGER,
  genere          VARCHAR2(50),
  genere_1        VARCHAR2(50),
  CONSTRAINT pk_artisti PRIMARY KEY (id_artista)
);

CREATE TABLE album (
  id_album       VARCHAR2(50),
  nome           VARCHAR2(50),
  popolarita     INTEGER CHECK (popolarita >= 0 AND popolarita <= 100),
  tracce_totali  INTEGER,
  artista_id     VARCHAR2(50),
  data_rilascio  DATE,
  CONSTRAINT pk_album PRIMARY KEY (id_album)
);

CREATE TABLE canzoni (
  id_canzone             VARCHAR2(50),
  nome                   VARCHAR2(50),
  artista_principale_id  VARCHAR2(50),
  album_id               VARCHAR2(50),
  popolarita             INTEGER CHECK (popolarita >= 0 AND popolarita < 100),
  artista2_nome          VARCHAR2(50),
  artista3_nome          VARCHAR2(50),
  artista4_nome          VARCHAR2(50),
  CONSTRAINT pk_canzoni PRIMARY KEY (id_canzone)
);

CREATE TABLE canzonispec (
  id_canzonespec   VARCHAR2(50),
  danceability     FLOAT CHECK (danceability >= 0.0 AND danceability <= 1.0),
  energy           FLOAT CHECK (energy >= 0.0 AND energy <= 1.0),
  tonalita         INTEGER,
  loudness         FLOAT,
  modalita         INTEGER CHECK (modalita IN (0,1)),
  speechiness      FLOAT,
  acousticness     FLOAT CHECK (acousticness >= 0.0 AND acousticness <= 1.0),
  instrumentalness FLOAT CHECK (instrumentalness <= 1.0),
  liveness         FLOAT CHECK (liveness <= 1.0),
  valence          FLOAT CHECK (valence >= 0.0 AND valence <= 1.0),
  tempo            FLOAT,
  durata_ms        INTEGER,
  CONSTRAINT pk_canzonispec PRIMARY KEY (id_canzonespec)
);

-- Vincoli di chiave esterna
ALTER TABLE album
  ADD CONSTRAINT fk_album_artisti
  FOREIGN KEY (artista_id) REFERENCES artisti(id_artista);

ALTER TABLE canzoni
  ADD CONSTRAINT fk_canzoni_album
  FOREIGN KEY (album_id) REFERENCES album(id_album);

ALTER TABLE canzoni
  ADD CONSTRAINT fk_canzoni_artisti
  FOREIGN KEY (artista_principale_id) REFERENCES artisti(id_artista);

ALTER TABLE canzonispec
  ADD CONSTRAINT fk_canzonispec_canzoni
  FOREIGN KEY (id_canzonespec) REFERENCES canzoni(id_canzone);

/


-- 2) (Opzionale) Impostazione formato data per gli INSERT


-- 3) INSERTS DI ESEMPIO

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

/


-- 4) VISTE

-- Viste utili

CREATE VIEW numerocanzoni_artisti AS
SELECT COUNT(c.id_canzone) AS numero_canzoni, a.nome
FROM canzoni c
JOIN artisti a ON a.id_artista = c.artista_principale_id
GROUP BY a.nome;

/


-- 5) INDICI

-- Indice secondario sul nome degli artisti
CREATE INDEX indice_nomi_artisti ON artisti (nome);

/


-- 6) TRIGGER

-- Trigger

-- Mostrare variazioni di popolarità su ARTISTI
CREATE OR REPLACE TRIGGER display_popolarita_changes_artisti
AFTER UPDATE OF popolarita ON artisti
FOR EACH ROW
DECLARE
  differenza_popolarita NUMBER;
BEGIN
  differenza_popolarita := :NEW.popolarita - :OLD.popolarita;
  IF (differenza_popolarita >= 0) THEN
    dbms_output.put_line('La popolarità è salita di ' || differenza_popolarita);
  ELSE
    dbms_output.put_line('La popolarità è scesa di ' || (differenza_popolarita * -1));
  END IF;
  dbms_output.put_line('Vecchia popolarità: ' || :OLD.popolarita);
  dbms_output.put_line('Nuova popolarità: ' || :NEW.popolarita);
END;
/

-- Mostrare variazioni di popolarità su ALBUM
CREATE OR REPLACE TRIGGER display_popolarita_changes_album
AFTER UPDATE OF popolarita ON album
FOR EACH ROW
DECLARE
  differenza_popolarita NUMBER;
BEGIN
  differenza_popolarita := :NEW.popolarita - :OLD.popolarita;
  IF (differenza_popolarita >= 0) THEN
    dbms_output.put_line('La popolarità è salita di ' || differenza_popolarita);
  ELSE
    dbms_output.put_line('La popolarità è scesa di ' || (differenza_popolarita * -1));
  END IF;
  dbms_output.put_line('Vecchia popolarità: ' || :OLD.popolarita);
  dbms_output.put_line('Nuova popolarità: ' || :NEW.popolarita);
END;
/
-- Mostrare variazioni di popolarità su CANZONI
CREATE OR REPLACE TRIGGER display_popolarita_changes_canzoni
AFTER UPDATE OF popolarita ON canzoni
FOR EACH ROW
DECLARE
  differenza_popolarita NUMBER;
BEGIN
  differenza_popolarita := :NEW.popolarita - :OLD.popolarita;
  IF (differenza_popolarita >= 0) THEN
    dbms_output.put_line('La popolarità è salita di ' || differenza_popolarita);
  ELSE
    dbms_output.put_line('La popolarità è scesa di ' || (differenza_popolarita * -1));
  END IF;
  dbms_output.put_line('Vecchia popolarità: ' || :OLD.popolarita);
  dbms_output.put_line('Nuova popolarità: ' || :NEW.popolarita);
END;
/
-- Abilitazione trigger (opzionale)
ALTER TRIGGER display_popolarita_changes_artisti ENABLE;
ALTER TRIGGER display_popolarita_changes_album ENABLE;
ALTER TRIGGER display_popolarita_changes_canzoni ENABLE;

-- Formattazione nomi in MAIUSCOLO
CREATE OR REPLACE TRIGGER maiuscolo_nomi_artisti
BEFORE INSERT ON artisti
FOR EACH ROW
BEGIN
  :NEW.nome := UPPER(:NEW.nome);
END;
/
CREATE OR REPLACE TRIGGER maiuscolo_nomi_album
BEFORE INSERT ON album
FOR EACH ROW
BEGIN
  :NEW.nome := UPPER(:NEW.nome);
END;
/
CREATE OR REPLACE TRIGGER maiuscolo_nomi_canzoni
BEFORE INSERT ON canzoni
FOR EACH ROW
BEGIN
  :NEW.nome := UPPER(:NEW.nome);
END;
/

-- 7) PROCEDURA

-- Procedura: eliminazione_generi_artisti
-- Imposta a NULL il campo 'genere' per le tuple che corrispondono al genere passato.

CREATE OR REPLACE PROCEDURE eliminazione_generi_artisti (genere_in IN artisti.genere%TYPE)
AS
  numero_generi_cancellati INTEGER;
BEGIN
  SELECT COUNT(*) INTO numero_generi_cancellati FROM artisti WHERE genere = genere_in;
  UPDATE artisti SET genere = NULL WHERE genere = genere_in;
  COMMIT;
  dbms_output.put_line('Impostato il valore NULL su ' || numero_generi_cancellati || ' record di artisti.');
END eliminazione_generi_artisti;
/
-- Esempio esecuzione:
-- EXEC eliminazione_generi_artisti('indie rock italiano');

/
