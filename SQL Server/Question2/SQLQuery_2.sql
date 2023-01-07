/*
employee(employee-name, street, city)
works(employee-name, company-name, salary)
company(company-name, city)
manages (employee-name, manager-name)
*/

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
       ('Gita Devi', 'Street 6', 'Bhaktapur');

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
      ('Gita Devi','First Bank Corporation',80000);

SELECT * FROM works;

INSERT INTO manages(employee_name, manager_name)
VALUES ('Sita Devi', 'Ram Bahadur'),
	   ('Gita Devi ', 'Shyam Kumar'),
       ('Rita Devi', 'Hari Bahadur');

DELETE FROM works
WHERE employee_name = 'Gita Devi'
 AND company_name = 'Small Bank Corporation';

INSERT INTO works (employee_name, company_name, salary)
VALUES ('Gita Devi', 'Small Bank Corporation', 52000);

--Question number 2

/*Question number 2 a)*/
SELECT employee_name FROM works WHERE company_name='First Bank Corporation';

/*Question number 2 b)*/
SELECT e.employee_name, e.city
FROM employee e, works w, company c
WHERE e.employee_name = w.employee_name
AND w.company_name = c.company_name
AND c.company_name = 'First Bank Corporation';

/*Question number 2 c)*/
SELECT e.employee_name, e.street, e.city
FROM employee e, works w, company c
WHERE e.employee_name = w.employee_name
AND w.company_name = c.company_name
AND c.company_name = 'First Bank Corporation'
AND salary>10000;

/*Question number 2 d)*/
SELECT e.employee_name
FROM employee e
INNER JOIN works w ON e.employee_name = w.employee_name
INNER JOIN company c ON w.company_name = c.company_name
WHERE e.city = c.city;

/*Question number 2 e)*/
SELECT e.employee_name
FROM employee e
INNER JOIN manages m ON e.employee_name = m.employee_name
INNER JOIN employee mgr ON m.manager_name = mgr.employee_name
WHERE e.street = mgr.street;

/*Question number 2 e)*/
SELECT w.employee_name
FROM works w
WHERE w.company_name!= 'First Bank Corporation';

/*Question number 2 g)*/
SELECT e.employee_name
FROM employee e
INNER JOIN works w ON e.employee_name = w.employee_name
WHERE w.salary > (SELECT salary FROM works 
WHERE company_name = 'Small Bank Corporation');

/*Question number 2 h)*/
SELECT c.company_name
FROM company c
WHERE c.city IN (SELECT city FROM company 
WHERE company_name = 'Small Bank Corporation');

/*Question number 2 i)*/
SELECT e.employee_name
FROM employee e
INNER JOIN works w ON e.employee_name = w.employee_name
GROUP BY e.employee_name, w.company_name, w.salary
HAVING w.salary > (SELECT AVG(salary) FROM works WHERE company_name = w.company_name);

/*Question number 2 j)*/
SELECT TOP 1 w.company_name, COUNT(*) as employee_count
FROM works w
GROUP BY w.company_name
ORDER BY employee_count DESC;

/*Question number 2 k)*/
SELECT TOP 1 w.company_name, SUM(w.salary) as total_payroll
FROM works w
GROUP BY w.company_name
ORDER BY total_payroll ASC;

/*Question number 2 l)*/
SELECT w.company_name
FROM works w
GROUP BY w.company_name
HAVING AVG(w.salary) > (SELECT AVG(salary) 
FROM works WHERE company_name = 'First Bank Corporation');


