WITH source AS (
    SELECT *
    FROM {{ref("int_orders_margin")}}
    JOIN {{ref("stg_raw__ship")}}
    USING(orders_id)
), renamed AS (
    SELECT
        orders_id,
        date_date,
        revenue,
        quantity,
        purchase_cost, -- Convertir purchase_price a FLOAT64
        margin, -- Convertir purchase_price a FLOAT64
        CAST(shipping_fee AS FLOAT64) AS shipping_fee, -- Convertir shipping_fee a FLOAT64
        CAST(logcost AS FLOAT64) AS logcost, -- Convertir logcost a FLOAT64
        CAST(ship_cost AS FLOAT64) AS ship_cost -- Convertir ship_cost a FLOAT64
    FROM source
)

SELECT 
    orders_id,
    MAX(date_date) AS date_date, -- Usar MAX para la fecha más reciente
    sum(revenue) AS revenue,
    SUM(quantity) AS quantity,
    SUM(purchase_cost) AS purchase_cost,
    SUM(margin) AS margin,
    ROUND(SUM(margin + shipping_fee - logcost - ship_cost), 2) AS operational_margin
FROM renamed
GROUP BY orders_id
