CREATE OR REPLACE VIEW rfm_customer_view AS

WITH cte1 AS (
    SELECT 
        DATE(invoice_date) AS invoice_date,
        invoice_no,
        stock_code,
        customer_id,
        quantity,
        quantity * unit_price AS revenue,
        ROW_NUMBER() OVER(PARTITION BY invoice_no ORDER BY invoice_date) AS inv_rn
    FROM public.online_retail
    WHERE invoice_no IS NOT NULL 
      AND invoice_no <> ''
      AND stock_code IS NOT NULL 
      AND stock_code <> ''
      AND customer_id IS NOT NULL
      AND quantity IS NOT NULL 
      AND quantity > 0
),

cte2 AS (
    SELECT *
    FROM cte1
    WHERE inv_rn = 1
),

cte3 AS (
    SELECT 
        customer_id,
        MAX(invoice_date) AS last_purchase_date,
        (SELECT MAX(invoice_date) FROM cte2) AS max_date,
        SUM(revenue) AS monetary,
        COUNT(DISTINCT invoice_no) AS frequency
    FROM cte2
    GROUP BY customer_id
),

cte4 AS (
    SELECT 
        customer_id,
        last_purchase_date AS invoice_date,
        (max_date - last_purchase_date) + 1 AS recency,
        frequency,
        monetary
    FROM cte3
),

cte5 AS (
    SELECT *,
        NTILE(4) OVER (ORDER BY recency DESC) AS R,
        NTILE(4) OVER (ORDER BY frequency) AS F,
        NTILE(4) OVER (ORDER BY monetary) AS M
    FROM cte4
),

cte6 AS (
    SELECT *,
        CONCAT(R,F,M) AS RFM_Score
    FROM cte5
),

cte7 AS (
    SELECT *,
        monetary / NULLIF(frequency,0) AS AOV,
        CASE 
            WHEN RFM_Score::int IN (444,443,434,433) THEN 'Champions'
            WHEN RFM_Score::int IN (442,441,432,431,424,423,422,421) THEN 'Loyal_Customers'
            WHEN RFM_Score::int IN (344,343,334,333,324,323,322) THEN 'Active_Customers'
            WHEN RFM_Score::int IN (244,243,234,233,224,223,222) THEN 'Potential_Customers'
            WHEN RFM_Score::int IN (142,141,132,131,122,121,112,111) THEN 'Lost_Customers'
            WHEN RFM_Score::int IN (311,312,313,321,331) THEN 'At_Risk_Customers'
            ELSE 'Others'
        END AS customer_segment
    FROM cte6
)

select * from rfm_customer_view;





