WITH ranked_claims AS (
    SELECT
        claim_id,
        employee_id,
        claimdate,
        expense_type,
        claim_amount,
        currency,
        approval_status,
        approval_id,
        ROW_NUMBER() OVER (PARTITION BY claim_id ORDER BY claimdate DESC) AS rn
    FROM RAW_NEW.STAGING.EXPENSE_CLAIMS
)

SELECT
    claim_id,
    employee_id,
    claimdate,
    UPPER(expense_type) AS expense_type,
    claim_amount,
    currency,
    LOWER(approval_status) AS approval_status,
    approval_id
FROM ranked_claims
WHERE rn = 1