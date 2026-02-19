{% macro check_nulls(tablename,column_list) %}
{% set null_conditions = [] %}

{% for col in column_list %}
    {% do null_conditions.append(col ~ ' IS NULL ') %}
{% endfor %}

select 
      *,
      CASE
      WHEN {{ null_conditions | join(' OR ') }} THEN 'FAIL'
      ELSE 'PASS'
      END AS null_check_status
FROM {{ tablename }}
{% endmacro %}
