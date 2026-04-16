{% macro test_at_least_one_row(model) %}

-- This test FAILS if the table is empty (row count = 0)
-- This test PASSES if row count > 0

select 1
from {{ model }}
having count(*) = 0

{% endmacro %}