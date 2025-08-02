# Analisi Dati di Spotify — Database Oracle

Progetto universitario per la creazione di una base dati relazionale a supporto dell’analisi di brani, album e artisti su Spotify.

## Obiettivi
- Progettare e normalizzare (fino alla 3NF) un database relazionale per dati Spotify.
- Popolare il DB a partire da dati raccolti via **Spotify for Developers** (API) e convertiti da JSON a XLSX/CSV.
- Definire vincoli, viste, query di analisi, **trigger** e **procedure PL/SQL**.
- Eseguire il tutto in **Oracle Live SQL** o Oracle XE 18c.

## Struttura del repository
```
.
├── README.md
├── schema.sql              # DDL: tabelle + vincoli di chiave esterna
├── inserts_sample.sql      # Esempi di INSERT (artisti, album, canzoni, canzonispec)
├── views.sql               # Viste utili per analisi
├── queries.sql             # 11 query di analisi (AVG, MAX, raggruppamenti, ecc.)
├── triggers.sql            # Trigger su variazione popolarità e formato nomi
├── procedure.sql           # Procedura di pulizia generi
└── indexes.sql             # Esempio di indice secondario
```

## Modello dati (sintesi)
- **ARTISTI**(id_artista PK, nome, popolarita, follower_totali, genere, genere_1)
- **ALBUM**(id_album PK, nome, popolarita, tracce_totali, artista_id FK→ARTISTI, data_rilascio)
- **CANZONI**(id_canzone PK, nome, artista_principale_id FK→ARTISTI, album_id FK→ALBUM, popolarita, artista2_nome, artista3_nome, artista4_nome)
- **CANZONISPEC**(id_canzonespec PK FK→CANZONI, danceability, energy, tonalita, loudness, modalita, speechiness, acousticness, instrumentalness, liveness, valence, tempo, durata_ms)

## Come eseguire
1. **Oracle**: usare [Oracle Live SQL] o Oracle XE 18c.
2. Eseguire `schema.sql`.
3. (Opzionale) Impostare il formato data per gli INSERT degli album:
   ```sql
   ALTER SESSION SET nls_date_format = 'dd-mm-yyyy';
   ```
4. Eseguire `inserts_sample.sql` (dataset di esempio).
5. Eseguire `views.sql`, `indexes.sql`, `triggers.sql`, `procedure.sql`.
6. Lanciare le analisi con `queries.sql`.

## Fonti principali
- Spotify for Developers (API)
- Oracle Live SQL
- Strumenti di conversione CSV↔SQL

> Nota: i file `inserts_sample.sql` includono un sottoinsieme di record a titolo dimostrativo.