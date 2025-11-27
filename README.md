# Bokstugan – Databas för liten bokhandel  
*Inlämning 1 – Databaser (YH25)*  
Gabriel Gustafsson

Detta projekt innehåller SQL-koden för att skapa en databas åt en liten bokhandel.  
Databasen består av fyra tabeller med relationer mellan kunder, böcker, beställningar och orderrader.

## ER-diagram
<img src="images/er-diagram.png" alt="ER-diagram" width="400"/>

## Tabeller
- **Kunder** – information om kunder
- **Böcker** – boksortimentet (med ISBN, pris och lagerstatus)
- **Beställningar** – kundernas beställningar
- **Orderrader** – vilka böcker som ingår i varje beställning

## Funktioner som används
- Primärnycklar och AUTO_INCREMENT
- Främmande nycklar (FK) för att skapa relationer
- CHECK-regler på pris och lagerstatus
- INSERT för testdata
- INNER JOIN för att hämta data från flera tabeller


SQL-koden finns i [**Bokstugan.sql**](Bokstugan.sql).

