/*This code builds the two tables to load the csv files*/
drop table if exists donnie_test.data_daily_activity;
CREATE TABLE if not exists donnie_test.data_daily_activity(
id INT NOT NULL auto_increment,
dateActivity date NULL,
abTestGroup	varchar(20) NULL,
platform varchar(50) NULL,	
countryCode	char(50) NULL,
userId varchar(50) NULL,
primary key (ID)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data_daily_activity.csv'
IGNORE
INTO TABLE donnie_test.data_daily_activity
fields terminated by ','
LINES terminated by '\n'
IGNORE 1 ROWS	
(dateActivity, abTestGroup, platform, countryCode, userId);

drop TABLE if exists Donnie_Test.data_in_app_purchases;
CREATE TABLE if not exists Donnie_Test.data_in_app_purchases(
id INT NOT NULL auto_increment,
dateActivity date NULL,
productId varchar(100) NULL,
cost varchar(50) NULL,
userId varchar(50) NULL,
primary key (ID)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data_in_app_purchases.csv'
IGNORE
INTO TABLE donnie_test.data_in_app_purchases
fields terminated by ',' 
LINES terminated by '\n'
IGNORE 1 ROWS	
(dateActivity, productId, cost, userId);

/*create index on in_app_purchases userids*/
create index usr on donnie_test.data_in_app_purchases(userid);

/*create index on daily activity userids*/
create index usr1 on donnie_test.data_daily_activity(userid);


/*turns off restriction*/
set session sql_mode = '';

/*create temp table with all records*/
drop temporary table if exists donnie_test.combined;

/*creates temp table with all records*/
create temporary table if not exists Donnie_test.combined as
select  a.dateActivity as date_a, a.abTestGroup, a.platform,
a.countryCode, a.userId as user_a, b.userId as user_b, 
b.dateactivity as date_b, b.productId,   
cast(replace(b.cost,'NA', 0.000) as decimal(10,3)) cost 
from  donnie_test.data_Daily_Activity a left outer join
donnie_test.data_In_App_Purchases b on a.userId=b.userId;

/*--sum of total spent by group*/
select abtestgroup, sum(cost) total_spent  
from donnie_test.combined
group by abTestGroup;

/*when each country spent the most*/
select abTestGroup,date_b,sum(cost) t_spent_by_date 
from donnie_test.combined
where cost is not null
group by abTestGroup,date_b
order by date_b desc, sum(cost) desc, abTestgroup desc;
  
/*which country spent the most(sum by country code*/
select  countrycode, sum(cost) total 
from donnie_test.combined
group by countrycode
order by 2 desc;

/*country with most active users*/
select count(user_a) active_usr_cnt ,countrycode 
from donnie_test.combined
where user_b is not null
group by countryCode
order by 1 desc, 2 desc;

call spRunQuantitativeAnalysis;
select * from vquantitativeanalysisdata;


