select
    f.race_year,
    d.driver_name,
    f.driver_code,
    sum(f.points)                                 as total_points,
    count(*) filter (where f.finish_position = 1) as wins,
    rank() over (partition by f.race_year order by sum(f.points) desc nulls last) as season_rank
from {{ ref('fct_results') }} f
left join {{ ref('dim_drivers') }} d
    on f.driver_code = d.driver_code
group by f.race_year, d.driver_name, f.driver_code