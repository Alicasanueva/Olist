WITH order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),

orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
),

final AS (
    SELECT
        oi.order_id,
        oi.order_item_id,
        oi.product_id,
        oi.seller_id,
        o.customer_id,
        c.customer_unique_id,
        oi.price,
        oi.freight_value,
        oi.price + oi.freight_value     AS total_item_value,
        oi.shipping_limit_at
    FROM order_items oi
    LEFT JOIN orders o
        ON oi.order_id = o.order_id
    LEFT JOIN customers c
        ON o.customer_id = c.customer_id
)

SELECT * FROM final


/*Grain: una fila = una línea de orden — si una orden tiene 3 productos, hay 3 filas
Foreign keys — product_id, seller_id, customer_id, order_id son los "puntos" del star que conectan con las dimensiones
total_item_value — primera métrica: price + freight_value
customer_unique_id — lo traes desde stg_customers para poder conectar con dim_customers*/