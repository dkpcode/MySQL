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

/*updated cost column setting NA value to nulls */
update donnie_test.data_in_app_purchases
set cost = null
where cost = 'NA';


/*create index on in_app_purchases userids*/
create index usr on donnie_test.data_in_app_purchases(userid);

/*create index on daily activity userids*/
create index usr1 on donnie_test.data_daily_activity(userid);
