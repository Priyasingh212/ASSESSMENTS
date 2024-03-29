-- **********************************////////////-- assignment question----///////////////****************************************
use hr;
-- 1. Display all information in the tables EMP and DEPT.
 select  * from employees as  e
 join departments  as d
 on e.employee_id = d.department_id;
 
-- 2. Display only the hire date and employee name for each employee.
 select hire_date, concat(first_name , ' ', last_name) as employee_name
 from employees;
 
-- 3. Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title
      select concat(first_name , '  ,  ', job_id)  as employee_and_title from employees;

-- 4.Display the hire date, name and department number for all clerks.
  select hire_date, first_name, department_id from employees
  where job_id = 'sh_clerk';

-- 5. Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT
    select concat(employee_id, ' , ', first_name, ' , ', last_name, ',', email, ' , ', phone_number, ' , ', hire_date, ' , ', job_id, ' , ' , 
    salary, ' , ', commission_pct, ' , ',manager_id, ' , ', department_id) as THE_OUTPUT from employees;

-- 6. Display the names and salaries of all employees with a salary greater than 2000.
    select concat(first_name, ' ', last_name) as names , salary from employees where salary > 2000;

-- 7. Display the names and dates of employees with the column headers "Name" and "Start Date"
     select first_name as names , hire_date as start_date from employees; 
     
-- 8. Display the names and hire dates of all employees in the order they were hired.
    select first_name, hire_date from employees order by hire_date asc;


-- 9. Display the names and salaries of all employees in reverse salary order.
      select  first_name, salary from employees order by salary desc;

-- 10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order.
      select first_name, department_id from employees where commission_pct is not null order by salary desc;

-- 11. Display the last name and job title of all employees who do not have a manager
      select last_name , job_id from employees where manager_id is null;

-- 12. Display the last name, job, and salary for all employees whose job is sales representative or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000      
 select last_name, job_id, salary from employees where job_id = 'sa_rep' or job_id='st_clerk' and salary not in (2500, 3500, 5000);
 


-- 1) Display the maximum, minimum and average salary and who commission earned.
select max(salary)as max_salary ,min(salary)as min_salary, avg(salary)as avg_salary from employees where commission_pct is not null ;

-- 2) Display the department number, total salary payout and total commission payout for each department.
    
    select department_id, sum(salary)as total_salary_payout ,sum(commission_pct) as total_commission_payout from employees
    group by department_id, salary;

-- 3) Display the department number and number of employees in each department.

     select  department_id , count(job_id) from employees
     group by department_id;

-- 4) Display the department number and total salary of employees in each department.

select department_id, job_id, sum(salary) as sum_of_each_emp from employees
group by department_id, job_id;

-- 5) Display the employee's name who doesn't earn a commission. Order the result set without using the column name
   
   select first_name from employees where commission_pct is null  order by first_name ;

-- 6) Display the employees name, department id and commission. If an Employee doesn't earn the commission, then display as 'No commission'. Name the columns appropriately

select concat(first_name, ' ', last_name) as emp_name, department_id ,commission_pct, coalesce(commission_pct, 'no commission') as commission 
from employees 
where commission_pct is null ;

-- 7) Display the employee's name, salary and commission multiplied by 2. If an Employee doesn't earn the commission, then display as 'No commission. 
    -- Name the columns appropriately.
    select concat(first_name, '  ', last_name) as emp_name , 2*salary , commission_pct*2 , coalesce( commission_pct , 'no commission') as commission 
    from employees;
    
-- 8) Display the employee's name, department id who have the first name same as another employee in the same department.

select e.first_name, e.department_id from employees e
join employees d on e.first_name= d.first_name and 
e.department_id = d.department_id
where e.employee_id <> d.employee_id;

-- 9) Display the sum of salaries of the employees working under each Manager.
  select  manager_Id ,sum(salary) as sum_of_salaries from employees
  group by manager_id;
  
