create database churn_customers;
use churn_customers;
select count(*) from churn;
/* Which is the age group with most exiting customers?*/
select  case when age<20 then "0-20" when age between 20 and 30 then "20-30"
when age between 30 and 40 then "30-40" when age between 40 and 50 then "40-50"
when age between 50 and 60 then "50-60" when age between 60 and 70 then "60-70"
when age between 70 and 80 then "70-80" when age>80 then "Above 80" END as age_range,
count(*) as Exited_Customers from churn where exited =1  group by age_range order by count(*) desc;

/* what is the average age of the customers leaving the bank*/
select  exited, gender,avg(age)from churn group by exited,gender;

/* Whether Gender plays a role for customers leaving the bank?*/
select gender,count(*) as exited_customers  from churn where exited=1 group by gender order by count(*);
select gender,case when exited=1 then 'Attrited'when exited=0 then 'Existing' end as status,
 count(*)  from churn  group by 1,2;

/* Does the tenure plays a role for customer attrition?*/
select max(balance) , min(balance) from churn;
select case when tenure<2 then "0-2" when tenure between 2 and 4 then "2-4"
when tenure between 4 and 6 then "4-6" when tenure between 6 and 8 then "6-8"
when tenure between 8 and 10 then "8-10" when tenure >10 then "above 10" end as tenure_range,
count(*) as exited_customers from churn where exited=1 group by tenure_range order by tenure_range;

select case when tenure<2 then "0-2" when tenure between 2 and 4 then "2-4"
when tenure between 4 and 6 then "4-6" when tenure between 6 and 8 then "6-8"
when tenure between 8 and 10 then "8-10" when tenure >10 then "above 10" end as tenure_range,
case when exited=1 then 'attrited' when exited=0 then 'existing' end as status,
count(*)  from churn  group by tenure_range,exited order by tenure_range;

/* Does acount balance play a role in customer attrition?"*/
select case when balance<25000 then "0-25000"  
 when balance between 25000 and 75000 then "25000-75000"
when balance between 75000 and 100000  then "75000-100000"
when balance>100000 then "above 100000" end as balance_range,
case when exited=0 then 'existing'
when exited=1 then 'attrited'end as status , count(*)  from churn
  group by balance_range,exited order by 1;
 select avg(balance) from churn;
 
 /* Whether having a credit card influences attrition?*/

  select case when hascrcard=0 then 'not' when hascrcard=1 then 'yes' end as crcard_status,
  case when exited=0 then 'existing' when exited=1 then 'attrited' end  as status, count(*)  from churn 
 group by hascrcard,exited  order by 2;
 
 
 /*active memeber*/
 select isactivemember, count(*) as exited_customers from churn where exited=1 group by isactivemember;


 /* credit score*/
 select creditscore, count(*) as count from churn where exited=1 group by creditscore;
 select max(creditscore) , min(creditscore) from churn;

  select case when creditscore<450  then "low" when creditscore between 450 and 750 then "medium" 
 when creditscore between 750 and 850 then "high" end as creditscore_range, exited as status,count(*)
 from churn  group by creditscore_range,exited order by 1;
 
 
 
 /* does geographical location effect customer churn?*/
 select  geography, ifnull(exited,'subtotal') as status ,count(*)  from churn  group by geography, exited with rollup;
 
 /*Does salary effect customer churn*/
 select max(estimatedsalary), avg(estimatedsalary), min(estimatedsalary) from churn;
  
  select case when estimatedsalary <25000 then "0-25000" when estimatedsalary between 25000 and 50000 then "25000-50000"
  when estimatedsalary >50000 then "above 50000" end as salary_range,exited as status, count(*) as count from churn
   group by salary_range,exited order by salary_range;

/*does num of products effect churn?*/
select numofproducts, count(*) as exited from churn where exited=1 group by numofproducts;
