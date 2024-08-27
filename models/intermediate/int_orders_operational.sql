WITH source AS (
    SELECT *
    FROM {{ref("int_orders_margin")}}
    JOIN {{ref("stg_raw__ship")}}
    USING(orders_id)
), renamed AS (
    SELECT *
    FROM source
)

SELECT 
    orders_id,
    MAX(date_date) AS date_date, -- Ejemplo usando MAX
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(quantity),2) AS quantity,
    ROUND(SUM(purchase_price * quantity),2) AS purchase_cost,
    ROUND(SUM(revenue) - SUM(CAST(purchase_price AS FLOAT64) * quantity), 2) AS margin,
    ROUND(SUM(margin + shipping_fee - logcost -ship_cost), 2) AS operational_margin
FROM renamed
WHERE orders_id = 1002561
GROUP BY orders_id