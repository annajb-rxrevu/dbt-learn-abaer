select
    o.order_id,
    o.customer_id,
    sum(p.payment_amount_usd) as order_amount

from {{ref('stg_orders')}} o
left join {{ref('stg_payments')}} p
where p.payment_status != 'fail'
group by o.order_id, o.customer_id