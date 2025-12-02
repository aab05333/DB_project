CREATE DATABASE SMPM;
GO

USE SMPM;
GO

CREATE TABLE Department (
    dept_id INT IDENTITY(1,1) PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE Employee (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    emp_name VARCHAR(150) NOT NULL,
    department_id INT NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    isManager BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (department_id) REFERENCES Department(dept_id)
);

CREATE TABLE Employee_Login (
    employee_id INT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL, -- Changed to store hash
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Customer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    cust_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20),
    cust_address VARCHAR(255)
);

CREATE TABLE Customer_Login (
    customer_id INT PRIMARY KEY, -- Changed to link to Customer table
    username VARCHAR(100) UNIQUE NOT NULL,
    cust_password VARCHAR(255) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Supplier (
    supplier_id INT IDENTITY(1,1) PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE Material (
    material_id INT IDENTITY(1,1) PRIMARY KEY,
    material_name VARCHAR(150) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    supplier_id INT NOT NULL,
    stock_quantity INT DEFAULT 0, -- Added to track material stock
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

CREATE TABLE Material_Order (
    material_order_id INT IDENTITY(1,1) PRIMARY KEY,
    supplier_id INT NOT NULL,
    order_date DATE DEFAULT GETDATE(),
    status VARCHAR(50) DEFAULT 'Pending',
    total_cost DECIMAL(10,2),
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

CREATE TABLE Material_Order_Item (
    item_id INT IDENTITY(1,1) PRIMARY KEY,
    material_order_id INT NOT NULL,
    material_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (material_order_id) REFERENCES Material_Order(material_order_id),
    FOREIGN KEY (material_id) REFERENCES Material(material_id)
);

CREATE TABLE Product (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    cost_price FLOAT,
    selling_price DECIMAL(10,2),
    category VARCHAR(100)
);

CREATE TABLE Production (
    production_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    employee_id INT NOT NULL, -- The manager who initiated it
    quantity INT NOT NULL,
    production_date DATE NOT NULL DEFAULT GETDATE(),
    production_status VARCHAR(50), -- 'Pending', 'In Progress', 'Completed'
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Production_Task ( -- Added to track individual tasks
    task_id INT IDENTITY(1,1) PRIMARY KEY,
    production_id INT NOT NULL,
    assigned_employee_id INT, -- Production employee
    task_description VARCHAR(255),
    status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (production_id) REFERENCES Production(production_id),
    FOREIGN KEY (assigned_employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Customer_Order (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT, -- Can be null if online order
    order_date DATE DEFAULT GETDATE(),
    total_amount DECIMAL(10,2),
    order_status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Order_Item (
    item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Customer_Order(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Shipping_Company (
    company_id INT IDENTITY(1,1) PRIMARY KEY,
    company_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE Shipment (
    shipment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    company_id INT NOT NULL,
    shipment_date DATE DEFAULT GETDATE(),
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Customer_Order(order_id),
    FOREIGN KEY (company_id) REFERENCES Shipping_Company(company_id)
);

CREATE TABLE Bill (
    bill_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    bill_amount DECIMAL(10,2),
    bill_date DATE DEFAULT GETDATE(),
    due_date DATE,
    bill_status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Customer_Order(order_id)
);

CREATE TABLE Payment (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    bill_id INT NOT NULL,
    payment_amount DECIMAL(10,2) NOT NULL,
    payment_date DATE DEFAULT GETDATE(),
    payment_method VARCHAR(50),
    FOREIGN KEY (bill_id) REFERENCES Bill(bill_id)
);

CREATE TABLE Inventory (
    inventory_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
