/*TO USE SCRIPT*/
/*psql -U postgres postgres -f create_db.sql*/

/* DELETE PREVIOUS INSTANCES OF THE DATABASE
AND ITS USERS */
DROP DATABASE acidentes_db;

DROP USER user_acidentes_db;
CREATE USER user_acidentes_db WITH PASSWORD 'user123';

/* CREATE DATABASE */
CREATE DATABASE acidentes_db;
\c acidentes_db

/* CREATE TABLE WITH RAW INFORMATION */
CREATE TABLE Acidentes(
    IdAcidente bigserial PRIMARY KEY,
    DataOcorrencia char(40),
    DataFecho char(40),
    Natureza char( 200 ),
    EstadoOcorrencia CHAR( 200 ),
    Distrito CHAR( 20 ),
    Concelho CHAR( 500 ),
    Freguesia CHAR( 500 ),
    Localidade CHAR( 500 ),
    Latitude double precision,
    Longitude double precision,
    NumMeiosTerrestres integer,
    NumOperacionaisTerrestres integer,
    NumMeiosAereos integer,
    NumOperacionaisAereos integer
);

GRANT ALL PRIVILEGES ON DATABASE acidentes_db TO user_acidentes;

/* COPY DATA FROM 1GB OF DATA CSV */
\copy Acidentes from 'dados.csv' DELIMITER '$' CSV HEADER;

-- PORSTGIS 
CREATE EXTENSION postgis;
SELECT AddGeometryColumn('acidentes', 'geom', 4326, 'POINT', 2); 
UPDATE acidentes SET geom = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326);