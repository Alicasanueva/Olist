WITH products AS (
    SELECT * FROM {{ ref('stg_products') }}
),

translations AS (
    SELECT * FROM {{ ref('stg_category_translation') }}
),

final AS (
    SELECT
        p.product_id,
        p.product_category_name,
        COALESCE(t.product_category_name_english, 'unknown') AS product_category_english,    -- si una categoría no tiene traducción al inglés, en vez de dejar NULL pones 'unknown'. Así el dashboard nunca muestra vacíos
        p.product_name_length,
        p.product_description_length,
        p.product_photos_qty,
        p.product_weight_g,
        p.product_length_cm,
        p.product_height_cm,
        p.product_width_cm
    FROM products p
    LEFT JOIN translations t                        --  join con la traducción. conservo todos los productos aunque no tengan traducción
        ON p.product_category_name = t.product_category_name
)

SELECT * FROM final