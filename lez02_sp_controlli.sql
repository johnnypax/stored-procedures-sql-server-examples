-- DDL
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Salary DECIMAL(10, 2)				-- 123456769.11
);

-- DML
INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary) VALUES
(1, 'John', 'Doe', 50000),
(2, 'Jane', 'Smith', 60000),
(3, 'Emily', 'Jones', 70000);

/*
	TRY
		Operazione 1
		Operazione 2
	CATCH
		LOG Errore
*/

-- SP che abbia due parametri, uno ID Employee e l'altro per la modifica del nuovo salario
CREATE PROCEDURE UpdateEmployeeSalary
	@EmployeeID INT,
	@NewSalary DECIMAL(10,2)
AS
BEGIN
	BEGIN TRY
		-- Aggiorniamo lo stipendio (o proviamo)
		UPDATE Employees
		SET Salary = @NewSalary
		WHERE EmployeeID = @EmployeeID

		IF @@ROWCOUNT = 0
			THROW 50001, 'Employee not found', 1			-- THROW [error_number, message, state];
	END TRY
	BEGIN CATCH
		-- Gestione dell'errore
		PRINT 'Error: ' + ERROR_MESSAGE()
	END CATCH
END;

SELECT * FROM Employees; 

EXEC UpdateEmployeeSalary @EmployeeID = 1, @NewSalary = 70000.00;		-- TUTTO OK

EXEC UpdateEmployeeSalary @EmployeeID = 99, @NewSalary = 70000.00;		-- GENERA EXCEPTION