-- 10) Select the Managers name, the count of employees working under and the department ID of the manager.
    select department_id, count(manager_id) as no_of_emp from employees
    group by department_id;

-- 11) Select the employee name, department id, and the salary. Group the result with the manager name and the employee last name should have second letter 'a!

     select concat(first_name, '    ', last_name) as emp_name , department_id, salary from employees
     where job_id like '_a%' and last_name like '_a%'
     group by emp_name, department_id, salary;

-- 12) Display the average of sum of the salaries and group the result with the department id. Order the result with the department id.

     select department_id, sum(salary) as sum_of_salary from employees
      group by department_id
      order by department_id asc;

-- 13) Select the maximum salary of each department along with the department id.
       select department_id ,max(salary) as max_salary from employees 
       group by department_id;

-- 14) Display the commission, if not null display 10% of salary, if null display a default value 1.
      select  
         case 
             when commission_pct is not null  
             then salary * 0.10
             else 1
             end  commission_pct
        from employees;     


-- 1. Write a query that displays the employee's last names only from the string's 2-5th position with the first letter capitalized and all other letters lowercase,
--  Give each column an appropriate label. 

     select concat(upper(substring(last_name, 2,1)),
     lower(substring(last_name,3,4))) as capitalized_last_name 
     from employees;


-- 2. Write a query that displays the employee's first name and last name along with a " in between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. 
-- Also displays the month on which the employee has joined.
   
      select concat(first_name, '   ' ,last_name)as full_name ,monthname(hire_date)as join_month  from employees
      where first_name like '%a%' and last_name like '%a%';


-- 3. Write a query to display the employee's last name and if half of the salary is greater than ten thousand then increase the salary by 10% else by 11.5% along 
-- with the bonus amount of 1500 each. Provide each column an appropriate label. 

      select last_name,
           case
              when salary *0.5 > 10000
                 then salary * 1.10
                  else salary * 1.115
                  end as changed_salary,
              case
                 when salary * 0.5 > 10000
                 then 1500
                 else 1500
                 end as  bonus_amount
                 from employees;
 
-- 4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, department id, salary and the manager name all in Upper case, if the Manager name 
-- consists of 'z' replace it with '$! 

          select concat(lpad(employee_id, 5,'00'), 'e') as  changed_emp_id,
          department_id, salary, upper(replace(first_name, 'a', '$')) as chnaged_name
          from employees;
          
-- 5. Write a query that displays the employee's last names with the first letter capitalized and all other letters lowercase, and the length of the names, for all 
-- employees whose name  starts with J, A, or M. Give each column an appropriate label. Sort the results by the  employees' last names 

select concat(upper(substring(last_name,1,1 )), lower(substring(last_name,2))) as formatted_last_name, length(last_name) as length_of_last_name from employees
         where last_name like 'j%' or last_name like 'a%' or last_name like 'm%'
         order by last_name asc;
         
-- 6. Create a query to display the last name and salary for all employees. Format the salary to  be 15 characters long, left-padded with $. Label the column SALARY 

        SELECT last_name, 
       LPAD(CONCAT('$', CAST(salary AS CHAR)), 15, '$') AS SALARY 
       FROM employees;

-- 7. Display the employee's name if it is a palindrome 
     SELECT first_name, last_name
    FROM employees
    WHERE CONCAT(first_name, ' ', last_name) = REVERSE(CONCAT(first_name, ' ', last_name));

-- 8. Display First names of all employees with initcaps. 
SELECT CONCAT(UPPER(SUBSTRING(first_name, 1, 1)), LOWER(SUBSTRING(first_name, 2))) AS First_Name
FROM employees;

-- 9. From LOCATIONS table, extract the word between first and second space from the  STREET ADDRESS column. 

    SELECT 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(street_address, ' ', 2), ' ', -1)) AS Extracted_Word
    FROM LOCATIONS;

-- 10. Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end. Name the column as e-mail address. 
-- All characters should be in lower case. Display this along with their First Name. 

