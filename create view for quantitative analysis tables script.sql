/*creates view for analysis purposes*/
create view  vwQuantitativeAnalysis as
select  a.dateActivity as date_a, a.abTestGroup, a.platform,
a.countryCode, a.userId as user_a, b.userId as user_b, 
b.dateactivity as date_b, b.productId,   
cast(b.cost as decimal(10,3)) cost 
from  donnie_test.data_Daily_Activity a left outer join
donnie_test.data_In_App_Purchases b on a.userId=b.userId;