insert into departments(department_name)
select distinct department_name
from report
where (department_name is not null);

update departments,locations,report
set departments.location_id=locations.location_id
where (report.street_address is not null) and (report.street_address=locations.street_address) and (report.DEPARTMENT_NAME=departments.department_name);

insert into locations(street_address, postal_code, city, state_province, country_id)
select distinct street_address, postal_code, city, state_province, country_id
from report
where (street_address is not null) and (postal_code is not null) and (city is not null) and (state_province is not null) and (country_id is not null);

insert INTO `employees` 
(first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct)
select distinct 
			FIRST_NAME,
			LAST_NAME,
			EMAIL,
			PHONE_NUMBER,
			HIRE_DATE,
			JOB_ID,
			SALARY,
			COMMISSION_PCT
from report;

update employees,departments,report
set employees.department_id=departments.department_id
where 
(report.FIRST_NAME=employees.first_name)and
(report.LAST_NAME=employees.last_name)and
(report.DEPARTMENT_NAME=departments.department_name);

update employees
set salary=salary+100
where job_id <> 'SA_MAN' and job_id<>'AC_MGR' and job_id<>'ST_MAN'and job_id<>'PU_MAN'and job_id<>'MK_MAN';

update employees
set email = concat(mid(employees.first_name,1,5),mid(employees.last_name,1,5));

update employees
set salary=salary*1.1
where department_id in (select department_id from(select department_id,count(department_id) as numb from employees group by department_id) as countTable
where numb>10);

