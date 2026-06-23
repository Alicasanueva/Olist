WITH customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
),

geolocation AS (
    SELECT * FROM {{ ref('stg_geolocation') }}
),

final AS (
    SELECT
        c.customer_id,
        c.customer_unique_id,
        c.city                  AS customer_city,
        c.state                 AS customer_state,
        c.zip_code_prefix,
        g.latitude,
        g.longitude
    FROM customers c
    LEFT JOIN geolocation g
        ON c.zip_code_prefix = g.zip_code_prefix
)

SELECT * FROM final