SELECT CONCAT(LOWER(SUBSTRING(first_name, 1, 1)), last_name, '@systechusa.com') AS email_address,first_name
FROM employees;


-- 11. Display the names and job titles of all employees with the same job as Trenna. 
    SELECT first_name, last_name, job_Id
FROM employees
WHERE job_id = (
    SELECT job_id
    FROM employees
    WHERE first_name = 'Trenna');

-- 12. Display the names and department name of all employees working in the same city as  Trenna. 
     SELECT e.first_name, e.last_name, d.department_name, l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
join locations l on l.country_id
WHERE  l.city = (
    SELECT city
    FROM employees
    WHERE first_name = 'Trenna'
);

-- 13. Display the name of the employee whose salary is the lowest.
      SELECT first_name, last_name
      FROM employees
      ORDER BY salary
      LIMIT 1;
 
-- 14. Display the names of all employees except the lowest paid.
       SELECT first_name, last_name
      FROM employees
     WHERE salary != (
    SELECT MIN(salary)
    FROM employees);


-- 1. Write a query to display the last name, department number, department name for all  employees. 
     SELECT e.last_name, e.department_id, d.department_name
     FROM employees e
     JOIN departments d ON e.department_id = d.department_id;
     
-- 2. Create a unique list of all jobs that are in department 4. Include the location of the department in the output. 
       SELECT DISTINCT e.job_id, d.department_id, d.department_name, l.city
      FROM employees e
     JOIN departments d ON e.department_id = d.department_id
     JOIN locations l ON d.location_id = l.location_id
      WHERE d.department_id = 50;


-- 3. Write a query to display the employee last name,department name,location id and city of  all employees who earn commission. 
     select e.last_name, e.commission_pct  ,d.department_name, l.location_Id, l.city from employees e
     join departments d on e.department_id= d.department_id
     join locations l on d.location_id = l.location_id
     where e.commission_pct is not null;

-- 4. Display the employee last name and department name of all employees who have an 'a' in their last name .

      select e.last_name, d.department_name from employees e
      join departments d on e.department_id= d.department_id
      where e.last_name like '%a%';

-- 5. Write a query to display the last name,job,department number and department name for all employees who work in ATLANTA. 

select e.last_name, e.job_id, e.department_id, d.department_name  from employees e
join departments d on e.department_id = d.department_id 
join locations l on d.location_id = l.location_id
where l.city = 'tokyo';


-- 6. Display the employee last name and employee number along with their manager's last name and manager number. 
    select e.last_name , e.employee_id as emp_number, m.last_name as manager_last_name, e.manager_id as maanger_number
    from employees e
    join employees m on e.manager_id = m.employee_id;

-- 7. Display the employee last name and employee number along with their manager's last name and manager number (including the employees who have no manager). 

         select e.last_name, e.employee_id as emp_number,
         coalesce(m.last_name, 'no manager') as manager_last_name,
         coalesce(m.employee_id, 'n/a')as manager_number
         from employees e
         left join employees m on e.manager_id = m.employee_id;

-- 8. Create a query that displays employees last name,department number,and all the  employees who work in the same department as a given employee.

select e.last_name, e.department_ID from employees e
where e.department_id =
 ( select department_id from employees where department_id in ( 151,101,102) 
);

-- 9. Create a query that displays the name,job,department name,salary,grade for all employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C)

    select e.first_name, e.job_id, d.department_name, e.salary , 
    case
       when e.salary >= 17000 then 'A'
       when e.salary >= 9000 then 'B'
       else 'c'
       end as grade 
       from employees e
       join departments d on e. department_id = d.department_id;


 
-- 10. Display the names and hire date for all employees who were hired before their managers along with their manager names and hire date. Label the columns as Employee 
-- name, emp_hire_date,manager name,man_hire_date.

SELECT e.first_name AS Employee_name,
       e.hire_date AS emp_hire_date,
       m.manager_id AS Manager_name,
       m.hire_date AS man_hire_date
