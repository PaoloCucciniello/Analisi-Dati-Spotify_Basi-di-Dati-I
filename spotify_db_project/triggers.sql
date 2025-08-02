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