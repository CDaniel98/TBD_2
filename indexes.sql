--TO USE SCRIPT
--psql -U postgres postgres -f indexes.sql

\c acidentes_db;

/*
--BTREE*/
--CREATE INDEX idx_acidentes_meios_terrestres_btree ON Acidentes(NumMeiosTerrestres,NumMeiosAereos); --GOOD
--CREATE INDEX idx_acidentes_operacionais_terrestres_btree ON Acidentes USING btree(NumOperacionaisTerrestres); --NOT WORKING
--DROP INDEX idx_acidentes_meios_terrestres_btree;
--DROP INDEX idx_acidentes_operacionais_terrestres_btree;

--HASH
--CREATE INDEX idx_acidentes_id_hash ON Acidentes USING hash(IdAcidente); --MEH
--CREATE INDEX idx_acidentes_concelhos_hash ON Acidentes USING hash(Concelho); --GOOD
--DROP INDEX idx_acidentes_id_hash;
--DROP INDEX idx_acidentes_concelhos_hash;

--GIST
--CREATE INDEX idx_acidentes_natureza_gist ON Acidentes USING gist(Natureza); --NOT WORKING
--LATITUDE E LONGITUDE


--GIN
--CREATE INDEX idx_acidentes_meios_operacionais_terrestres_gin ON Acidentes USING gin(NumMeiosTerrestres,NumOperacionaisTerrestres); --NOT WORKING

--CREATE index idx_acidentes_natureza_gin ON Acidentes USING gin(Natureza);
--DROP INDEX index idx_acidentes_natureza_gin;

--BRIN
CREATE INDEX idx_acidentes_natureza_brin ON Acidentes USING brin(Natureza) WHERE IdAcidente > 100 and IdAcidente < 20000;
--DROP INDEX idx_acidentes_natureza_brin;
CREATE INDEX idx_acidentes_id_brin ON Acidentes USING brin(IdAcidente);
--DROP INDEX idx_acidentes_id_brin;
--DATA*/