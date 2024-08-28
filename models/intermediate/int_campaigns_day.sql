WITH base_data AS (
    SELECT
        date_date,
        ROUND(SUM(ads_cost), 2) AS ads_cost,
        ROUND(SUM(impression), 2) AS impression,
        ROUND(SUM(click), 2) AS click
    FROM {{ ref('int_campaigns') }}
    GROUP BY
        date_date
)

SELECT
    *
FROM base_data
