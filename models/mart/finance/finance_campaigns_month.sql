WITH monthly_data AS (
    SELECT
        FORMAT_DATE('%Y-%m-01', date_date) AS datemonth,  -- Extraer el mes en formato YYYY-MM
        SUM(ads_margin) AS ads_margin,       -- Sumar el ads_margin por mes
        ROUND(SUM(average_basket),2) AS average_basket,     -- Promediar la cesta promedio por mes
        SUM(operational_margin) AS operational_margin,  -- Sumar el margen operativo por mes
        SUM(impression) AS impression,       -- Sumar las impresiones por mes
        SUM(click) AS click,                 -- Sumar los clics por mes
        SUM(ads_cost) AS ads_cost            -- Sumar el costo de los anuncios por mes
    FROM {{ ref('finance_campaigns_day') }}
    GROUP BY datemonth
)

SELECT
    datemonth,
    ads_margin,
    average_basket,
    operational_margin,
    impression,
    click,
    ads_cost
FROM monthly_data
ORDER BY datemonth DESC
