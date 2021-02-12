with orders as  (
    select * from {{ ref('stg_orders' )}}
),
payments as (
    select * from {{ ref('stg_payments') }}
),
order_payments as (
    select
        order_id,
        sum(case when payment_status = 'success' then payment_amount_usd end) as order_amount_usd
    from payments
    group by 1
),
final as (
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce(order_payments.order_amount_usd, 0) as order_amount_usd
    from orders
    left join order_payments using (order_id)
)
select * from final