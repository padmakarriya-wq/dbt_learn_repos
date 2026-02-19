
select claim_id, 
       employee_id, 
       claimdate,
       upper(expense_type) as expense_type,
       claim_amount,
       currency,
       approval_status,
       approval_id
from expense_claims