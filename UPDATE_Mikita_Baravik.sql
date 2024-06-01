UPDATE customer
SET first_name = 'YourFirstName',
    last_name = 'YourLastName',
    email = 'your.email@example.com',
    address_id = (SELECT address_id FROM address ORDER BY RANDOM() LIMIT 1), -- assuming you're choosing a random address from the address table
    create_date = CURRENT_DATE
WHERE customer_id IN (
    SELECT c.customer_id
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
    HAVING COUNT(DISTINCT r.rental_id) >= 10 AND COUNT(DISTINCT p.payment_id) >= 10
)