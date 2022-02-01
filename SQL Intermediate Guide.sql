--///INTERMEDIATE///--

-- Inner Joins, Full/Left/Right/ Outer Joins

--Lets put some NULLS in the EmployeeDemographics table and EmployeeSalary table

--Insert into EmployeeDemographics VALUES
--(1011, 'Ryan', 'Howard', 26, 'Male'),
--(NULL, 'Holly', 'Flax', NULL, NULL),
--(1013, 'Darryl', 'Philbin', NULL, 'Male')

--Insert Into EmployeeSalary VALUES
--('1010', NULL, 47000),
--(NULL, 'Salesman', 43000)

--Select *
--From EmployeeDemographics

--Select *
--From EmployeeSalary

--Inner Join-- You can also just say Join as they are both the same thing
--Inner joins only look at the things that are similar in both tables(based on the common column which in this case is EmployeeID)
SELECT *
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EMployeeID 

--Full Outer Join(Joins everything in both tables)--
SELECT *
FROM EmployeeDemographics
FULL OUTER JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EMployeeID 

--Left Outer Join(Joins everything from the left table and everything that is overlapping in the right table)--
--The left table is the first table that we use and the right table is the second table that we use
SELECT *
FROM EmployeeDemographics --Left table
LEFT OUTER JOIN EmployeeSalary --Right table
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EMployeeID 

--Right Outer Join(does the exact opposite of the left outer join)--
SELECT *
FROM EmployeeDemographics --Left table
RIGHT OUTER JOIN EmployeeSalary --Right table
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EMployeeID 

--More Examples / Use Cases--
SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--Find highest paid employee who is not Michael
SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, Salary
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Michael' 
ORDER BY Salary DESC

--Find average salary for salesman
SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle


--Union, Union All--
SELECT *
FROM EmployeeDemographics
UNION					--By default, Union takes out all duplicates -- Union All will include duplicates
SELECT *
FROM WareHouseEmployeeDemographics


--Look at the difference between a Union and Full Outer Join

SELECT *
FROM EmployeeDemographics
FULL OUTER JOIN WareHouseEmployeeDemographics
	ON EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID


-- With Unions, be sure that the rows you are selecting are the same. If not, the table that comes back will not be correct. 


--Case Statement--
SELECT FirstName, LastName, Age,
CASE
	WHEN Age > 30 THEN 'Old'
	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Baby'
END
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age


SELECT FirstName, LastName, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
	WHEN JobTItle = 'HR' THEN Salary + (Salary * .000001)
	ELSE Salary + (Salary * .03)
END AS SalaryAfterRaise
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


--Having Clause--
SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
Having COUNT(JobTitle) > 1


SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)


--Updating/Deleting Data--
SELECT *
FROM EmployeeDemographics

UPDATE EmployeeDemographics
SET EmployeeID = 1012
WHERE FirstName = 'Holly' AND LastName = 'Flax'

UPDATE EmployeeDemographics
SET Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax'

SELECT *
FROM WareHouseEmployeeDemographics

UPDATE WareHouseEmployeeDemographics
SET Age = 31
WHERE EmployeeID = 1013


--Not going to actially delete a row but this query below would delete the row or employee number 1005.

--DELETE FROM EmployeeDemographics
--WHERE EmployeeID = 1005


--Aliasing--
SELECT FirstName as Fname
FROM EmployeeDemographics

SELECT FirstName + ' '+ LastName AS FullName
FROM EmployeeDemographics

SELECT Avg(Age) AS AvgAge
FROM EmployeeDemographics

SELECT Demo.EmployeeID, sal.Salary
FROM EmployeeDemographics as Demo
Join EmployeeSalary sal
	ON Demo.EmployeeID = sal.EmployeeID

	--More complex double join
SELECT Demo.EmployeeID, Demo.FirstName, Demo.LastName, sal.JobTitle, Ware.Age
FROM EmployeeDemographics Demo
LEFT JOIN EmployeeSalary Sal
	ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN WareHouseEmployeeDemographics Ware
	ON DEMO.EmployeeID = Ware.EmployeeID



--Partition By--
SELECT FirstName, LastName, Gender, Salary
, COUNT(GENDER) OVER (PARTITION BY Gender) as TotalGender
FROM EmployeeDemographics dem
JOIN EmployeeSalary sal
	ON dem.EmployeeID = sal.EmployeeID
