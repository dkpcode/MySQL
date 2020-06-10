/*--sum of total spent by group*/
select abtestgroup, sum(cost) total_spent  
from vwQuantitativeAnalysis
group by abTestGroup;

/*when each country spent the most*/
select abTestGroup,date_b,sum(cost) t_spent_by_date 
from vwQuantitativeAnalysis
group by abTestGroup,date_b
order by date_b desc, sum(cost) desc, abTestgroup desc;
  
/*which country spent the most(sum by country code*/
select  countrycode, sum(cost) total 
from vwQuantitativeAnalysis
group by countrycode
order by 2 desc;

/*country with most active users*/
select count(user_a) active_usr_cnt ,countrycode 
from vwQuantitativeAnalysis
where user_b is not null
group by countryCode
order by 1 desc, 2 desc;


