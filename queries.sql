/*TO USE SCRIPT*/
/*psql -U postgres postgres -f queries.sql*/

\c acidentes_db;
/*
--QUERY 1 - BTREE*/
--EXPLAIN ANALYZE SELECT * FROM Acidentes WHERE NumMeiosTerrestres > 1 AND NumMeiosTerrestres < 4 AND NumMeiosAereos > 1 AND NumMeiosAereos < 3;
--TIME S/ INDEX: 556.887 ms 288.556 ms 287.068 ms --> 377.503 ms
--TIME C/ INDEX: 35.210 ms 31.003 ms  32.647 ms --> 32.953 ms

--QUERY 2 - BTREE
--EXPLAIN ANALYZE SELECT * FROM Acidentes WHERE NumOperacionaisTerrestres < 3;
--TIME S/ INDEX: 741.408 ms 681.616 ms 678.604 ms --> 700.542 ms
--TIME C/ INDEX: 716.949 ms 722.102 ms 721.845 ms --> 720.298 ms

--QUERY 3 - HASH
--EXPLAIN ANALYZE SELECT * FROM Acidentes WHERE IdAcidente = 406700;
--TIME S/ INDEX: 0.285 ms 0.264 ms 0.268 ms --> 0.272 ms
--TIME C/ INDEX: 0.242 ms 0.308 ms 0.246 ms --> 0.265 ms

--QUERY 4 - HASH
--EXPLAIN ANALYZE SELECT * FROM Acidentes WHERE Concelho = 'covilha';
--TIME S/ INDEX: 524.505ms 536.916 ms 534.728 ms --> 532.049 ms
--TIME C/ INDEX: 0.152 ms  0.121 ms 0.156 ms --> 0.143 ms

--QUERY 4 - GIST
--EXPLAIN ANALYZE (SELECT Natureza,COUNT(Natureza) AS Qtd FROM Acidentes Group By Natureza ORDER BY COUNT(Natureza) DESC) LIMIT 1;
--TIME S/ INDEX: 446.785 ms 455.563 ms 426.568 ms --> 442.972 ms
--TIME C/ INDEX: ERRO indexes.sql

--QUERY 5 - GIST
--LATITUDE E LONGITUDE
--TIME S/ INDEX: 
--TIME C/ INDEX:

--QUERY 6 - GIN
--EXPLAIN ANALYZE SELECT COUNT(NumMeiosTerrestres), COUNT(NumOperacionaisTerrestres) FROM Acidentes WHERE NumMeiosTerrestres > 3 and NumOperacionaisTerrestres > 3;
--TIME S/ INDEX: 272.184 ms 219.932 ms 252.123 ms --> 248.239 ms
--TIME C/ INDEX: ERRO indexes.sql

--QUERY 7 - GIN
--EXPLAIN ANALYZE SELECT Natureza FROM Acidentes WHERE Natureza like 'Riscos Mistos';
--TIME S/ INDEX: 260.662 ms 273.208 ms 262.427 ms --> 265.432 ms
--TIME C/ INDEX: ERRO indexes.sql

--QUERY 8 - BRIN
EXPLAIN ANALYZE SELECT Natureza FROM Acidentes WHERE IdAcidente > 100 and IdAcidente < 20000;
--TIME S/ INDEX: 25.001 ms 21.279 ms 47.263 ms --> 31.181 ms
--TIME C/ INDEX: 21.672 ms 51.282 ms 39.620 ms

-- TIME S/INDEX (SEM NENHUM INDEX): 7.313 ms 28.987 ms 7.935 ms --> C/INDEX fica igual

--QUERY 9 - BRIN
EXPLAIN ANALYZE SELECT IdAcidente FROM Acidentes WHERE NumOperacionaisTerrestres < 2;
--TIME S/ INDEX: 232.285 ms 247.122 ms 223.516 ms
--TIME C/ INDEX: 224.931 ms 248.032 ms 249.335 ms

-- TIME S/INDEX (SEM NENHUM INDEX): 694.643 ms 686.228 ms 676.225 ms --> C/INDEX fica igual
/*
--QUERY 10 - BRIN
--DATA - TODO: meter a data em timestamp
--TIME S/ INDEX: 
--TIME C/ INDEX:
*/