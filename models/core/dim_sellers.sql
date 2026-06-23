WITH sellers AS (
    SELECT * FROM {{ ref('stg_sellers') }}
),

geolocation AS (
    SELECT * FROM {{ ref('stg_geolocation') }}
),

final AS (
    SELECT
        s.seller_id,
        s.city                  AS seller_city,
        s.state                 AS seller_state,
        s.zip_code_prefix,
        g.latitude,
        g.longitude
    FROM sellers s
    LEFT JOIN geolocation g
        ON s.zip_code_prefix = g.zip_code_prefix
)

SELECT * FROM final


/* Entidad base (stg_sellers) enriquecida con coordenadas via geolocation
LEFT JOIN por zip_code_prefix para no perder sellers sin geolocation */