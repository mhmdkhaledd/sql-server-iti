/*1.	Display (Using Union Function)
a.	 The name and the gender of the dependence that's gender is Female and depending on Female Employee.
b.	 And the male dependence that depends on Male Employee.*/


select Dependent_name , d.Sex 
from Dependent d join Employee e
on d.ESSN=e.SSN
where  e.Sex='f' and d.Sex='f'

union 

select Dependent_name , d.Sex 
from Dependent d join Employee e
on d.ESSN=e.SSN
where  e.Sex='m' and d.Sex='m'



/*2.	For each project, list the project name and the total hours per week (for all employees) spent on that project.*/

select  sum(hours) as sum_hours ,pname 
from Project p join Works_for w
on p.Pnumber=w.Pno
group by Pname


/*3.	Display the data of the department which has the smallest employee ID over all employees' ID.*/

select d.*
from Departments d join Employee e
on d.Dnum=e.Dno
where e.SSN =(select min(SSN) from Employee)

/*4.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.*/


select dname,max(salary) as max_salary , min(salary) as min_salary , avg(salary) as avg_salary
from Employee e join Departments d
on e.Dno=d.Dnum
group by dname


/*5.	List the last name of all managers who have no dependents.*/

select lname
from Employee e  join Departments d
on e.SSN=d.MGRSSN
where d.MGRSSN not in (select essn from Dependent)


/*6.	For each department-- if its average salary is less than the average salary of all employees-- display its number, name and number of its employees.*/

select dnum , dname ,count(e.SSN) as emp_number
from Departments d join Employee e
on d.Dnum=e.Dno
group by dnum , dname 
having AVG(e.Salary)<all(select AVG(salary) from Employee)

/*7.	Retrieve a list of employees and the projects they are working on ordered by department and within each department, ordered alphabetically by last name, first name.*/

select e.Fname ,e.Lname , Pname 
from Employee e join Departments d
on e.Dno=d.Dnum
join Project p on p.Dnum=d.Dnum
order by  d.Dnum ,2,1


/*8.	Try to get the max 2 salaries using subquery*/

select top 2 salary from Employee order by Salary desc

----
select max(salary)
from Employee

union all

select MAX(salary)
from Employee
where Salary not in (select max(Salary) from Employee)


/*9.	Get the full name of employees that is similar to any dependent name*/

select fname + ' ' +lname as full_name
from Employee
where fname + ' '+lname in (select Dependent_name from Dependent )

/*10.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30% */

update Employee set Salary = salary *1.3
where SSN in (select essn from Works_for join Project on Pno =Pnumber where Pname='Al Rabwah')
