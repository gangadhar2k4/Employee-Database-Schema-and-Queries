-- Display the difference between an employee’s salary and the average 
-- salary of their department.
select * from employees;
with cte as(select *,
			avg(salary) over(partition by department) as avg_sal 
			from employees)
select emp_name,salary,avg_sal,case
							when salary - avg_sal > 0 then concat("Greater than AVG SALARY -> ",salary - avg_sal)
                            else concat("Lesser than AVG SALARY -> ",avg_sal - salary)
						end as emp_sal_status
                        from cte;

-- Find the second-highest salary in each department using a window function.
with cte as (
			select *,row_number() over(partition by department order by salary,join_date) as row_count
			from employees)
select * from cte
where row_count = 3;

-- For every employee, show their name, department, and how many employees in their 
-- department joined before them.
with cte as(
			select *,row_number() over(partition by department order by join_date) as row_cnt
			from employees)
select emp_name,department,(row_cnt - 1) as cnt_before_join_emp 
from cte;

select *,row_number() over(partition by department order by join_date) - 1 as cnt_before_join_emp
			from employees;

-- Show the maximum salary within the same department for each employee, 
-- but only display those who do not earn the maximum.
with cte as(
			select *,max(salary) over(partition by department) as max_sal
			from employees)
select * from cte 
where max_sal > salary;

-- Identify employees who are earning above the average salary of their department.
select * from employees;
with cte as(
			select *,avg(salary) over(partition by department) as avg_sal
			from employees)
select * from cte 
where avg_sal < salary;

-- List all employees who have the lowest salary in their department using a window function.
with cte as (
			select *,row_number() over(partition by department order by salary,join_date) as row_cnt
            from employees)
select * from cte
where row_cnt = 1;

-- Calculate the percent rank of each employee’s salary within their department.
with cte as(
			select *,
            rank() over(partition by department order by salary) as row_rank,
            count(*) over(partition by department) as total_partition_cnt
            from employees)
select 	emp_id,
		emp_name,
		department,
        (row_rank - 1) / (total_partition_cnt - 1) * 100 as per_rank
		from cte;
        
-- For each department, show the top 2 earners using a window function.
with cte as (
			select *,row_number() over(partition by department order by salary Desc) as row_cnt
            from employees)
select * from cte 
where row_cnt <= 2;

-- Find all employees who are tied in salary with at least one other employee 
-- within their department.
with cte as (
			select *,
            rank() over(partition by department order by salary) as emp_rank,
            lag(salary,1) over(partition by department order by salary) as prev_emp_sal,
            lead(salary,1) over(partition by department order by salary) as next_emp_sal
            from employees)
select * from cte 
where salary = prev_emp_sal or salary = next_emp_sal;

-- For each department, show the total salary paid so far to employees ordered 
-- by join date (running total), and list only those employees whose running total
--  exceeds 150000.
select * from employees;
with cte as(
			select *,sum(salary) over(partition by department order by join_date) as paid_sal
            from employees)
select * from cte
where paid_sal > 150000;

-- For each department, calculate the difference between an employee's salary 
-- and the previous employee’s salary.
with cte as(
			select *,lag(salary,1) over(partition by department) as prev_emp_sal
            from employees)
select emp_name,
		department,
        case
			when prev_emp_sal is null then "Do not have previous."
            when (salary - prev_emp_sal) < 0 then concat("Prev EMP salary > Curr EMP Salary",prev_emp_sal - salary)
            when (salary - prev_emp_sal) > 0 then concat("Prev EMP salary < Curr EMP Salary ",prev_emp_sal - salary)
			else "Prev & Curr EMP Salary same."
        end as sal_diff
from cte;

-- Show each employee’s salary as a percentage of the total salary in their department.
with cte as (
			select *,sum(salary) over(partition by department) as total_sal_sum
            from employees)
select *, (((total_sal_sum - salary) / total_sal_sum) * 100) as percentage from cte;

-- Display the running count of employees joined in each department, ordered by join date.

select *,row_number() over(partition by department order by join_date,emp_id) as row_num from employees;

-- Show employees whose salary is above the average salary of their department.-
with cte as (
			select *,avg(salary) over(partition by department) as dept_avg_sal 
            from employees)
select * from cte 
where salary > dept_avg_sal;

-- Find employees who share the same salary with at least one other person in 
-- their department.
with cte as(
			select *,
					lag(salary,1) over(partition by department order by salary) as prev_sal,
					lead(salary,1) over(partition by department order by salary) as next_sal 
					from employees)
select * from cte 
where salary = prev_sal or salary = next_sal;

-- For each department, find the employee with the largest gap in salary 
-- compared to the previous person.
with cte as (
			select *,
					lag(salary) over(partition by department order by salary) as prev_sal
					from employees)
select department,max(salary - prev_sal) as max_diff from cte
group by department;
-- select *,
-- 		max(salary - prev_sal) over(partition by department) as sal_diff 
--         from cte;

-- List departments where the sum of the top 3 salaries exceeds 200000.

-- Display the bottom 2 earners in each department.

-- For each employee, count how many colleagues in their department earn less than them.



