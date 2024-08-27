WITH source AS (
    SELECT *
    FROM {{ref("stg_raw__sales")}}
    JOIN {{ref("stg_raw__product")}}
    USING(products_id)
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
    ROUND(SUM(revenue) - SUM(CAST(purchase_price AS FLOAT64) * quantity), 2) AS margin
FROM renamed
WHERE orders_id = 1002561
GROUP BY orders_id
