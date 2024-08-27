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
    products_id,
    date_date,
    revenue,
    quantity,
    purchase_price,
    ROUND((revenue - (CAST(purchase_price AS FLOAT64) * quantity)),2) as margin
FROM renamed