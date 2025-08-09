CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department_id INT,
    manager_id INT,
    join_date DATE,
    salary INT
);

INSERT INTO employees (emp_id, emp_name, department_id, manager_id, join_date, salary) VALUES
(1, 'Alice', 101, NULL, '2020-01-01', 80000),
(2, 'Bob', 101, 1, '2020-06-01', 60000),
(3, 'Charlie', 102, 1, '2019-03-15', 70000),
(4, 'David', 103, 2, '2021-05-20', 65000),
(5, 'Eve', 104, NULL, '2022-01-10', 72000),
(6, 'Frank', NULL, NULL, '2021-07-12', 58000);


CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO departments (department_id, department_name) VALUES
(101, 'Engineering'),
(102, 'Sales'),
(103, 'HR'),
(104, 'Marketing'),
(105, 'Legal');


CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE
);

INSERT INTO projects (project_id, project_name, start_date, end_date) VALUES
(201, 'Website Redesign', '2023-01-01', '2023-06-30'),
(202, 'Product Launch', '2023-02-15', NULL),
(203, 'HR Automation', '2023-03-01', '2023-09-01'),
(204, 'Sales Dashboard', '2023-04-01', '2023-08-01');


CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT,
    role VARCHAR(50),
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO employee_projects (emp_id, project_id, role) VALUES
(1, 201, 'Lead Developer'),
(2, 201, 'Developer'),
(3, 202, 'Sales Lead'),
(4, 203, 'HR Analyst'),
(1, 204, 'Consultant'),
(5, 202, 'Marketing Manager');


CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    location_name VARCHAR(100)
);

INSERT INTO locations (location_id, location_name) VALUES
(1, 'New York'),
(2, 'London'),
(3, 'Berlin'),
(4, 'Tokyo');


CREATE TABLE department_locations (
    department_id INT,
    location_id INT,
    PRIMARY KEY (department_id, location_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

INSERT INTO department_locations (department_id, location_id) VALUES
(101, 1),
(101, 2),
(102, 3),
(103, 4),
(104, 1);

CREATE TABLE managers (
    manager_id INT PRIMARY KEY,
    manager_name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO managers (manager_id, manager_name, department_id) VALUES
(1, 'Grace', 101),
(2, 'Helen', 102),
(3, 'Ivan', 103),
(4, 'Judy', 104);





