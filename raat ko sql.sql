--basic_sales_analysis
select * from dbo.first;

select count(*)[no. of columns] from dbo.first;

SELECT *
FROM dbo.first
WHERE transactions_id  IS NULL OR
sale_date  IS NULL OR sale_time  IS NULL OR customer_id  IS NULL OR 
gender  IS NULL OR age  IS NULL
OR category  IS NULL 
OR quantiy  IS NULL
OR price_per_unit  IS NULL
OR
cogs  IS NULL OR
total_sale IS NULL;

--remove all the null columns
DELETE from dbo.first where 
 transactions_id  IS NULL OR
sale_date  IS NULL OR sale_time  IS NULL OR customer_id  IS NULL OR 
gender  IS NULL OR age  IS NULL
OR category  IS NULL 
OR quantiy  IS NULL
OR price_per_unit  IS NULL
OR
cogs  IS NULL OR
total_sale IS NULL;

--data exploration
--Task 1 — Sales Performance Overview
--Give me a summary of total revenue, total units sold, and total COGS.
--I also want to know our gross profit margin. Don't just give me numbers — tell me if it looks healthy.

SELECT 
    SUM(total_sale) AS total_revenue,
    SUM(quantiy) AS total_units_sold,
    SUM(cogs * quantiy) AS total_cogs,
    
    (SUM(total_sale) - SUM(cogs * quantiy)) AS total_profit,
    
    ((SUM(total_sale) - SUM(cogs * quantiy)) * 100.0 
     / SUM(total_sale)) AS gross_profit_margin

FROM dbo.first;

--Task 2 — Category Analysis
--Which product category — Beauty, Clothing, or Electronics — is driving the most revenue?
--Which has the best profit margin? 
--Should we be investing more in any one category?

select * from dbo.first;

--most revenue
select category,
sum(total_sale) [total_revenue for each category]  ,
sum(quantiy * cogs) [cogs_value] ,
(((sum(total_sale)-sum(quantiy*cogs))/sum(total_sale))*100) [profit]
from dbo.first
group by category 
order by profit desc
;
--we got good profit margin from beauty products ,we can invest on it more

--Task 3 — Customer Demographics
--Break down sales by gender and age group (e.g. 18–25, 26–35, 36–50, 50+).
--Who is our most valuable customer segment? 
--Are there segments we're under-serving?

select * from dbo.first;
--most valueable customer agent
select gender,
sum(total_sale) [total_revenue by gender],
sum(quantiy * cogs) [cogs_value_gender] ,
(((sum(total_sale)-sum(quantiy*cogs))/sum(total_sale))*100) [profit_margin_gender]
from dbo.first 
group by gender
order by profit_margin_gender desc
;--profit margin from male product is higer which kinda suprising early we know that we got better
--profit margin beauty or we know normally that we cannnot associate beauty with man lets see what product male and female buying

--product bought by male
select category,
count(category) [category_count_male]
from dbo.first where gender='male'
 group by category 
 --product bought by female
select category,
count(category) [category_count_female]
from dbo.first where gender='female'
 group by category 

 --age and gender
 select * from dbo.first;

select gender,age,
sum(total_sale) [total_revenue_by_gender],
sum(quantiy * cogs) [cogs_value_gender] ,
(((sum(total_sale)-sum(quantiy*cogs))/sum(total_sale))*100) [profit_margin_gender]
from dbo.first 
where age between 18 and 24
group by gender,age
order by profit_margin_gender

select gender,
sum(total_sale) [total_revenue ],
sum(quantiy * cogs) [cogs_value] ,
(((sum(total_sale)-sum(quantiy*cogs))/sum(total_sale))*100) [profit_margin]
from dbo.first
where age between 18 and 24 
group by gender


select gender,
sum(total_sale) [total_revenue ],
sum(quantiy * cogs) [cogs_value] ,
(((sum(total_sale)-sum(quantiy*cogs))/sum(total_sale))*100) [profit_margin]
from dbo.first
where age between 25 and 35 
group by gender


select gender,
sum(total_sale) [total_revenue ],
sum(quantiy * cogs) [cogs_value] ,
(((sum(total_sale)-sum(quantiy*cogs))/sum(total_sale))*100) [profit_margin]
from dbo.first
where age between 36 and 46 
group by gender;


select gender,
sum(total_sale) [total_revenue ],
sum(quantiy * cogs) [cogs_value] ,
(((sum(total_sale)-sum(quantiy*cogs))/sum(total_sale))*100) [profit_margin]
from dbo.first
where age between 47 and 57
group by gender;


