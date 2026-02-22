-- Question 9 (25 pts): Creative Query with Window Function
--
-- Question: How does each sales support rep's quarterly revenue performance rank
-- compare to the previous quarter? Show their rank trajectory over time.
--
-- Explanation:
-- This query joins four tables (employees, customers, invoices, invoice_items) to
-- compute each support rep's total revenue per calendar quarter. It then uses three
-- window functions across two CTE layers:
--   1. RANK() to rank reps within each quarter by revenue.
--   2. LAG() to retrieve each rep's rank from the prior quarter, revealing whether
--      they moved up, down, or held steady.
--   3. SUM() OVER (cumulative) to show each rep's running revenue total across
--      quarters, tracking career-long earnings growth.
-- The results expose performance trends — which reps are improving over time and
-- which are slipping — giving management actionable data beyond a single snapshot.

WITH quarterly_sales AS (
    SELECT
        e.EmployeeId,
        e.FirstName || ' ' || e.LastName AS RepName,
        strftime('%Y', i.InvoiceDate) || '-Q' ||
            CAST((CAST(strftime('%m', i.InvoiceDate) AS INTEGER) + 2) / 3 AS TEXT) AS Quarter,
        ROUND(SUM(ii.UnitPrice * ii.Quantity), 2) AS QuarterlyRevenue
    FROM employees e
    INNER JOIN customers c ON e.EmployeeId = c.SupportRepId
    INNER JOIN invoices i ON c.CustomerId = i.CustomerId
    INNER JOIN invoice_items ii ON i.InvoiceId = ii.InvoiceId
    WHERE e.FirstName IS NOT NULL
      AND e.LastName IS NOT NULL
    GROUP BY e.EmployeeId, RepName, Quarter
),
ranked AS (
    SELECT
        Quarter,
        RepName,
        QuarterlyRevenue,
        ROUND(SUM(QuarterlyRevenue) OVER (
            PARTITION BY EmployeeId ORDER BY Quarter
        ), 2) AS CumulativeRevenue,
        RANK() OVER (
            PARTITION BY Quarter ORDER BY QuarterlyRevenue DESC
        ) AS CurrentRank,
        EmployeeId
    FROM quarterly_sales
)
SELECT
    Quarter,
    RepName,
    QuarterlyRevenue,
    CumulativeRevenue,
    CurrentRank,
    LAG(CurrentRank) OVER (
        PARTITION BY EmployeeId ORDER BY Quarter
    ) AS PreviousRank,
    CASE
        WHEN LAG(CurrentRank) OVER (PARTITION BY EmployeeId ORDER BY Quarter) IS NULL THEN 'NEW'
        WHEN CurrentRank < LAG(CurrentRank) OVER (PARTITION BY EmployeeId ORDER BY Quarter) THEN 'IMPROVED'
        WHEN CurrentRank > LAG(CurrentRank) OVER (PARTITION BY EmployeeId ORDER BY Quarter) THEN 'DECLINED'
        ELSE 'STEADY'
    END AS RankChange
FROM ranked
ORDER BY Quarter, CurrentRank;