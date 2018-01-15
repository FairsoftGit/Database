### Laad eerst de bestanden:
## - 1-DDL-CREATE-TABLES.sql
## - 2-DDL-ALTER-ADD-FK.sql
## alvorens dit bestand in te laden



## Toevoegen van triggers

# Trigger om een opvolgend relationummer te creeëren bij
# aanmaken van een nieuwe relatierecord in het volgende format "REL0001"
DELIMITER //
CREATE TRIGGER tg_relation_insert 
BEFORE INSERT
ON relation
FOR EACH ROW
BEGIN
	INSERT INTO relation_seq VALUES (NULL);
	SET NEW.relationNumber = CONCAT('REL', LPAD(LAST_INSERT_ID(), 4, '0'));
END //
DELIMITER ;

# Trigger om een opvolgend productId te creeëren bij
# aanmaken van een nieuw productrecord in het volgende format "PROD0000001"
DELIMITER //
CREATE TRIGGER tg_product_insert 
BEFORE INSERT
ON product
FOR EACH ROW
BEGIN
	INSERT INTO product_seq VALUES (NULL);
	SET NEW.productId = CONCAT('PROD', LPAD(LAST_INSERT_ID(), 7, '0'));
END //
DELIMITER ;

# Trigger om een opvolgend serienummer te creeëren bij
# aanmaken van een nieuw itemrecord in het volgende format "SNI0000000001"
DELIMITER //
CREATE TRIGGER tg_item_insert 
BEFORE INSERT
ON item
FOR EACH ROW
BEGIN
	INSERT INTO item_seq VALUES (NULL);
	SET NEW.serialNumber = CONCAT('SNI', LPAD(LAST_INSERT_ID(), 10, '0'));
END //
DELIMITER ;

# Trigger om een opvolgend orderId te creeëren bij
# aanmaken van een nieuw orderrecord in het volgende format "ORD000001"
DELIMITER //
CREATE TRIGGER tg_order_insert 
BEFORE INSERT
ON `order`
FOR EACH ROW
BEGIN
	INSERT INTO order_seq VALUES (NULL);
	SET NEW.orderId = CONCAT('ORD', LPAD(LAST_INSERT_ID(), 6, '0'));
END //
DELIMITER ;

# Trigger om een opvolgend orderlineId te creeëren bij
# aanmaken van een nieuw orderlinerecord in het volgende format "ORDL0000000001"
DELIMITER //
CREATE TRIGGER tg_orderline_insert 
BEFORE INSERT
ON orderline
FOR EACH ROW
BEGIN
	INSERT INTO orderline_seq VALUES (NULL);
	SET NEW.orderlineId = CONCAT('ORDL', LPAD(LAST_INSERT_ID(), 10, '0'));
END //
DELIMITER ;
## -----