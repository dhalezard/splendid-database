CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `location` varchar(60) NOT NULL,
  `neighborhood` varchar(60) DEFAULT NULL,
  `street` varchar(30) NOT NULL,
  `floor` varchar(10) DEFAULT NULL,
  `apartment` varchar(5) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(35) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'Para Todos los Días', 'Nuestros productos'),
(2, 'Combos Para Eventos', '¡Festejá tu evento con nosotros! Elegí el combo que más te guste');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `birthday` varchar(15) DEFAULT NULL,
  `sex` enum('masculino','femenino','otro') DEFAULT NULL,
  `marketing` tinyint(1) DEFAULT 0,
  `instagram` varchar(20) DEFAULT NULL,
  `facebook` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `productos_vista`
-- (See below for the actual view)
--
CREATE TABLE `productos_vista` (
`producto_id` int(11)
,`producto` varchar(100)
,`precio` int(11)
,`descripcion` text
,`medida` varchar(17)
,`vegetariano` varchar(2)
,`categoria` varchar(35)
,`subcategoria` varchar(35)
,`grupo_producto` varchar(30)
);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `measure` varchar(10) DEFAULT NULL,
  `unit` enum('kg','g','l','ml','unidad','cc') DEFAULT NULL,
  `is_veggie` tinyint(1) NOT NULL DEFAULT 0,
  `category_id` int(11) NOT NULL,
  `subcategory_id` int(11) NOT NULL,
  `product_group` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_group`
--

CREATE TABLE `product_group` (
  `group_id` int(11) NOT NULL,
  `group_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `sale_date` date NOT NULL,
  `sale_time` time NOT NULL,
  `sale_delivery_date` date DEFAULT NULL,
  `sale_delivery_time` enum('LUN-SAB 10-13HS','LUN-SAB 13-16','LUN-VIE 16-19') DEFAULT NULL,
  `is_pickup` tinyint(1) DEFAULT 0,
  `seller_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sellers`
--

CREATE TABLE `sellers` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `shop_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE `shops` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `location` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subcategories`
--

CREATE TABLE `subcategories` (
  `id` int(11) NOT NULL,
  `name` varchar(35) NOT NULL,
  `description` text DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
















































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
    customer_id INT
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
    facebook VARCHAR(60)
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
ADD CONSTRAINT fk_shops_address_id
FOREIGN KEY (address_id)
REFERENCES addresses(id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE sellers
ADD CONSTRAINT fk_sellers_shop_id
FOREIGN KEY (shop_id)
REFERENCES shops(id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE addresses
ADD CONSTRAINT fk_addresses_customer_id
FOREIGN KEY (customer_id)
REFERENCES customers(id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE sales
ADD CONSTRAINT fk_sales_seller_id
FOREIGN KEY (seller_id)
REFERENCES sellers(id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE sales
ADD CONSTRAINT fk_sales_customer_id
FOREIGN KEY (customer_id)
REFERENCES customers(id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE sales
ADD CONSTRAINT fk_sales_shop_id
FOREIGN KEY (shop_id)
REFERENCES shops(id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE sales
ADD CONSTRAINT fk_sales_address_id
FOREIGN KEY (address_id)
REFERENCES addresses(id)
ON DELETE SET NULL
ON UPDATE CASCADE;
