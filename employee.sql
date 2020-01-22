CREATE SCHEMA CC2 

CREATE TABLE CC2.Department(
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(20),
    Location VARCHAR(20)
)

CREATE TABLE CC2.Employee(
    ID int PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(20),
    LastName VARCHAR(20),
    SSN VARCHAR(11), 
    DeptID INT FOREIGN KEY REFERENCES CC2.Department(ID) 
)


CREATE TABLE CC2.EmpDetails(
    ID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES CC2.Employee(ID),
    Salary MONEY,
    Address_1 VARCHAR(MAX),
    Address_2 VARCHAR(MAX),
    City VARCHAR(MAX), 
    State CHAR(2),
    Country VARCHAR(MAX)
)

GO;

INSERT INTO CC2.Department(Name,Location)VALUES('Marketing','New York')
INSERT INTO CC2.Department(Name,Location)VALUES('Finance','Washington DC')
INSERT INTO CC2.Department(Name,Location)VALUES('Accounting','Boston')

SELECT * FROM CC2.Department


INSERT INTO CC2.Employee(FirstName,LastName,SSN,DeptID)VALUES('Tina','Smith','123-45-6789',1)
INSERT INTO CC2.Employee(FirstName,LastName,SSN,DeptID)VALUES('Gulia','Alfa-Romero','987-65-4321',2)
INSERT INTO CC2.Employee(FirstName,LastName,SSN,DeptID)VALUES('Rachel','Roberts','122-45-6789',2)
INSERT INTO CC2.Employee(FirstName,LastName,SSN,DeptID)VALUES('Demitri','Petrikov','123-43-6789',1)
INSERT INTO CC2.Employee(FirstName,LastName,SSN,DeptID)VALUES('Private','Prevchenko','123-45-6229',3)

SELECT * FROM CC2.Employee

-- LIST ALL EMPLOYEES IN MARKETING 
SELECT FirstName, LastName, DeptID FROM CC2.Employee as E
    WHERE E.DeptID = 1

INSERT INTO CC2.EmpDetails(EmployeeID,Salary,Address_1,Address_2,City,[State],Country)VALUES('1',45000,'Nowhere','','New York','NY','USA')
INSERT INTO CC2.EmpDetails(EmployeeID,Salary,Address_1,Address_2,City,[State],Country)VALUES('4',40000,'1 Lane','Apt 20','New York','NY','USA')
INSERT INTO CC2.EmpDetails(EmployeeID,Salary,Address_1,Address_2,City,[State],Country)VALUES('3',70000,'3 Main St','','Washington DC','DC','USA')
INSERT INTO CC2.EmpDetails(EmployeeID,Salary,Address_1,Address_2,City,[State],Country)VALUES('2',20000,'232 Ave A','','Jersey City','NJ','USA')
-- TOTAL SALARY OF MARKETING 
SELECT SUM(Salary) AS Marketing_Total_Salary FROM CC2.EmpDetails AS D
    LEFT JOIN CC2.Employee AS E
    ON D.EmployeeID = E.ID
    WHERE E.DeptID = 1


--REPORT TOTAL EMPLOYEES BY DEPARTMENT 

SELECT D.Name AS Department , Count(*) AS Number_Employees FROM CC2.Employee AS E
    LEFT JOIN CC2.Department AS D 
    ON E.DeptID = D.ID
    GROUP BY D.Name
    

--INCREASE SALARY OF TINA SMITH TO 900000
UPDATE CC2.EmpDetails SET Salary = 90000 
WHERE EmployeeID = (SELECT ID FROM CC2.Employee WHERE FirstName = 'Tina' AND LastName = 'Smith')

SELECT * FROM CC2.EmpDetails 
WHERE EmployeeID = (SELECT ID FROM CC2.Employee WHERE FirstName = 'Tina' AND LastName = 'Smith')