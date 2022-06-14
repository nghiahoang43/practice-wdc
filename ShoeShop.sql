DROP DATABASE IF EXISTS shoe_shop;
CREATE DATABASE shoe_shop;
USE shoe_shop;

CREATE TABLE User(
    user_id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
    password VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    lastname  VARCHAR(50) NOT NULL,

    PRIMARY KEY (user_id),
    CONSTRAINT email_not_unique UNIQUE (email)
);

CREATE TABLE Shoe(
    shoe_id INT NOT NULL AUTO_INCREMENT,
    shoe_name VARCHAR(50) NOT NULL,
    shoe_url VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    size VARCHAR(50) NOT NULL,
    style VARCHAR(50) NOT NULL,
    brand  VARCHAR(50) NOT NULL,
    price  VARCHAR(50) NOT NULL,

    PRIMARY KEY (shoe_id),
);

CREATE TABLE Order(
    order_id INT NOT NULL AUTO_INCREMENT,
    shoe_id INT NOT NULL,
    date DATE NOT NULL,

    PRIMARY KEY (order_id),
    CONSTRAINT fk_shoeid_to_order FOREIGN KEY (shoe_id) REFERENCES Shoe (shoe_id) ON DELETE CASCADE,
);

CREATE TABLE UserOrder(
    user_id INT NOT NULL,
    order_id INT NOT NULL,

    PRIMARY KEY (user_id, order_id), /* this combination must be unique */
    CONSTRAINT fk_userid_to_userorder FOREIGN KEY (user_id) REFERENCES User (user_id) ON DELETE CASCADE
    CONSTRAINT fk_orderid_to_userorder FOREIGN KEY (order_id) REFERENCES Order (order_id) ON DELETE CASCADE,
);

DELIMITER //
CREATE PROCEDURE sign_up (
    IN username_ VARCHAR(50), email_ VARCHAR(50), password_ VARCHAR(30), firstname_ VARCHAR(50), lastname_ VARCHAR(50)
)
BEGIN
    INSERT INTO User (username, email, password, isRegistered) VALUES (username_, email_, password_, firstname_, lastname_);
    CALL login(email_, password_);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE login (
    IN email_ VARCHAR(50), password_ VARCHAR(30)
)
BEGIN
    SELECT * FROM User
        WHERE email = email_ AND password = password_;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE create_shoe(
    IN
    shoe_id_ INT,
    shoe_name_ VARCHAR(50) NOT NULL,
    shoe_url_ VARCHAR(100) NOT NULL,
    quantity_ INT,
    size_ VARCHAR(50) NOT NULL,
    style_ VARCHAR(50) NOT NULL,
    brand_  VARCHAR(50) NOT NULL,
    price_  VARCHAR(50) NOT NULL,
)
BEGIN
    INSERT INTO Event(shoe_id, shoe_name, shoe_url, quantity, size, style, brand, price)
        VALUES (shoe_id_, shoe_name_, shoe_url_, quantity_, size_, style_, brand_, price_);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_shoe(IN shoe_id_ INT,)
BEGIN
    SELECT shoe_id, shoe_name, shoe_url, quantity, size, style, brand, price FROM Shoe WHERE shoe_id = shoe_id_;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_shoe_list(IN shoe_id_ INT,)
BEGIN
    SELECT * FROM Shoe;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE create_order(IN shoe_id_ INT, date_ DATE)
BEGIN
    INSERT INTO Order(shoe_id, date)
        VALUES (shoe_id_, date_);
    SELECT order_id from Order WHERE order_id = (SELECT MAX(order_id) FROM Order);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_shoe_to_order(IN shoe_id_ INT, order_id_ INT, date_ DATE)
BEGIN
    INSERT INTO Order(order_id, shoe_id, date)
        VALUES (order_id_, shoe_id_, date_);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_order(IN order_id_ INT,)
BEGIN
    SELECT shoe_id FROM Order WHERE order_id = order_id_;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE get_order_history(IN user_id_ INT,)
BEGIN
    SELECT order_id FROM UserOrder WHERE user_id = user_id_;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE order(IN user_id_ INT, order_id_ INT)
BEGIN
    INSERT INTO UserOrder(user_id, order_id)
        VALUES (user_id_, order_id_);
END //
DELIMITER ;