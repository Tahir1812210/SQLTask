create database InsertAndUpdate create table Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1, 1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Department NVARCHAR(50) NULL,
    JobTitle NVARCHAR(50) NULL
);
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1, 1),
    DepartmentName NVARCHAR(50) NOT NULL
);
create Table Projects (
    ProjectID INT PRIMARY KEY IDENTITY(1, 1),
    ProjectName NVARCHAR(100) NOT NULL,
    DepartmentID int foreign key references Departments(DepartmentId)
);
CREATE TABLE EmployeeProjects (
    EmployeeProjectID INT PRIMARY KEY IDENTITY(1, 1),
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    ProjectID INT FOREIGN KEY REFERENCES Projects(ProjectID)
);
insert into departments (DepartmentName)
VALUES ('Sales'),
    ('Marketing'),
    ('IT'),
    ('HR'),
    ('Finance');
insert into employees (FirstName, LastName, Department, JobTitle)
VALUES ('John', 'Doe', 'Sales', 'Account Manager'),
    (
        'Jane',
        'Smith',
        'Marketing',
        'Marketing Specialist'
    ),
    ('Sam', 'Brown', 'IT', 'Developer'),
    ('Alice', 'Johnson', 'HR', 'HR Manager'),
    ('Tom', 'Hanks', 'Finance', 'Financial Analyst');
insert into Projects (ProjectName, DepartmentID)
VALUES ('Product Launch', 1),
    ('Brand Awareness Campaign', 2),
    ('System Upgrade', 3),
    ('Employee Wellness Program', 4),
    ('Annual Budget Review', 5);
insert into EmployeeProjects (EmployeeID, ProjectID)
VALUES (1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5)
SELECT *
FROM Departments;
SELECT *
FROM Employees;
SELECT *
FROM Projects;
SELECT *
FROM EmployeeProjects;
insert into employees (FirstName, LastName, Department, JobTitle)
VALUES ('Emma', 'Stone', 'Legal', 'Legal Advisor');
INSERT INTO Employees (FirstName, LastName, Department)
VALUES (
        'Lucy',
        'Gray',
        CASE
            WHEN 'Marketing' = 'Sales' THEN 'Sales'
            ELSE 'Marketing'
        END
    );
INSERT INTO Employees (FirstName, LastName, Department) OUTPUT inserted.EmployeeID,
    inserted.FirstName,
    inserted.LastName
VALUES ('Tom', 'Hanks', 'Finance');
Update Employees
SET FirstName = 'Sarah',
    LastName = 'Conor'
Where EmployeeID = 2
UPDATE Employees
SET Department = 'Sales'
WHERE Department = 'Marketing'
    AND EmployeeID > 5;
Update Employees
set Department = 'HR' Output Deleted.EmployeeID,
    Deleted.Department As OldDepartment,
    inserted.Department As NewDepartment
Where EmployeeID = 1
Update Employees
set Department = (
        Select Department
        from Departments
        Where DepartmentID = 2
    )
Where EmployeeID = 3 If not exists (
        select *
        from Employees
        where EmployeeID = 6
    ) Begin
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department)
VALUES (6, 'Paul', 'Walker', 'Operations');
End MERGE Employees AS Target USING (
    SELECT 'Mary' AS FirstName,
        'Jane' AS LastName,
        'Finance' AS Department
) AS Source ON Target.EmployeeID = 5
WHEN MATCHED THEN
UPDATE
SET FirstName = Source.FirstName,
    LastName = Source.LastName,
    Department = Source.Department
    WHEN NOT MATCHED THEN
INSERT (FirstName, LastName, Department)
VALUES (
        Source.FirstName,
        Source.LastName,
        Source.Department
    );