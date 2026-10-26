 Power BI Measures (DAX)

Create these measures after validating the table and column names. These examples assume the relationships described in Section 4.

Total Sales

Total Sales =
SUMX (
    order_items,
    order_items[quantity] * order_items[unit_price]
)

Delivered Orders

Delivered Orders =
CALCULATE (
    DISTINCTCOUNT ( orders[order_id] ),
    orders[order_status] = "delivered"
)

Average Order Value

Average Order Value =
DIVIDE ( [Total Sales], [Delivered Orders], 0 )

Total Quantity Sold

Total Quantity Sold =
SUM ( order_items[quantity] )

Total Customers

Total Customers =
DISTINCTCOUNT ( customers[customer_id] )

Repeat Customers

Repeat Customers =
COUNTROWS (
    FILTER (
        VALUES ( customers[customer_id] ),
        CALCULATE ( DISTINCTCOUNT ( orders[order_id] ) ) > 1
    )
)

Cancelled Orders

Cancelled Orders =
CALCULATE (
    DISTINCTCOUNT ( orders[order_id] ),
    orders[order_status] = "cancelled"
)

Cancellation Rate

Cancellation Rate =
DIVIDE ( [Cancelled Orders], DISTINCTCOUNT ( orders[order_id] ), 0 )
