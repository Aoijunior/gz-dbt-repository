WITH campaigns_data AS (
    SELECT
        date_date,
        ads_cost,
        impression,
        click
    FROM {{ ref('int_campaigns_day') }}
),

finance_data AS (
    SELECT
        *
    FROM {{ ref('finance_days') }}
)

-- Unir los datos de campañas con los datos financieros
SELECT
    c.date_date,
    -- Calcular ads_margin
    f.operational_margin - c.ads_cost AS ads_margin,
    f.average_basket,
    f.operational_margin,
    c.impression,
    c.click,
    c.ads_cost

FROM campaigns_data c
LEFT JOIN finance_data f
ON c.date_date = f.date_date
ORDER BY date_date DESC