FROM Employees e
JOIN employees m ON e.manager_id = m.manager_id
WHERE e.hire_date < m.hire_date;



-- 1. Write a query to display employee numbers and employee name (first name, last name)  of all the sales employees who received an amount of 2000 in bonus. 
    SELECT employee_id, CONCAT(first_name, ' ', last_name) AS employee_name
   FROM employees
    WHERE job_id = 'sa_rep' AND commission_pct = 0.10;
    
-- 2. Fetch address details of employees belonging to the state CA. If address is null, provide default value N/A. 
 SELECT d.department_id,
       COALESCE(l.state_province, 'N/A') AS address,
       l.city,
       l.state_province
    FROM departments d
    join locations l on d.location_id = l.location_id
    WHERE l.state_province = 'oxford';

-- 3. Write a query that displays all the products along with the Sales OrderID even if an order has never been placed for that product.
    
SELECT c.customer_id ,c.first_name,
       o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id= o.customer_id;

-- 4. Find the subcategories that have at least two different prices less than $15. 
   
SELECT order_id
FROM (
    SELECT order_id, order_amount
    FROM  orders
    WHERE order_amount < 200
    GROUP BY order_id, order_amount
) AS sub_prices
GROUP BY order_id
HAVING COUNT( order_amount ) >= 2;

-- 5. A. Write a query to display employees and their manager details. Fetch employee id,  employee first name, and manager id, manager name.

SELECT e.employee_id ,e.first_name AS employee_first_name, e.manager_id ,
       m.first_name AS manager_first_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;
    
-- B. Display the employee id and employee name of employees who do not have manager. 

select employee_id, concat(first_name,' ', last_name) as employees_name
from employees
where manager_id is null;

-- 6. A. Display the names of all products of a particular subcategory 15 and the names of their vendors.
  
  SELECT e.first_name AS employees_name,
       d.department_name 
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.manager_id = 100;
    
-- B. Find the products that have more than one vendor.

select department_name , department_id from departments
group by department_name, department_id 
having  count(distinct  department_name ) > 1;

-- 7. Find all the customers who do not belong to any store. 

SELECT c.customer_id, c.first_name
FROM customers c
LEFT JOIN customers s ON c.customer_id = s.customer_id
WHERE s.customer_id IS NULL;


-- 8. Find sales prices of product 718 that are less than the list price recommended for that product.

SELECT sales_price
FROM sales
WHERE product_id = 718
AND sales_price < (SELECT list_price FROM products WHERE product_id = 718);


 
-- 9. Display product number, description and sales of each product in the year 2001. 

SELECT p.product_number,
       p.description,
       s.sales
FROM products p
JOIN sales s ON p.product_id = s.product_id
WHERE YEAR(s.sales_date) = 2001;


-- 10. Build the logic on the above question to extract sales for each category by year. Fetch Product Name, Sales_2001, Sales_2002, Sales_2003. 
     SELECT p.product_name,
       (CASE WHEN YEAR(s.sales_date) = 2001 THEN s.sales ELSE 0 END) AS Sales_2001,
       (CASE WHEN YEAR(s.sales_date) = 2002 THEN s.sales ELSE 0 END) AS Sales_2002,
       (CASE WHEN YEAR(s.sales_date) = 2003 THEN s.sales ELSE 0 END) AS Sales_2003
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_name;


-- 1. Write a query to display the last name and hire date of any employee in the same department as SALES. 
     select e.last_name, e.hire_date from employees e
     join departments d on e.department_id = d.department_id
     where department_name = 'sales';
     
     -- nested query-- 
     
	SELECT last_name, hire_date FROM employees
    WHERE department_id = (SELECT department_id FROM departments
    WHERE department_name = 'SALES');
	
-- 2. Create a query to display the employee numbers and last names of all employees who  earn more than the average salary. Sort the results in ascending order of salary.
 
     SELECT employee_id, last_name FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary ASC;
        
