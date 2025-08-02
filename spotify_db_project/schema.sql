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