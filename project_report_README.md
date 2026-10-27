#E-Commerce Sales & Customer Analytics

The objective of this project is to analyze e-commerce sales and customer data using SQL Server to understand business performance, customer purchasing behavior, product performance, and revenue trends.

    .The project aims to identify key business insights by analyzing total revenue, order volume, average order value, top-selling products, high-performing   categories, customer lifetime value, repeat purchases, and customer churn
    .The purpose was to transform raw data into meaningful business insights and provide recommendations that help improve sales, customer retention, and business decision-making.


## Business Problem and Objectives

    Monitor sales and order performance over time.

    Identify categories and products contributing the most sales.

    Understand customer reach, repeat purchasing, and city-level performance.

    Track delivered and cancelled orders and monitor the cancellation rate.

    Provide an interactive dashboard that supports business decisions through year, city, category, and gender filters.

## Key business questions addressed:
    - What are the total revenue, orders, customers, and products?
    - Which products and categories generate the highest sales?
    - Who are the most valuable customers?
    - How does revenue change month by month?
    - Which cities contribute the most revenue?
    - What percentage of customers make repeat purchases?
    - Which customers are inactive or at risk of churn?
    - What is the customer churn rate and customer lifetime value?
    - Which products are frequently purchased together?


## Tools and Technology

    SQL Server
           .Store/inspect data, join tables, calculate KPIs, validate totals, and create analysis queries.

    Power BI Desktop
          .Build interactive report pages, visuals, slicers, and DAX measures.

    Power Query
          .Check data types, clean nulls/duplicates, and shape data before modeling.

    DAX
         .Create reusable measures that respond to report filters.


##Database tables used: 

    * customers
    * products
    *orders
    *order_items

## Dashboard Design Based on the Uploaded PBIX

    Page 1 — Sales Overview

      KPI cards: Total Sales, Delivered Orders, Average Order Value, Total Quantity Sold.
      Line chart: Total Sales by Calendar[Year Month]. Sort Year Month chronologically using a numeric YearMonth sort column.
      Bar chart: Total Sales by product category.
      Bar chart: Top products by Total Sales; use a Top N filter if needed.
      Slicers: Calendar Year, customer city, and product category.
https://github.com/sandhyasharma14/e-commerce-analysis-using-sql/blob/main/Screenshot%202026-09-26%20174942.png


Page 2 — Customer & Order Analysis
        
      KPI cards: Total Customers, Repeat Customers, Cancelled Orders, Cancellation Rate.
      Donut chart: order count by order_status.
      Bar chart: Total Sales by city.
      Bar chart: product sales split by customer gender (or use a clustered chart with gender as legend).
      Customer summary table: customer name, city, Total Sales, Delivered Orders.
      Slicer: customer gender.
https://github.com/sandhyasharma14/e-commerce-analysis-using-sql/blob/main/Screenshot%20c%202026-09-26%20175258.png

## dashboard link

   https://github.com/sandhyasharma14/e-commerce-analysis-using-sql/blob/main/E-commerce%20dashboard.pbix
 
 ##Final Recommendations
 
    1. Increase revenue and average order value:
                Identify the products and categories generating the most revenue. Use product bundles, cross-selling, and targeted promotions to encourage   customers to purchase additional items.

    2. Improve customer retention:
                Identify inactive customers and customers at risk of churn. Run personalized email campaigns, loyalty programs, and targeted offers to encourage repeat purchases.

    3. Reward high-value customers:
                Use customer lifetime value and RFM analysis to identify valuable and loyal customers. Offer exclusive discounts, loyalty rewards, and personalized recommendations.

    4. Optimize product and inventory decisions:
                 Monitor best-selling products, category performance, and frequently purchased product combinations. Prioritize stock for products with consistent demand and test bundled offers for complementary products.