-- 3. Write a query that displays the employee numbers and last names of all employees who work in a department with any employee whose last name contains a' u 
    SELECT employee_id, last_name FROM employees
   WHERE department_id IN (SELECT department_id FROM employees
    WHERE last_name LIKE '%u%')
    ORDER BY last_name;

-- 4. Display the last name, department number, and job ID of all employees whose department location is ATLANTA. 
 
      select e.last_name, d.department_id, e.job_id from employees e
       join  departments d on e.department_id = d.department_id
       join locations l on d.location_id= l.location_id
       where l.city= 'south san francisco';

-- 5. Display the last name and salary of every employee who reports to FILLMORE. 
    
     SELECT e.last_name, e.salary
     FROM employees e
     JOIN employees m ON e.manager_id = m.employee_id
     WHERE m.last_name = 'king';

-- 6. Display the department number, last name, and job ID for every employee in the OPERATIONS department. 
   select department_id, last_name, job_id from employees 
   where job_Id =(select  job_id from employees
   where job_id = 'operations');
   --  or
select d.department_id, e.last_name, e.job_id  from employees e
join departments d on e.department_id = d. department_id
where d.department_name = 'operations';


-- 7. Modify the above query to display the employee numbers, last names, and salaries of all  employees who earn more than the average salary and who work 
-- in a department with any employee with a 'u'in their name. 
    
    SELECT e.employee_id, e.last_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (SELECT AVG(salary) FROM employees)
AND EXISTS (
    SELECT 1 
    FROM employees e2 
    WHERE e2.department_id = d.department_id 
    AND e2.last_name LIKE '%u%'
);

-- 8. Display the names of all employees whose job title is the same as anyone in the sales dept. 
    
SELECT e.last_name FROM employees e
WHERE e.job_id IN (SELECT e2.job_id FROM employees e2
    JOIN departments d ON e2.department_id = d.department_id
    WHERE d.department_name = 'SALES');

-- 9. Write a compound query to produce a list of employees showing raise percentages, employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise, 
-- employees in department 2 are given a 10% raise, employees in departments 4 and 5 are given a 15% raise, and employees in department 6 are not given a raise.

SELECT 
    '5%' AS raise_percentage,
    employee_id, salary
FROM employees 
WHERE department_id IN (100, 30)
UNION
SELECT 
    '10%' AS raise_percentage,
    employee_id, salary * 1.10 AS salary
FROM employees 
WHERE department_id = 50
UNION
SELECT 
    '15%' AS raise_percentage,
    employee_id, salary * 1.15 AS salary
FROM employees 
WHERE department_id IN (40, 50)
UNION
SELECT 
    '0%' AS raise_percentage, employee_id, salary
FROM employees 
WHERE department_id = 100;

-- 10. Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries. 
 select last_name, salary from employees
 order by salary  desc limit 3;

-- 11. Display the names of all employees with their salary and commission earned. Employees with a null commission should have O in the commission column 

select concat(first_name, ' ', last_NAME ) AS employees_name  , salary , coalesce(commission_pct ,'0')
from employees;


-- 12. Display the Managers (name) with top three salaries along with their salaries and 
-- department information.

SELECT 
    e.last_name AS manager_name, e.salary AS manager_salary,
    d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.job_id LIKE '%Mgr'
ORDER BY e.salary DESC
LIMIT 3;



-- *******///////Date Function*****************////////
-- 1) Find the date difference between the hire date and resignation_date for all the 
-- employees. Display in no. of days, months and year(1 year 3 months 5 days).
-- Emp_ID Hire Date Resignation_Date
-- 1 1/1/2000 7/10/2013
-- 2 4/12/2003 3/8/2017
-- 3 22/9/2012 21/6/2015
-- 4 13/4/2015 NULL
-- 5 03/06/2016 NULL
-- 6 08/08/2017 NULL
-- 7 13/11/2016 NULL

