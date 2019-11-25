-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "dept_no" varchar(10)   NOT NULL,
    "dept_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "gener" varchar(5)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Dept_Emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(30)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_Dept_Emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(30)   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no","from_date","to_date"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no","from_date","to_date"
     )
);
drop table "Titles"

CREATE TABLE "Titles" (
    "emp_no" int   NOT NULL,
    "title" varchar(100)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "emp_no","title","from_date","to_date"
     )
);

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");
Alter table "Titles" ADD Constraint Primary Key(from_date)

select * from "dept_manager"

--#1
--#Employees and salaries 
Select e.first_name, e.last_name, e.emp_no, e.gener, s.salary
from "Employees" e
left join "Salaries" s
on e.emp_no = s.emp_no;

--#2
--Employees hired in 1986
Select e.first_name, e.last_name, e.emp_no, e.gener, s.salary, e.hire_date
from "Employees" e
left join "Salaries" s
on e.emp_no = s.emp_no
where to_char(e.hire_date,'YYYY') = '1986';


--#3
-- Managers 
select d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, m.from_date as "promotion_date", e.hire_date,m.to_date
from "dept_manager" m
left join "Employees" e
on m.emp_no = e.emp_no
left join "Departments" d
on d.dept_no = m.dept_no;
--Where m.from_date = e.hire_date
--commented line shows 9 employees hired as manager 

--#4
--Employee with department
select de.emp_no, e.last_name, e.first_name, d.dept_name
from "Dept_Emp" de
left join "Employees" e
on e.emp_no = de.emp_no
left join "Departments" d
on d.dept_no = de.dept_no
order by emp_no

--#5
--#Hurcules and B names
select * from "Employees"
where first_name = 'Hercules'
and last_name like 'B%'

--6
--Sales Department
select de.emp_no, e.first_name,e.last_name, d.dept_name
from "Dept_Emp" de
left join "Employees" e
on de.emp_no = e.emp_no
left join "Departments" d
on d.dept_no = de.dept_no
where d.dept_name = 'Sales'

--#7
--Sales and Development Departments
select de.emp_no, e.first_name,e.last_name, d.dept_name, t.title
from "Dept_Emp" de
left join "Employees" e
on de.emp_no = e.emp_no
left join "Departments" d
on d.dept_no = de.dept_no
left join "Titles" t
on e.emp_no = t.emp_no
where d.dept_name in ('Sales','Development')

--#8
--Employees sharing last name
select count(emp_no) as "Count", last_name as "Last Name"
from "Employees"
group by "Last Name"
order by "Count" desc;
