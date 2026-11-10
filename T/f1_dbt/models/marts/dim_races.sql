select
    race_url,
    race_year,
    grand_prix,
    race_date,
    winner_name,
    winner_team
from {{ ref('stg_races') }}
