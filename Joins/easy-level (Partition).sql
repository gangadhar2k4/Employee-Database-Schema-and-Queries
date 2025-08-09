-- sql practice squeries

 -- Ranking Functions:
-- Find the rank of employees in each department based on their salary.
-- their is skipping of rank
--  admin		4000		1->1
--  admin 		4000		1->2
--  admin 		5000		3->3
select *,rank() over(partition by dept_name order by salary) as rank_on_sal from employee;

-- Use ROW_NUMBER() to assign joining order within departments.
select *,row_number() over(partition by dept_name) from employee;

-- Use DENSE_RANK() to handle tie salaries in ranking.
-- their is no skipping anymore
--  admin		4000		1
--  admin 		4000		1
--  admin 		5000		2
select *, dense_rank() over(partition by dept_name order by salary) from employee;

-- Divide employees into 3 tiles (quartiles) based on salary using NTILE(3).
select * from employee;

-- 🔸 Aggregate Window Functions:
-- Show total salary per department without grouping the data.
select * from employee;
select distinct DEPT_NAME,sum(salary) over(partition by dept_name) as total_sal 
from employee;

-- Find average salary per department using AVG() OVER(...).
select distinct DEPT_NAME,avg(salary) over(partition by dept_name) as total_sal 
from employee;

-- Display the highest and lowest salary in each department using MAX() and MIN().
select distinct DEPT_NAME,
		max(salary) over(partition by dept_name) as max_sal,
        min(salary) over(partition by dept_name) as min_sal
		from employee;






