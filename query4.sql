-- Question 4 (10 pts): Which states have more than 10 unique customers?

SELECT State, COUNT(DISTINCT CustomerId) AS TotalCustomers
FROM customers
WHERE State IS NOT NULL
GROUP BY State
HAVING COUNT(DISTINCT CustomerId) > 10
ORDER BY TotalCustomers DESC;
