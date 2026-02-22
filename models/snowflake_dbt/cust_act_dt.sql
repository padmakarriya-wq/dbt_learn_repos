{{ config(
    materialized='dynamic_table'
    , snowflake_warehouse = 'COMPUTE_WH'
    , database='SNOWFLAKE_DT_NEW'
    , target_lag = '1000 MINUTES'
    , schema='Transform_DT'
)}}

With Cust_Accessory_DT as 
(
select c.cust_id,c.cust_name,c.crid,c.location,c.cust_created_date,a.acc_id,a.acc_category,a.acc_status,a.price,a.acc_count,a.price / a.acc_count Price_Per_Accessory
from {{ ref('customer_DT') }} c,{{ ref('Accessory_dt') }} a where c.cust_id = a.cust_id

)
select * from Cust_Accessory_DT