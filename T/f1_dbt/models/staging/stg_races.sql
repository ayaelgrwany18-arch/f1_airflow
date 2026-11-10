select distinct
    year::int                    as race_year,
    grand_prix,
    url                          as race_url,
    date                         as race_date,
    winner_driver_first_name || ' ' || winner_driver_last_name as winner_name,
    winner_driver_short_name     as winner_code,
    winner_team,
    case when winner_laps ~ '^[0-9.]+$' then winner_laps::numeric::int end as winner_laps,
    winner_time
from {{ source('f1', 'raw_races') }}