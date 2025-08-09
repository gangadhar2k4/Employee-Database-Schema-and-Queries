select * from employees;
select * from departments;
select * from projects;
select * from employee_projects;
select * from locations;
select * from department_locations;

-- List all employees along with their department names.

select emp.emp_id,emp.emp_name,dept.department_name from employees as emp
left join departments as dept on emp.department_id = dept.department_id;

-- Show employee names and their manager IDs.
select emp_id, emp_name, manager_id from employees;

-- Display all employees with their project names.
with cte as (
			select emp.emp_id,emp.emp_name, emp_pro.project_id from employees emp
			left join employee_projects emp_pro on emp.emp_id = emp_pro.emp_id)

select cte.emp_id,cte.emp_name,cte.project_id,p.project_name from cte 
inner join projects p 
on cte.project_id = p.project_id;

-- Get a list of all projects along with the employee names working on them.
select * from employee_projects;
with cte as(
			select p.project_id, p.project_name, emp_pro.emp_id from projects p 
			left join employee_projects emp_pro
			on p.project_id = emp_pro.project_id)
select cte.project_id, cte.project_name, emp.emp_name from cte 
left join employees emp
on cte.emp_id = emp.emp_id;

-- Show each department along with its location(s).
select * from locations;
with cte as(
			select dept.department_id,dept.department_name,dept_lo.location_id from departments dept
			left join department_locations dept_lo
			on dept.department_id = dept_lo.department_id)
select cte.department_name,l.location_name from cte
left join locations l
on cte.location_id = l.location_id;

-- List all employees with their join dates and department names.
select emp.emp_name,emp.join_date,dept.department_name from employees emp
left join departments dept
on emp.department_id = dept.department_id;

-- Display project names along with their start and end dates.
select * from projects;

-- Get a list of employees who are assigned to at least one project.

select * from employees
where emp_id in (select emp_id from employee_projects);

select emp.* from employees emp
inner join employee_projects emp_pro
on emp.emp_id = emp_pro.emp_id;

-- Show all departments and the number of locations they are associated with.

select dept.department_id,dept.department_name,count(*) as no_of_locations from departments dept
left join department_locations dept_lo
on dept.department_id = dept_lo.department_id
group by dept.department_id,dept.department_name;

-- List each employee's name along with the name of their department and project(s).
select * from employees;
with cte as (select t1.emp_name,t1.department_name,emp_pro.project_id from 
			(select emp.emp_id,emp.emp_name,dept.department_name,dept.department_id from employees emp
			left join departments dept
			on emp.department_id = dept.department_id) t1
			left join employee_projects emp_pro
			on t1.emp_id = emp_pro.emp_id)
select * from cte left join projects 
on cte.project_id = projects.project_id;


