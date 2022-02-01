--///SLIGHTLY ADVANCED///--
-- Temp Tables --
CREATE TABLE #temp_employee (
EmployeeID int,
JobTitle varchar(100),
Salary int
)

Select *
FROM #temp_employee

INSERT INTO #temp_employee VALUES (
'1001', 'HR', '45000'
)

INSERT INTO #temp_Employee
SELECT *
FROM EmployeeSalary

--This is how a temp table would actually be used
DROP TABLE IF EXISTS #Temp_Employee2
CREATE TABLE #Temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #Temp_Employee2
SELECT JobTitle, COUNT(JobTitle), Avg(Age), Avg(salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #Temp_Employee2

--The temp table we created(#Temp_Employee2) has everything from the above queries embeded into it.
--It saves lots of time to use the temp table rather than write out the long queries each time you want to hit off of that data. 




-- CTEs --
WITH CTE_Employee as 
(SELECT FirstName, LastName, Gender, Salary, COUNT(gender) OVER (PARTITION by Gender) as TotalGender
, AVG(Salary) OVER (PARTITION by Gender) as AvgSalary
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)
Select FirstName, AvgSalary
FROM CTE_Employee



-- String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower
CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

INSERT INTO EmployeeErrors VALUES
('1001 ', 'jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

SELECT *
FROM EmployeeErrors --I accidentally ran the INSERT INTO query twice so there is duplicate data in the table now. Use DISTINCT in SELECT statement to fix that. 





-- Using TRIM, LTRIM, RTRIM
Select EmployeeID, TRIM(EmployeeID) as IDTRIM --TRIM fixes both left and right
FROM EmployeeErrors

Select EmployeeID, LTRIM(EmployeeID) as IDTRIM --Only fixes spaces on the left
FROM EmployeeErrors

Select EmployeeID, RTRIM(EmployeeID) as IDTRIM ---Only fixes spaces on the right
FROM EmployeeErrors





-- Using Replace
Select LastName, REPLACE(LastName, '- Fired','') as LastNameFixed
FROM EmployeeErrors






-- Using Substring
Select SUBSTRING(FirstName,1,3)
FROM EmployeeErrors


--fuzzy matching -- For example; you have "Alex" in one table but "Alexander" in another 
Select err.FirstName, dem.FirstName
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	ON err.FirstName = dem.FirstName
	--The above query only results in Toby matching.
	--In order to get all of them to match, run the query below

Select SUBSTRING(err.FirstName,1,3), SUBSTRING(dem.FirstName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3)

	-- Best to fuzzy match with - LastName, Gender, Age, DOB





-- Using UPPER and lower--
Select FirstName, LOWER(FirstName) 
FROM EmployeeErrors

Select FirstName, UPPER(FirstName)
FROM EmployeeErrors


-- Stored Procedures-- Group of SQL statements that has been created and then stored in that database -- a single stored procedure can be used over the network by different users
CREATE PROCEDURE TEST 
AS 
Select *
From EmployeeDemographics 
--you can find this under SQL Tutorial > Programmability > Stored Procedures


EXEC TEST

--Here is a slightly more complex stored procedure with the temp table from earlier
CREATE PROCEDURE Temp_Employee
AS
Create Table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_employee
SELECT JobTitle, COUNT(JobTitle), Avg(Age), Avg(Salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

Select *
From #temp_employee


EXEC Temp_Employee




-- Subqueries (in the Select, From and Where Statement)
Select*
From EmployeeSalary

--Subquery in Select
Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
From EmployeeSalary


-- How to do it with Partition By
Select EmployeeID, Salary, AVG(Salary) OVER () as AllAvgSalary
From EmployeeSalary

--Why Group By doesn't work
Select EmployeeID, Salary, AVG(Salary) as AllAvgSalary
From EmployeeSalary
Group By EmployeeID, Salary
Order By 1,2

-- Subquery in From
Select a.EmployeeID, AllAvgSalary
From (Select EmployeeID, Salary, AVG(Salary) OVER () as AllAvgSalary
	  From EmployeeSalary) a

-- Subquery in Where
Select EmployeeID, JobTitle, Salary
From EmployeeSalary
Where EmployeeID in (
		Select EmployeeID
		From EmployeeDemographics
		Where Age > 30)