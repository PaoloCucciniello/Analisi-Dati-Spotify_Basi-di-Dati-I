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