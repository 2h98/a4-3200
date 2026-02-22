-- Question 1 (5 pts): What are the last names and emails of all customers who made purchases in the store?

SELECT DISTINCT c.LastName, c.Email
FROM customers c
INNER JOIN invoices i ON c.CustomerId = i.CustomerId
WHERE c.LastName IS NOT NULL
  AND c.Email IS NOT NULL
ORDER BY c.LastName;
