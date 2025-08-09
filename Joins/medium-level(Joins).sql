-- List all employees along with their project names and the roles they play.
select * from employees;
select * from projects;
select * from employee_projects;
with cte as
			(select emp.emp_id,emp.emp_name,emp_pro.role,emp_pro.project_id from employees emp 
			left join employee_projects emp_pro
			on emp.emp_id = emp_pro.emp_id)
select cte.emp_name,cte.role,p.project_name from cte
left join projects p
on cte.project_id = p.project_id;

-- Show the name of each employee, their manager's name, and the department 
-- they belong to.
select * from employees;
select * from managers;
select * from departments;

with cte as (select emp.emp_id,emp.emp_name,dept.department_id,dept.department_name from employees emp
			left join departments dept
			on emp.department_id = dept.department_id)
select cte.emp_name,cte.department_name,m.manager_name from cte 
left join managers m
on cte.department_id = m.department_id;

-- List all departments along with the number of employees working in them.
with cte as (select dept.department_id,dept.department_name,emp.emp_name from departments dept
			left join employees emp 
			on dept.department_id = emp.department_id)
select distinct department_id , count(emp_name) over(partition by department_id) as emp_count from cte;

select department_name,count(emp_name) as emp_count from cte
group by department_name;

select * from employees;
select * from departments;

-- Display the names of departments that have no employees assigned.
with cte as (select dept.department_id,dept.department_name,emp.emp_name from departments dept
			left join employees emp 
			on dept.department_id = emp.department_id)
select department_name,count(emp_name) as emp_count from cte
group by department_name
having count(emp_name) = 0;

-- Show all projects that have no employees working on them.
select * from projects;
select * from employee_projects;

with cte as (select projects.project_id,projects.project_name,employee_projects.emp_id from projects 
			left join employee_projects
			on projects.project_id = employee_projects.project_id)
select project_id,count(emp_id) from cte
group by project_id
having count(emp_id) = 0;

-- List each employee’s name, their department, and all the locations 
-- their department operates in.


-- Find the total salary paid per project, considering only employees assigned to that project.

-- List departments and the number of employees assigned to at least one project.

-- Show all employees who work on more than one project.

-- Display the department name, its locations, and the names of employees working in those departments.

