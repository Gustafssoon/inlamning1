-- Gabriel Gustafsson - YH25
-- Inlämning 1 - Liten bokhandel (Bokstugan)

-- Skapa databasen och använd den
CREATE DATABASE Bokstugan2;
USE Bokstugan2;

-- Skapar tabell: Kunder
CREATE TABLE Kunder (
    KundID INT AUTO_INCREMENT PRIMARY KEY, 							-- PK, ökar automatiskt
    Namn VARCHAR(100) NOT NULL,
    Epost VARCHAR(100) UNIQUE NOT NULL, 
    Telefon VARCHAR(50) NOT NULL,
    Adress VARCHAR(255) NOT NULL
);

-- Skapar tabell: Böcker
CREATE TABLE Bocker (
	BokID INT AUTO_INCREMENT PRIMARY KEY, 							-- PK, ökar automatiskt
    ISBN VARCHAR(20) UNIQUE NOT NULL, 
    Titel VARCHAR(200) NOT NULL,
    Forfattare VARCHAR(100) NOT NULL,
    Pris DECIMAL(10,2) NOT NULL CHECK (Pris > 0), 					-- Pris måste vara större än 0
    Lagerstatus INT NOT NULL CHECK (Lagerstatus >= 0) 				-- Antal i lager, får ej vara negativ
);

-- Skapar tabell: Beställningar
CREATE TABLE Bestallningar (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,							-- PK, ökar automatiskt
    KundID INT NOT NULL,
    Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 						-- Datum när beställningen skapas
	Totalbelopp DECIMAL(10,2) NOT NULL CHECK (Totalbelopp >= 0), 	-- Summan av beställningen
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID) 					-- FK till kunder
);

-- Tabell: Orderrader
CREATE TABLE Orderrader (
    OrderradID INT AUTO_INCREMENT PRIMARY KEY,						-- PK, ökar automatiskt
    OrderID INT NOT NULL,
    BokID INT NOT NULL,
    Antal INT NOT NULL, 											-- Antal exemplar av boken
    Styckpris DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (OrderID) REFERENCES Bestallningar(OrderID), 		-- FK till beställningar
	FOREIGN KEY (BokID) REFERENCES Bocker(BokID) 					-- FK till böcker
);

-- Infogar testdata i tabellen Kunder
INSERT INTO Kunder (Namn, Epost, Telefon, Adress) VALUES
('Anna Andersson', 'anna@mail.com', '070-1111111', 'Storgatan 1, 111 11 Stockholm'),
('Bengt Bengtsson', 'bengt@mail.com', '070-2222222', 'Lillgatan 2, 222 22 Göteborg'),
('Carl Carlsson', 'carl@mail.com', '070-3333333', 'Norra vägen 3, 333 33 Malmö'),
('Didrik Didriksson', 'didrik@mail.com', '070-4444444', 'Södra vägen 4, 444 44 Kalmar');

-- Infogar testdata i tabellen Böcker
INSERT INTO Bocker (Titel, ISBN, Forfattare, Pris, Lagerstatus) VALUES
('Star Wars: Heir to the Empire', '9780553296129', 'Timothy Zahn', 129.00, 10),
('The Game', '9780470835847', 'Ken Dryden', 159.00, 5),
('Clean Code: A Handbook of Agile Software Craftsmanship', '9780132350884', 'Robert C. Martin', 499.00, 8),
('The Hobbit', '9780261102217', 'J.R.R. Tolkien', 199.00, 25);

-- Infogar testdata i tabellen Beställningar
-- Här kopplas Kunder till sin order.
INSERT INTO Bestallningar (KundID, Datum, Totalbelopp) VALUES
(1, '2024-03-01', 328.00),  -- Anna: Star Wars (129) + Hobbit (199)
(1, '2024-03-15', 398.00),  -- Anna: 2 x Hobbit
(2, '2024-03-05', 159.00),  -- Bengt: The Game
(3, '2024-03-10', 499.00),  -- Carl: Clean Code
(1, '2024-03-20', 499.00),  -- Anna: Clean Code
(4, '2024-03-22', 199.00);  -- Didrik: Hobbit

-- Infogar testdata i tabellen Orderrader
INSERT INTO Orderrader (OrderID, BokID, Antal, Styckpris) VALUES
(1, 1, 1, 129.00),  -- Order 1: 1 x Star Wars
(1, 4, 1, 199.00),  -- Order 1: 1 x Hobbit
(2, 4, 2, 199.00),  -- Order 2: 2 x Hobbit
(3, 2, 1, 159.00),  -- Order 3: 1 x The Game
(4, 3, 1, 499.00),  -- Order 4: 1 x Clean Code
(5, 3, 1, 499.00),  -- Order 5: 1 x Clean Code
(6, 4, 1, 199.00);  -- Order 6: 1 x Hobbit 


-- ========================== --
-- Testa så att allt fungerar --
-- ========================== --

-- Visa Kunder
SELECT * FROM Kunder;

-- Visa Böcker
SELECT * FROM Bocker;

-- Visar alla beställningar tillsammans med kundens namn
-- Använder INNER JOIN för att koppla ihop tabellen Beställningar med Kunder via KundID
-- På så sätt kan man se vilken kund som gjort vilken beställning.
SELECT
  Bestallningar.OrderID, 
  Kunder.Namn, 
  Bestallningar.Datum, 
  Bestallningar.Totalbelopp
FROM Bestallningar
  INNER JOIN Kunder 
  ON Bestallningar.KundID = Kunder.KundID;

-- Hämtar alla orderrader och visar vilken kund som har köpt vilken bok.
-- Använder INNER JOIN mellan tre tabeller:
-- Orderrader till Beställningar & Böcker via OrderID och BokID. Beställningar till Kunder via KundID
-- Detta gör att man kan visa titel, kundnamn, antal och styckpris för varje bok i varje beställning.
SELECT
  Orderrader.OrderID, 
  Kunder.Namn, 
  Bocker.Titel, 
  Orderrader.Antal, 
  Orderrader.Styckpris
FROM Orderrader
  INNER JOIN Bestallningar ON Orderrader.OrderID = Bestallningar.OrderID
  INNER JOIN Kunder ON Bestallningar.KundID = Kunder.KundID
  INNER JOIN Bocker ON Orderrader.BokID = Bocker.BokID;