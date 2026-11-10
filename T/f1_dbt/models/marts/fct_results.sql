select
    r.race_url,
    ra.race_year,
    ra.grand_prix,
    r.driver_code,
    r.team as team_name,
    r.finish_position,
    r.position_text,
    r.laps,
    r.points
from {{ ref('stg_results') }} r
left join {{ ref('stg_races') }} ra
    on r.race_url = ra.race_url
    