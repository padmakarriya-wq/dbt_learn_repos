{{config(materialized='table',database='RAW_NEW',alias='DQ_NULL_CHECK_EXPENSE_CLAIMS')}}

with dq_check as
(
    {{check_nulls(ref('stg_expense_claims'),['claim_id','employee_id','claim_amount']) }}
)    

select * from dq_check
where null_check_status='FAIL'


