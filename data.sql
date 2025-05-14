-- Create the database
CREATE DATABASE boutiquedb;
USE boutiquedb;


-- 1. Customers Table

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Sample Data for Customers 

INSERT INTO customers (first_name, last_name, email, phone, address) VALUES
('Stacy', 'Kamau', 'stacy@example.com', '0712345678', 'Nairobi, Kenya'),
('Lola', 'Achieng', 'lola@example.com', '0722334455', 'Kisumu, Kenya'),
('Wanjiru', 'Mwangi', 'wanjiru@example.com', '0733445566', 'Nakuru, Kenya'),
('Nyambura', 'Kariuki', 'nyambura@example.com', '0744556677', 'Mombasa, Kenya'),
('Zena', 'Otieno', 'zena@example.com', '0755667788', 'Eldoret, Kenya'),
('Faith', 'Mutua', 'faith@example.com', '0766778899', 'Thika, Kenya'),
('Amina', 'Yusuf', 'amina@example.com', '0777889900', 'Garissa, Kenya'),
('Joan', 'Njeri', 'joan@example.com', '0788990011', 'Meru, Kenya'),
('Tasha', 'Ndungu', 'tasha@example.com', '0799001122', 'Machakos, Kenya'),
('Elsie', 'Wekesa', 'elsie@example.com', '0700112233', 'Kakamega, Kenya');







-- 2. Categories Table

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);


-- Sample Data for Categories 

INSERT INTO categories (category_name, description) VALUES
('Dresses', 'Chic and elegant dresses for all occasions.'),
('Tops', 'Trendy tops for everyday slay.'),
('Bottoms', 'Pants, skirts, and shorts to match your vibe.'),
('Accessories', 'Jewelry, belts, and extras to elevate your look.'),
('Shoes', 'Heels, flats, and everything in between.'),
('Makeup', 'Lipsticks, foundations, and glam essentials.'),
('Bags', 'Handbags, clutches, and totes.'),
('Loungewear', 'Comfy pieces for chill days.'),
('Swimwear', 'Bikinis and one-pieces for hot days.'),
('Fragrances', 'Perfumes and body mists.');







-- 3. Products Table

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);


-- Sample Data for Products 

INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES
('Black Bodycon Dress', 'Sexy black body-hugging dress.', 3500.00, 20, 1),
('White Crop Top', 'Simple white crop for any vibe.', 1200.00, 30, 2),
('High-Waisted Jeans', 'Thick girl flattering blue jeans.', 2800.00, 25, 3),
('Gold Hoop Earrings', 'Chunky gold hoops.', 500.00, 100, 4),
('Clear Strap Heels', 'Trendy clear heels.', 4000.00, 15, 5),
('Red Lipstick', 'Bold red matte lipstick.', 850.00, 50, 6),
('Mini Black Purse', 'Elegant mini bag.', 2500.00, 18, 7),
('Satin Pajama Set', 'Luxurious two-piece set.', 3000.00, 10, 8),
('Yellow Bikini', 'Bright two-piece swimsuit.', 3200.00, 12, 9),
('Vanilla Perfume Mist', 'Soft, feminine scent.', 1800.00, 40, 10);







-- 4. Orders Table

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Pending',
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


-- Sample Data for Orders 

INSERT INTO orders (customer_id, status, total_amount) VALUES
(1, 'Completed', 7350.00),
(2, 'Pending', 2800.00),
(3, 'Shipped', 5300.00),
(4, 'Completed', 4000.00),
(5, 'Cancelled', 2500.00),
(6, 'Completed', 850.00),
(7, 'Pending', 3200.00),
(8, 'Shipped', 3000.00),
(9, 'Completed', 1800.00),
(10, 'Completed', 1200.00);







-- 5. Order Items Table

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- Sample Data for Order Items

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 3500.00),
(1, 4, 1, 500.00),
(1, 6, 1, 850.00),
(2, 3, 1, 2800.00),
(3, 1, 1, 3500.00),
(3, 5, 1, 1800.00),
(4, 5, 1, 4000.00),
(5, 7, 1, 2500.00),
(6, 6, 1, 850.00),
(7, 9, 1, 3200.00);







-- 6. Payments Table

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


-- Sample Data for Payments 

INSERT INTO payments (order_id, amount, payment_method, payment_status) VALUES
(1, 7350.00, 'M-Pesa', 'Paid'),
(2, 2800.00, 'Card', 'Pending'),
(3, 5300.00, 'M-Pesa', 'Paid'),
(4, 4000.00, 'Card', 'Paid'),
(5, 2500.00, 'Bank Transfer', 'Failed'),
(6, 850.00, 'M-Pesa', 'Paid'),
(7, 3200.00, 'Card', 'Pending'),
(8, 3000.00, 'M-Pesa', 'Paid'),
(9, 1800.00, 'Cash', 'Paid'),
(10, 1200.00, 'M-Pesa', 'Paid');
