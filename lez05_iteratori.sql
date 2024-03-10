-- DDL
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- DML
INSERT INTO Employees(FirstName, LastName, Salary) VALUES
('Giovanni', 'Pace', 100000),
('Valeria', 'Verdi', 120000),
('Mario', 'Rossi', 90000);

SELECT * FROM Employees;

-- SP Stampa dettagli degli impiegati
CREATE PROCEDURE PrintEmployeesDetails
AS
BEGIN
	DECLARE @FirstLastName NVARCHAR(101), @Salary DECIMAL(10, 2);

	-- Definiamo il cursore
	DECLARE EmployeeCursor CURSOR FOR
	SELECT FirstName + ' ' + LastName, Salary FROM Employees;

	-- Apertura del cursore
	OPEN EmployeeCursor;

	-- Recupero la prima riga
	FETCH NEXT FROM EmployeeCursor INTO @FirstLastName, @Salary;

	-- Iterazione attraverso le righe
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'Detail of the employee: ' + @FirstLastName + ' slary value: ' + CAST(@Salary AS VARCHAR(13));

		FETCH NEXT FROM EmployeeCursor INTO @FirstLastName, @Salary;
	END

	-- Chiusura del cursore
	CLOSE EmployeeCursor;
	-- Deallocazione della memoria occupata dal cursore
	DEALLOCATE EmployeeCursor;
END;

EXEC PrintEmployeesDetails;