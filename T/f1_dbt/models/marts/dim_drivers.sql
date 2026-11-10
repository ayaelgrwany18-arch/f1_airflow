select
    driver_code,
    max(driver_name) as driver_name,
    max(nationality) as nationality
from {{ ref('stg_drivers') }}
group by driver_code
