select distinct
    year::int                   as season,
    driver_first_name || ' ' || driver_last_name as driver_name,
    driver_short_name           as driver_code,
    driver_nationality          as nationality,
    team,
    nullif(pts, '')::numeric    as season_points
from {{ source('f1', 'raw_drivers') }}
