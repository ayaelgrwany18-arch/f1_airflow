select distinct
    url                         as race_url,
    pos                         as position_text,
    case when pos  ~ '^[0-9]+$'    then pos::int           end as finish_position,
    case when no   ~ '^[0-9.]+$'   then no::numeric::int   end as car_number,
    driver_first_name || ' ' || driver_last_name as driver_name,
    driver_short_name           as driver_code,
    team,
    case when laps ~ '^[0-9.]+$'   then laps::numeric::int end as laps,
    time_retired,
    case when pts  ~ '^[0-9.]+$'   then pts::numeric       end as points
from {{ source('f1', 'raw_results') }}