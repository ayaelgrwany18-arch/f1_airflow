select
    race_year,
    team_name,
    sum(points)                                 as total_points,
    count(*) filter (where finish_position = 1) as wins,
    rank() over (partition by race_year order by sum(points) desc nulls last) as season_rank
from {{ ref('fct_results') }}
group by race_year, team_name