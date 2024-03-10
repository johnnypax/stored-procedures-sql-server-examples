-- DDL
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Quantity INT
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- DML
INSERT INTO Products (ProductID, ProductName, Quantity) VALUES
(1, 'Tavolo', 10),
(2, 'Sedia', 20),
(3, 'Lampada', 30);

-- QL
SELECT * FROM Products;

-- SP con TRANSAZIONE
CREATE PROCEDURE ProcessOrder
	@OrderID INT,
	@ProductID INT,
	@Quantity INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			-- Aggiorno l'inventario di prodotti
			UPDATE Products
			SET Quantity = Quantity - @Quantity
			WHERE ProductID = @ProductID AND Quantity >= @Quantity

			IF @@ROWCOUNT = 0
				THROW 50001, 'Not enough stock quantity', 1

			-- Inserisci l'ordine poiché la quantità è sufficiente e il ProductID è stato trovato
			INSERT INTO OrderDetails(OrderID, ProductID, Quantity)
			VALUES (@OrderID, @ProductID, @Quantity)

			-- Se tutto va a buon  fine, conferma la transazione
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;

		PRINT 'Error: ' + ERROR_MESSAGE()
	END CATCH
END;

EXEC ProcessOrder @OrderID = 1, @ProductID = 2, @Quantity = 5;		-- OK

SELECT * FROM Products;
SELECT * FROM OrderDetails;

EXEC ProcessOrder @OrderID = 2, @ProductID = 1, @Quantity = 100;