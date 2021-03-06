USE master
IF EXISTS (SELECT * FROM sys.databases WHERE Name LIKE 'SellingPoint')
	DROP DATABASE SellingPoint
GO
CREATE DATABASE SellingPoint
GO
USE SellingPoint

-------------------------------------------

CREATE TABLE Categories (
	CateID char(6) CONSTRAINT PK_cateid PRIMARY KEY (CateID),
	CateName nvarchar(100) NOT NULL,
	Description nvarchar(200)
)

CREATE TABLE Parts (
	PartID int IDENTITY CONSTRAINT PK_partid PRIMARY KEY (PartID),
	PartName nvarchar(100) NOT NULL,
	CateID char(6) CONSTRAINT FK_cateid FOREIGN KEY (CateID) REFERENCES Categories(CateID),
	Description nvarchar(1000),
	Price money NOT NULL DEFAULT (0),
	Quantity int DEFAULT (0),
	Warranty int DEFAULT (1),
	Photo nvarchar(200) DEFAULT ('photo/nophoto.png')
)
GO

-------------------------------------------

INSERT INTO Categories VALUES
	('CPU','CPU','Computer`s CPU'),
	('RAM','RAM','Computer`s RAM'),
	('HDD','HDD','Computer`s HDD')

INSERT INTO Parts VALUES
	('HDD 100GB','HDD',N'HDD có 100GB',500,50,1,default),
	('RAM 2GB','RAM',N'RAM có 2GB',900,50,1,default),
	('God CPU','CPU',N'God`s CPU',9999999,1,9999,default)
GO

-------------------------------------------

SELECT * FROM Parts WHERE Price > 100

SELECT * FROM Parts JOIN Categories on Categories.CateID = Parts.CateID WHERE CateName LIKE 'CPU'
GO

-------------------------------------------

CREATE VIEW V_Parts AS
SELECT PartID, PartName, Price, Quantity FROM Categories JOIN Parts on Categories.CateID = Parts.CateID
GO

-------------------------------------------

CREATE VIEW V_TopParts AS
SELECT TOP 5 * FROM Parts ORDER BY Price DESC
GO

-------------------------------------------