select gender,
sum(total_sale) [total_revenue ],
sum(quantiy * cogs) [cogs_value] ,
(((sum(total_sale)-sum(quantiy*cogs))/sum(total_sale))*100) [profit_margin]
from dbo.first
where age between 58 and 64 
group by gender
--better query
SELECT 
    gender,
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
    END AS age_group,

    SUM(total_sale) AS revenue,
    SUM(quantiy * cogs) AS total_cogs,
    
    (SUM(total_sale) - SUM(quantiy * cogs)) AS profit,

    ((SUM(total_sale) - SUM(quantiy * cogs)) * 100.0 
     / SUM(total_sale)) AS profit_margin

FROM dbo.first
GROUP BY 
    gender,
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
    END
ORDER BY revenue DESC;
---highest profit margin happen at the age bracket of 18 - 24

--yes the underserving from feamle age 16-36
--and female 57-64 age range


--Task 4 — Time Trends
--Sales are spread across 2022 and 2023.
--Is our revenue growing year over year?
--Are there any months or seasons where sales spike or drop?
select * from dbo.first

select max(sale_date) [max_date],min(sale_date) [min_date] from dbo.first

select YEAR(sale_date) as year ,
SUM(total_sale) AS total_revenue,
    SUM(quantiy) AS total_units_sold,
    SUM(cogs * quantiy) AS total_cogs,
    
    (SUM(total_sale) - SUM(cogs * quantiy)) AS total_profit,
    
    ((SUM(total_sale) - SUM(cogs * quantiy)) * 100.0 
     / SUM(total_sale)) AS gross_profit_margi
from dbo.first  group by YEAR(sale_date)
--there is diffenetly a spike in our revenus and profit_margin from previus year
select * from dbo.first
select 
MONTH(sale_date) as month,
YEAR(sale_date) as year,DAY(sale_date) as Day,total_sale
from dbo.first where total_sale=2000
select 
MONTH(sale_date) as month,
YEAR(sale_date) as year,DAY(sale_date) as Day,total_sale
from dbo.first where total_sale=25

select 
MONTH(sale_date) as month,
count(total_sale) [max_sale]
from dbo.first where total_sale=2000 group by MONTH(sale_date)
order by count(total_sale) Desc


select 
MONTH(sale_date) as month,
count(total_sale) [min_sale]
from dbo.first where total_sale=25 group by MONTH(sale_date) 
order by count(total_sale)  Desc
--better query
SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    
    SUM(total_sale) AS revenue,
    SUM(quantiy) AS units_sold,
    
    ((SUM(total_sale) - SUM(cogs * quantiy)) * 100.0 
     / SUM(total_sale)) AS profit_margin

FROM dbo.first
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month;
--we got to know that on december month sale peak more time 
--where  in october min_sale peak

--Task 5 — High-Value Transactions
--Identify our top 5 transactions by total sale. 
--What do they have in common — category, gender, age?
--Can we learn anything about what drives big purchases?
select * from dbo.first;

select TOP 5 transactions_id,gender,category,total_sale,age from dbo.first order by total_sale Desc
--The top 5 transactions are dominated by the Electronics category, indicating high-value purchases are concentrated in durable goods.
--The majority of these transactions are from [gender result], suggesting a skew in high-value buyers.
--The age range of high-value customers lies between X–Y years, indicating that mid-to-older age groups are more likely to make large purchases.

--Task 6 — Pricing & Quantity Insight
--Are higher price_per_unit items selling in lower quantities?
--Is there a sweet spot in pricing that maximizes revenue?
select * from dbo.first
select TOP 5 category,total_sale,price_per_unit,quantiy from dbo.first order by price_per_unit desc

select TOP 5 category,total_sale,price_per_unit,quantiy from dbo.first order by price_per_unit 

select sum(total_sale) [Revenue],price_per_unit,sum(quantiy) [total_quantiy],
sum(quantiy * cogs) [cogs_value] ,
(((sum(total_sale)-sum(quantiy*cogs))/sum(total_sale))*100) [profit_margin]
from dbo.first group by price_per_unit

--better query
SELECT 
    CASE 
        WHEN price_per_unit < 50 THEN 'Low Price'
        WHEN price_per_unit BETWEEN 50 AND 200 THEN 'Medium Price'
        ELSE 'High Price'
    END AS price_bucket,

    SUM(total_sale) AS revenue,
    SUM(quantiy) AS total_quantity,
    
    AVG(quantiy) AS avg_quantity,
    
    ((SUM(total_sale) - SUM(cogs * quantiy)) * 100.0 
     / SUM(total_sale)) AS profit_margin

FROM dbo.first
GROUP BY 
    CASE 
        WHEN price_per_unit < 50 THEN 'Low Price'
        WHEN price_per_unit BETWEEN 50 AND 200 THEN 'Medium Price'
        ELSE 'High Price'
    END
ORDER BY revenue DESC;
--high price gives better returns