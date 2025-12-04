# :books: Bokstugan – Databas för en liten bokhandel  
*Inlämning 1 – Databaser (YH25)*  
Gabriel Gustafsson

## 🟥 Syfte
Syftet med databasen är att modellera en liten bokhandel som ska kunna hantera sina kunder, böcker och beställningar på ett strukturerat och effektivt sätt.

Databasen gör det möjligt att:
- registrera kunder och deras kontaktuppgifter  
- lagra butikens sortiment av böcker  
- hantera kundbeställningar och koppla dem till rätt kund  
- se vilka böcker som ingår i varje beställning  
- summera information, till exempel hur många beställningar en kund gjort eller vilka böcker som säljer bäst

---

## 🟨 ER-diagram  
Databasens struktur illustreras i följande ER-diagram:

![ER-diagram](images/er-diagram.png)

**Relationerna i modellen:**
- **En kund kan finnas utan beställningar**, men en beställning måste alltid kopplas till **exakt en kund**.  
- **En beställning måste innehålla minst en orderrad**, och varje orderrad tillhör **exakt en beställning**.  
- **En bok kan finnas i ingen, en eller flera orderrader**, men varje orderrad refererar till **exakt en bok**.

---

## 🟩 Tabeller
- **Kunder** – information om kunder (namn, e-post, telefon, adress)
- **Böcker** – boksortimentet (titel, ISBN, pris och lagerstatus)
- **Beställningar** – kundernas beställningar (datum, totalbelopp, kopplad kund)
- **Orderrader** – vilka böcker som ingår i varje beställning (antal och pris per bok)

---

## 🟦 Funktioner som används
- **Primärnycklar (PK)** och `AUTO_INCREMENT`
- **Främmande nycklar (FK)** – för att skapa relationer mellan tabeller
- `UNIQUE` och `NOT NULL` – för att kräva unika och obligatoriska värden (t.ex. e-post, ISBN)
- `CHECK` – regler på pris och lagerstatus
- `DEFAULT CURRENT_TIMESTAMP` – för att automatiskt sätta datum
- `INSERT` – för att lägga in testdata
- `SELECT` – för att hämta data
- `INNER JOIN` – för att kombinera data från flera tabeller
- `GROUP BY` och `HAVING` – för att sammanställa och filtrera aggregerad data

---

## 🟪 Lärdomar
En viktig lärdom i projektet var att välja rätt datatyp för ISBN.  
Först testade jag att använda `INT`, men det fungerade inte eftersom ett ISBN-13 är för långt för att lagras i en vanlig `INT`. Därefter provade jag `VARCHAR`, som klarar längden men samtidigt tillåter bokstäver och andra tecken, vilket inte är önskvärt när man vill lagra ISBN i ett strikt numeriskt format. Om man vill använda bindestreck (`-`) för bättre läsbarhet fungerar `VARCHAR` bra, men i databasen behövs bara rena siffror.  
Till slut valde jag `BIGINT`, som kan lagra 13-siffriga värden korrekt och endast accepterar numeriska data. Det blev den mest passande och korrekta lösningen för ISBN i databasen.

En annan insikt jag fick under projektets gång handlade om hur relationerna mellan tabeller faktiskt fungerar i ett ER-diagram.  
Till en början tänkte jag att en kund borde ha minst en beställning, eftersom alla kunder i min testdata gjorde det. Men när jag började fundera mer insåg jag att datamodellen måste spegla verkligheten, inte bara den testdata jag råkade skapa. En kund kan ju mycket väl finnas i systemet innan den har gjort sin första beställning.

Det gjorde mig också mer medveten om hur databasen tolkar relationen: i tabellen *Beställningar* finns en FOREIGN KEY som kräver att varje beställning måste kopplas till en kund, men i tabellen *Kunder* finns inget som kräver att kunden måste ha en beställning. Därför är det helt rimligt att en kund kan ha noll eller flera beställningar, även om det inte syntes direkt i min testdata.

---

SQL-koden finns i [**inlamning1.sql**](inlamning1.sql).




