install.packages("RODBC");
library(RODBC);
obj <- odbcConnect("Prod", uid="etldev", pwd="Cvsl$%^") ;
#write a query
res <- sqlQuery(obj, "select advertiser_account_key as ACC,sum(ifnull(spend,0)) as burn,ifnull(sum(conversions)/sum(billed_clicks),0) as CVR from demand_fact where day_key = (select day_key from date_dim where current_indicator  = 'Y') group by 1");
#query
x <- sqlQuery(obj,"select * from (select advac.account_name as 'advertiser', advac.customer_segment as 'customer segment', (( SUM(L)/ (SUM(M) + SUM(N))) * 100) as 'CVR', (SUM(A) * 1000 / SUM(B)) as 'eCPM', (((SUM(I) + SUM(J))/ SUM(K)) * 100 ) as 'CTR', sum(spend) as 'Total Burn' from account_dim as advac, (select sum(conversions) as L, sum(billable_clicks) as M, sum(cpm_clicks) as N, sum(spend) as A, sum(ad_impressions) as B, sum(billable_clicks) as I, sum(cpm_clicks) as J, sum(ad_impressions) as K, sum(spend) as spend, advertiser_account_key from agg_day_adv_country_fact where day_key in (select day_key from date_dim where full_date between '2014-03-24' and '2014-03-24') group by advertiser_account_key) as fact where advac.account_key = fact.advertiser_account_key group by advac.account_name, advac.customer_segment order by (( SUM(L)/ (SUM(M) + SUM(N))) * 100) desc)a where ctr is not null and cvr is not null and eCPM is not null ");

x <- sqlQuery(obj,"select publisher_account_key,
                    sum(case when device_type_id =  3 then ifnull(billed_clicks,0) else 0 end)*100/sum(case when device_type_id =  3 then  ifnull(ad_impressions,0) else 0 end) as tctr,
                    sum(case when device_type_id =  1 then ifnull(billed_clicks,0) else 0 end)*100/sum(case when device_type_id =  1 then  ifnull(ad_impressions,0) else 0 end) as sctr,
                    sum(case when device_type_id =  3 then ifnull(spend,0) else 0 end) as 'tburn',
                    sum(case when device_type_id = 1 then ifnull(spend,0) else 0 end) as 'sburn'
                    from supply_fact a,device_type_dim b
                    where a.device_type_key = b.device_type_key and day_key = (select day_key from date_dim where current_indicator = 'Y') and device_type_id in (1,3) group by 1
                    having (tburn + sburn) > 100 and tburn > 100 and sburn > 100");

y <- sqlQuery(obj,"                    select advertiser_account_key,
                    sum(case when device_type_id =  3 then ifnull(billed_clicks,0) else 0 end)*100/sum(case when device_type_id =  3 then  ifnull(ad_impressions,0) else 0 end) as tctr,
                    sum(case when device_type_id =  1 then ifnull(billed_clicks,0) else 0 end)*100/sum(case when device_type_id =  1 then  ifnull(ad_impressions,0) else 0 end) as sctr,
                    sum(case when device_type_id =  3 then ifnull(spend,0) else 0 end) as 'tburn',
                    sum(case when device_type_id = 1 then ifnull(spend,0) else 0 end) as 'sburn'
                    from demand_fact a,device_type_dim b
                    where a.device_type_key = b.device_type_key and day_key = (select day_key from date_dim where current_indicator = 'Y') and device_type_id in (1,3) group by 1
                    having (tburn + sburn) > 100 and tburn > 100 and sburn > 100;");
#advertiser CTR analysis
boxplot(y$tctr,y$sctr);
ydiff <- y$sctr- y$tctr;