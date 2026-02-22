{{config(
    materialized='table',
    schema='clenasing'
)}}

WITH base AS (
    SELECT * FROM {{ ref('staged_ranked_claims') }}
),

dq_check AS (
    SELECT *,
        CASE 
            WHEN ({{ check_null_conditions(['claim_id', 'employee_id', 'claim_amount']) }}) THEN 'FAIL'
            ELSE 'PASS'
        END AS dq_status,
        CASE
            WHEN claim_amount > 10000 AND expense_type IN ('TRAVEL', 'HOTEL') THEN 'VIOLATION'
            ELSE 'OK'
        END AS policy_violation_flag
    FROM base
)

SELECT
    claim_id,
    employee_id,
    claimdate,
    expense_type,
    claim_amount,
    currency,
    approval_status,
    approval_id,
    dq_status,
    policy_violation_flag
FROM dq_check
WHERE dq_status = 'PASS'
