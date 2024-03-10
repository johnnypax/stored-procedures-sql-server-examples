-- DDL

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    JobTitle NVARCHAR(50),
    Department NVARCHAR(50),
    StartDate DATE				-- 'YYYY-MM-DD'
);

-- DML
INSERT INTO Employees (FirstName, LastName, Email, JobTitle, Department, StartDate) VALUES 
('James', 'Smith', 'james.smith@example.com', 'Software Engineer', 'Engineering', '2019-03-01'),
('Maria', 'Garcia', 'maria.garcia@example.com', 'Project Manager', 'Marketing', '2018-06-15'),
('Robert', 'Johnson', 'robert.johnson@example.com', 'Database Administrator', 'IT', '2017-05-29'),
('Patricia', 'Miller', 'patricia.miller@example.com', 'Product Manager', 'Sales', '2020-02-17'),
('Michael', 'Davis', 'michael.davis@example.com', 'Web Developer', 'Engineering', '2021-08-23'),
('Linda', 'Martinez', 'linda.martinez@example.com', 'Graphic Designer', 'Design', '2016-04-11'),
('Elizabeth', 'Hernandez', 'elizabeth.hernandez@example.com', 'Sales Associate', 'Sales', '2019-07-19'),
('William', 'Brown', 'william.brown@example.com', 'Systems Analyst', 'IT', '2018-09-03'),
('Jennifer', 'Wilson', 'jennifer.wilson@example.com', 'Consultant', 'Customer Service', '2017-12-08'),
('David', 'Anderson', 'david.anderson@example.com', 'Quality Assurance', 'Engineering', '2020-05-01'),
('Susan', 'Thomas', 'susan.thomas@example.com', 'HR Specialist', 'Human Resources', '2018-03-23'),
('Joseph', 'Moore', 'joseph.moore@example.com', 'Finance Analyst', 'Finance', '2019-11-30'),
('Margaret', 'Taylor', 'margaret.taylor@example.com', 'Content Writer', 'Marketing', '2021-01-15'),
('Charles', 'Lee', 'charles.lee@example.com', 'UX Designer', 'Design', '2017-07-09'),
('Christopher', 'Harris', 'christopher.harris@example.com', 'Network Engineer', 'IT', '2018-08-21'),
('Jessica', 'Clark', 'jessica.clark@example.com', 'Social Media Manager', 'Marketing', '2020-06-05'),
('Daniel', 'Lewis', 'daniel.lewis@example.com', 'Business Analyst', 'Business Development', '2019-04-12'),
('Sarah', 'Walker', 'sarah.walker@example.com', 'Recruiter', 'Human Resources', '2021-09-20'),
('Thomas', 'Robinson', 'thomas.robinson@example.com', 'Technical Support', 'Customer Service', '2017-11-13'),
('Nancy', 'Rodriguez', 'nancy.rodriguez@example.com', 'Legal Advisor', 'Legal', '2018-01-29');

-- QL
SELECT * FROM Employees;

-- SP - CREATION
CREATE PROCEDURE GetAllEmployees		-- DEFINIRE IL NOME DELLA PROCEDURE
AS										-- DEFINISCE IL CORPO
BEGIN
	-- CORPO EFFETTIVO (OPERAZIONI)
	SELECT * FROM Employees
END;

-- INVOCAZIONE SP
EXEC GetAllEmployees;

-- ELIMINAZIONE DI UNA SP
DROP PROCEDURE if exists GetAllEmployees;

-- MODIFICA DI UNA SP
-- 1. Visualizza la SP esistente
EXEC sp_helptext 'GetAllEmployees';

-- 2. Ricomponiamo la procedure ed utilizziamo ALTER
ALTER PROCEDURE GetAllEmployees  -- DEFINIRE IL NOME DELLA PROCEDURE  
AS          -- DEFINISCE IL CORPO  
BEGIN  
 -- CORPO EFFETTIVO (OPERAZIONI)  
  SELECT * FROM Employees WHERE Department = 'Legal'
END;

EXEC GetAllEmployees;



-- SP Con parametro
CREATE PROCEDURE GetEmployeesByJobTitle
	@Job NVARCHAR(50)
AS
BEGIN
	SELECT * FROM Employees WHERE JobTitle = @Job
END;

EXEC GetEmployeesByJobTitle @Job = 'Graphic Designer';

-- SP CON PARAMETRO OPZIONALE
CREATE PROCEDURE GetEmployeesByDepartment
	@JobTitle NVARCHAR(50) = NULL				-- Default valorizzato a NULL
AS
BEGIN
	IF @JobTitle IS NULL
		BEGIN
			SELECT * FROM Employees
		END
	ELSE
		BEGIN
			SELECT * FROM Employees WHERE Department = @JobTitle
		END
END;

EXEC GetEmployeesByDepartment;
EXEC GetEmployeesByDepartment @JobTitle = 'Sales';