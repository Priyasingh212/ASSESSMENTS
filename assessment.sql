
/********************************************assessment**************************************************/

use hr;
create table assessment(
 worker_id int,
 first_name varchar(30),
 last_name varchar(50),
 salary int,
 joinig_date timestamp,
 department varchar(50));
 insert into assessment (worker_id, first_name, last_name, salary, joinig_date, department)
values (1, 'monika', 'arora', 10000, '2021-2-20 9:00', 'hr'), 
(2, 'niharika', 'verma', 8000, '2021-2-16 11:00', 'admin'),
(3, 'vishal', 'singhal', 17000, '2021-2-21 6:00', 'hr'), 
(4, 'amitabh', 'singh', 15000, '2021-4-20 8:00', 'admin'), 
(5, 'vivek', 'bhati', 40000, '2021-2-13 9:00', 'admin'), 
(6, 'vipul', 'dubay', 50000, '2021-6-20 11:00', 'account'), 
(7, 'sachin', 'duabay', 75000, '2023-2-20 7:00', 'account'), 
(8, 'priya', 'rathore', 9000, '2021-6-20 10:00', 'admin');

 select * from assessment;


-- 1. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending. 

   select * from assessment
   order by first_name asc ,  department desc;

-- 2.Write an SQL query to print details for Workers with the first names from the Worker table. “Vipul” and “Satish” 

select * from assessment 
where first_name in ('vipul', 'sachin');


-- 3. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘n’ and contains six alphabets.
   select * from assessment 
   where first_name like '_____n';


-- 4. Write an SQL query to print details of the Workers whose SALARY lies between 8000 to 20000.alter

select * from assessment 
where salary between 8000  and 20000; 

-- 5. Write an SQL query to fetch duplicate records having matching data in some fields of a table. 
select first_name, last_name, department, count(*) from assessment
group by first_name, last_name, department  
having count(*) >1;

-- 6. Write an SQL query to show the top 6 records of a table.
   select distinct * from assessment
   order by  salary desc
   limit 6;

-- 7. Write an SQL query to fetch the departments that have less than five people in them. 
    select department , count(*) as no_of_people from assessment
    group by department
    having count(*) < 5;

-- 8. Write an SQL query to show all departments along with the number of people in there. 

 select department, count(department) from assessment
 group by department;

-- 9. Write an SQL query to print the name of employees having the highest salary in each department.
    select first_name, salary , department from assessment
    group by first_name, salary , department
    order by salary desc  limit 1;


