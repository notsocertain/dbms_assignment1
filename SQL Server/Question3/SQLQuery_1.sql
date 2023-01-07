
CREATE DATABASE Employee_database;
USE Employee_database;

CREATE TABLE employee (
  employee_name VARCHAR(255) NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  PRIMARY KEY (employee_name)
);

CREATE TABLE works (
  employee_name VARCHAR(255) NOT NULL,
  company_name VARCHAR(255) NOT NULL,
  salary INTEGER NOT NULL,
  FOREIGN KEY (employee_name) REFERENCES employee(employee_name),
  PRIMARY KEY (employee_name, company_name)
);

CREATE TABLE company (
  company_name VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  PRIMARY KEY (company_name)
);

CREATE TABLE manages (
  employee_name VARCHAR(255) NOT NULL,
  manager_name VARCHAR(255) NOT NULL,
  FOREIGN KEY (employee_name) REFERENCES employee(employee_name),
  FOREIGN KEY (manager_name) REFERENCES employee(employee_name),
  PRIMARY KEY (employee_name, manager_name)
);

INSERT INTO employee (employee_name, street, city)
VALUES ('Ram Bahadur', 'Street 1', 'Kathmandu'),
       ('Shyam Kumar', 'Street 2', 'Lalitpur'),
       ('Hari Bahadur', 'Street 3', 'Kathmandu'),
       ('Sita Devi', 'Street 4', 'lalitpur'),
       ('Rita Devi', 'Street 5', 'Kathmandu'),
       ('Gita Devi', 'Street 6', 'Bhaktapur'),
       ('Jones', 'Street 5', 'Kathmandu');

 SELECT * FROM employee

INSERT INTO company (company_name, city)
VALUES ('Company 1', 'Bhaktapur'),
       ('Company 2', 'Lalitpur'),
       ('Company 3', 'Kathmandu'),
       ('First Bank Corporation', 'Lalitpur'),
       ('Small Bank Corporation', 'Lalitpur');

SELECT * FROM company;

INSERT INTO works (employee_name, company_name, salary)
VALUES('Ram Bahadur','Company 1',50000),
      ('Shyam Kumar','Company 2',51000),
      ('Hari Bahadur','Company 3',50000),
      ('Sita Devi','First Bank Corporation',60000),
      ('Rita Devi','First Bank Corporation',70000),
      ('Jones','First Bank Corporation',70000),
      ('Gita Devi','First Bank Corporation',80000);

SELECT * FROM works;

INSERT INTO manages(employee_name, manager_name)
VALUES ('Sita Devi', 'Ram Bahadur'),
	   ('Gita Devi ', 'Shyam Kumar'),
       ('Jones', 'Shyam Kumar'),
       ('Rita Devi', 'Hari Bahadur');

DELETE FROM works
WHERE employee_name = 'Gita Devi'
 AND company_name = 'Small Bank Corporation';

INSERT INTO works (employee_name, company_name, salary)
VALUES ('Gita Devi', 'Small Bank Corporation', 52000);


SELECT * FROM Employee;
UPDATE Employee
SET City = 'Newton'
WHERE Employee_Name = 'Jones';

UPDATE works
SET salary = salary * 1.1
WHERE company_name = 'First Bank Corporation';

SELECT * FROM works;

UPDATE works
SET salary = salary * 1.1
WHERE employee_name IN (SELECT employee_name FROM manages WHERE company_name = 'First Bank Corporation');


UPDATE w
SET w.salary = 
  CASE 
    WHEN w.salary * 1.1 <= 100000 THEN w.salary * 1.1
    ELSE w.salary * 1.03
  END
FROM works w
INNER JOIN manages m ON w.employee_name = m.employee_name
WHERE w.company_name = 'First Bank Corporation';

DELETE FROM works
WHERE company_name = 'Small Bank Corporation';

SELECT * FROM works
 WHERE company_name = 'Small Bank Corporation';
