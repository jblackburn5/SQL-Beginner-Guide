--SQL Reference Guide

---/// BEGINNER///--

--All of this data was derived from ALEX The Analyst YouTube channel with full permission. 
--These are the tables that we will be using for the rest of our queries and I have alreeady run them. 

--Table 1 Query:
--Create Table EmployeeDemographics 
--(EmployeeID int, 
--FirstName varchar(50), 
--LastName varchar(50), 
--Age int, 
--Gender varchar(50)
--)

--Table 2 Query:
--Create Table EmployeeSalary 
--(EmployeeID int, 
--JobTitle varchar(50), 
--Salary int
--)



--Table 1 Insert:
--Insert into EmployeeDemographics VALUES
--(1001, 'Jim', 'Halpert', 30, 'Male'),
--(1002, 'Pam', 'Beasley', 30, 'Female'),
--(1003, 'Dwight', 'Schrute', 29, 'Male'),
--(1004, 'Angela', 'Martin', 31, 'Female'),
--(1005, 'Toby', 'Flenderson', 32, 'Male'),
--(1006, 'Michael', 'Scott', 35, 'Male'),
--(1007, 'Meredith', 'Palmer', 32, 'Female'),
--(1008, 'Stanley', 'Hudson', 38, 'Male'),
--(1009, 'Kevin', 'Malone', 31, 'Male')

--Table 2 Insert:
--Insert Into EmployeeSalary VALUES
--(1001, 'Salesman', 45000),
--(1002, 'Receptionist', 36000),
--(1003, 'Salesman', 63000),
--(1004, 'Accountant', 47000),
--(1005, 'HR', 50000),
--(1006, 'Regional Manager', 65000),
--(1007, 'Supplier Relations', 41000),
--(1008, 'Salesman', 48000),
--(1009, 'Accountant', 42000)


--Select Statement -- Top, Distinct, Count, As, Max, Min, Avg
Select Top 5 *
From EmployeeDemographics

Select Distinct(Gender)
From EmployeeDemographics

Select COUNT(FirstName)
From EmployeeDemographics

Select COUNT(LastName) AS LastNameCount
From EmployeeDemographics

Select MAX(Salary)
From EmployeeSalary

Select MIN(Salary)
From EmployeeSalary 

Select AVG(Salary)
From EmployeeSalary


-- Where Statement -- =, <>, <, >, And, Or, Like, Null, Not Null, In
Select *
From EmployeeDemographics
Where Age = 30

Select *
From EmployeeDemographics -- <> means NOT 
Where Age <> 30

Select *
From EmployeeDemographics
Where Age < 30

Select *
From EmployeeDemographics
Where Age > 30

Select *
From EmployeeDemographics
Where Age >= 30

Select *
From EmployeeDemographics
Where Age < 30

Select *
From EmployeeDemographics
Where Age <= 30

Select *
From EmployeeDemographics
Where Age >= 30 AND Gender = 'Male'



Select *
From EmployeeDemographics
Where LastName LIKE 'S%'    --% means wildcard. This means any last name that starts with S.

Select *
From EmployeeDemographics
Where LastName LIKE '%S%'    -- If you put a % at the beginning and end of the S, then it looks for any name with an S in it. 


SELECT *
FROM EmployeeDemographics
WHERE FirstName is NOT NULL

SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'Michael') -- IN is a condensed way to say 'equal' for multiple things


--Group By, Order By
Select *
From EmployeeDemographics

Select Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
Where Age > 31
Group By Gender

Select *
From EmployeeDemographics
Order By Age, Gender


Select *
From EmployeeDemographics
Order By 1,2				--You can also use numbers for columns