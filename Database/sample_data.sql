USE SMPM;
GO

-- Departments
INSERT INTO Department (dept_name) VALUES ('Sales'), ('Production'), ('Management');

-- Employees
INSERT INTO Employee (emp_name, department_id, salary, phone, isManager) VALUES 
('Alice Manager', 3, 80000, '555-0101', 1),
('Bob Sales', 1, 50000, '555-0102', 0),
('Charlie Production', 2, 55000, '555-0103', 0),
('David Production', 2, 52000, '555-0104', 0);

-- Employee Login (Password: password123)
-- Note: In a real app, use hashed passwords. For this sample, we store plain text or a placeholder hash.
INSERT INTO Employee_Login (employee_id, username, password_hash) VALUES 
(1, 'admin', 'password123'),
(2, 'sales', 'password123'),
(3, 'prod', 'password123');

-- Customers
INSERT INTO Customer (cust_name, phone, cust_address) VALUES 
('Acme Corp', '555-1001', '123 Business Rd'),
('Global Tech', '555-1002', '456 Innovation Ave');

-- Suppliers
INSERT INTO Supplier (supplier_name, phone) VALUES 
('Raw Materials Inc', '555-2001'),
('Steel Co', '555-2002');

-- Materials
INSERT INTO Material (material_name, cost, supplier_id, stock_quantity) VALUES 
('Steel Sheet', 50.00, 2, 100),
('Plastic Pellets', 20.00, 1, 500),
('Copper Wire', 15.00, 1, 200);

-- Products
INSERT INTO Product (product_name, cost_price, selling_price, category) VALUES 
('Widget A', 10.00, 25.00, 'Gadgets'),
('Widget B', 15.00, 35.00, 'Gadgets'),
('Super Widget', 50.00, 100.00, 'Premium');

-- Inventory
INSERT INTO Inventory (product_id, quantity) VALUES 
(1, 50),
(2, 30),
(3, 10);

-- Sample Production Order
INSERT INTO Production (product_id, employee_id, quantity, production_status) VALUES 
(1, 1, 100, 'In Progress');

-- Sample Production Task
INSERT INTO Production_Task (production_id, assigned_employee_id, task_description, status) VALUES 
(1, 3, 'Assemble base components', 'Pending'),
(1, 4, 'Paint and finish', 'Pending');

-- Sample Customer Order
INSERT INTO Customer_Order (customer_id, employee_id, total_amount, order_status) VALUES 
(1, 2, 2500.00, 'Completed');

INSERT INTO Order_Item (order_id, product_id, quantity, unit_price) VALUES 
(1, 1, 100, 25.00);

