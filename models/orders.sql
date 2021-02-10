select
    o.order_id,
    o.customer_id,
    sum(p.amount) as order_amount

from {{ref('stg_orders')}} o
left join {{ref('stg_payments')}} p
group by o.order_id, o.customer_id