SELECT 
    emp_ID,
    Hire_Date,
    Resignation_Date,
    CONCAT(
        FLOOR(DATEDIFF(COALESCE(Resignation_Date, CURDATE()), Hire_Date) / 365), ' year ',
        FLOOR(MOD(DATEDIFF(COALESCE(Resignation_Date, CURDATE()), Hire_Date), 365) / 30.4375), ' months ',
        MOD(DATEDIFF(COALESCE(Resignation_Date, CURDATE()), Hire_Date), 30.4375), ' days'
    ) AS Date_Difference
FROM 
    datefunction;

-- 2) Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd, yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900) 
 
 SELECT 
    emp_ID,
    DATE_FORMAT(Hire_Date, '%m/%d/%Y') AS Formatted_Hire_Date,
    IFNULL(DATE_FORMAT(Resignation_Date, '%b %D, %Y'), '(Dec 01st, 1900)') AS Formatted_Resignation_Date
FROM datefunction;

-- 3) Calcuate experience of the employee till date in Years and months(example 1 year and 3 months)   

SELECT Employee_ID,
    CONCAT(
        TIMESTAMPDIFF(YEAR, Hire_Date, CURDATE()), ' years ',
        TIMESTAMPDIFF(MONTH, Hire_Date, CURDATE()) % 12, ' months'
    ) AS Experience
FROM 
    Employees;



-- 4) Display the count of days in the previous quarter .

SELECT 
    DATEDIFF(
        LAST_DAY(DATE_SUB(CURDATE(), INTERVAL QUARTER(CURDATE()) - 2 QUARTER)),
        DATE_SUB(DATE_SUB(CURDATE(), INTERVAL QUARTER(CURDATE()) - 2 QUARTER), INTERVAL DAYOFMONTH(DATE_SUB(CURDATE(), INTERVAL QUARTER(CURDATE()) - 2 QUARTER)) - 1 DAY)
    ) + 1 AS Days_In_Previous_Quarter;

-- 5) Fetch the previous Quarter's second week's first day's date 
SELECT
    DATE_SUB(
        DATE_SUB(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL QUARTER(CURDATE()) - 1 QUARTER)), 
            INTERVAL 13 DAY), 
        INTERVAL DAYOFWEEK(DATE_SUB(
            LAST_DAY(DATE_SUB(CURDATE(), INTERVAL QUARTER(CURDATE()) - 1 QUARTER)), 
            INTERVAL 13 DAY)) - 2 DAY) AS Previous_Quarter_Second_Week_First_Day;

-- 6) Fetch the financial year's 15th week's dates (Format: Mon DD YYYY) 
SELECT
    DATE_FORMAT(DATE_ADD(
        STR_TO_DATE(CONCAT(YEAR(CURDATE()), '-04-01'), '%Y-%m-%d'), 
        INTERVAL (15 * 7 - 1) DAY ), '%a %b %d %Y') AS Financial_Year_15th_Week_Date;

-- 7) Find out the date that corresponds to the last Saturday of January, 2015 using with clause. Use Airport database for the below two question: 

WITH RECURSIVE DateSequence AS (
  SELECT DATE('2015-01-31') AS Date
  UNION ALL
  SELECT DATE_SUB(Date, INTERVAL 1 DAY)
  FROM DateSequence
  WHERE DAYOFWEEK(Date) != 7
)
SELECT MAX(Date) AS Last_Saturday_of_January_2015
FROM DateSequence;

-- 8) Find the number of days elapsed between first and last flights of a passenger.

SELECT 
    DATEDIFF(MAX(start_date), MIN(end_date)) AS Days_Elapsed
FROM 
    job_history
WHERE 
    employee_id = 101;
    
-- 9) Find the total duration in minutes and in seconds of the flight from Rostov to Moscow.

SELECT 
    SEC_TO_TIME(SUM(TIME_TO_SEC(duration))) AS Total_Duration,
    SUM(TIME_TO_SEC(duration)) AS Total_Duration_Seconds
FROM 
    Flights
WHERE 
    departure_city = 'Rostov' AND arrival_city = 'Moscow';


