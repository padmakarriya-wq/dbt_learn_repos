{{ config(
    materialized='dynamic_table',
    snowflake_warehouse = 'COMPUTE_WH',
    database='SNOWFLAKE_DT',
    schema='TRANSFORM_DT',
    target_lag = 'DOWNSTREAM'
) }}

with customers_dt as (

    select 
        cust_id,
        cust_name,
        total_outstanding_amt,
        crid,
        location,
        cust_created_date
    from SNOWFLAKE_DT.PUBLIC.customer

    qualify row_number() 
        over (
            partition by cust_id  
            order by cust_created_date desc
        ) = 1

)

select * from customers_dt
