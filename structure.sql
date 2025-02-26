CREATE TABLE shops (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address_id INT
);
    
CREATE TABLE sellers (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    shop_id INT
);
    
CREATE TABLE addresses (
	id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(60) NOT NULL,
    neighborhood VARCHAR(60),
    street VARCHAR (30) NOT NULL,
    floor VARCHAR(10),
    apartment VARCHAR(5),
    customer_id INT,
    shop_id INT
);

CREATE TABLE customers (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    email VARCHAR(40),
    phone VARCHAR(20) NOT NULL,
    birthday VARCHAR(15),
    sex ENUM('masculino', 'femenino', 'otro'),
    marketing BOOLEAN DEFAULT 0,
    instagram VARCHAR(20),
    facebook VARCHAR(60),
    address_id INT
);

CREATE TABLE sales (
	id INT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATE NOT NULL,
    sale_time TIME NOT NULL,
    sale_delivery_date DATE,
    sale_delivery_time ENUM('LUN-SAB 10-13HS','LUN-SAB 13-16','LUN-VIE 16-19'),
    is_pickup BOOLEAN DEFAULT 0,
    seller_id INT,
    customer_id INT,
    shop_id INT,
    address_id INT
);






ALTER TABLE shops
	ADD CONSTRAINT fk_address_id FOREIGN KEY (address_id) REFERENCES addresses(id);
    
ALTER TABLE sellers
	ADD CONSTRAINT fk_shop_id FOREIGN KEY (shop_id) REFERENCES shops(id);
    
ALTER TABLE addresses
	ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers(id),
    ADD CONSTRAINT fk_shop_id FOREIGN KEY (shop_id) REFERENCES shops(id);
    
ALTER TABLE customers
	ADD CONSTRAINT fk_address_id FOREIGN KEY (address_id) REFERENCES addresses(id);
    
ALTER TABLE sales
	ADD CONSTRAINT fk_seller_id FOREIGN KEY (seller_id) REFERENCES sellers(id),
    ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers(id),
    ADD CONSTRAINT fk_shop_id FOREIGN KEY (shops_id) REFERENCES shops(id),
    ADD CONSTRAINT fk_address_id FOREIGN KEY (address_id) REFERENCES addresses(id);
