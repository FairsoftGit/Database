### DDL bestand tbv creeren van Database voor Fairsoft



## Optioneel gedeelte indien database nog niet bestaat. Indien niet gewenst, op de regels
## 7 t/m 9 een 3 plaatsen.
# CREATE DATABASE liannela_fairsoft;
#
# USE liannela_fairsoft;
## -----



## Aanmaken van tabellen
CREATE TABLE account (
	username VARCHAR(100) NOT NULL UNIQUE,
	`password` VARCHAR(255) NOT NULL,
	`status` TINYINT(1) NOT NULL DEFAULT '1',
	RELATIONrelationNumber VARCHAR(15),
	
	CONSTRAINT accountPK PRIMARY KEY (username)
);

CREATE TABLE account_role (
	ACCOUNTusername VARCHAR(100) NOT NULL,
	ROLErole VARCHAR(100) NOT NULL,
	
	CONSTRAINT account_rolePK PRIMARY KEY (ACCOUNTusername, ROLErole)
);

CREATE TABLE address (
	street VARCHAR(100) NOT NULL,
	housenumber VARCHAR(15) NOT NULL,
	postcode VARCHAR(15) NOT NULL,
	city VARCHAR(50) NOT NULL,
	province VARCHAR(30),
	countryCode CHAR(2) NOT NULL,
	typeOfAddress VARCHAR(10) NOT NULL,
	
	CONSTRAINT addressPK PRIMARY KEY (street, housenumber, postcode)
);

CREATE TABLE company (
	name VARCHAR(60) NOT NULL UNIQUE,
	isSupplier CHAR(1) NOT NULL,
	RELATIONrelationNumber VARCHAR(15) NOT NULL,
	
	CONSTRAINT companyPK PRIMARY KEY (RELATIONrelationNumber)
);

CREATE TABLE country (
	code CHAR(2) NOT NULL,
	name_dutch VARCHAR(100) NOT NULL,
	
	CONSTRAINT countryPK PRIMARY KEY (code)
);

CREATE TABLE item (
	serialNumber VARCHAR(50) NOT NULL UNIQUE,
	PRODUCTproductId VARCHAR(50) NOT NULL,
	
	CONSTRAINT itemPK PRIMARY KEY (serialNumber)
);

CREATE TABLE item_seq (
	id INT(11) AUTO_INCREMENT,
	
	CONSTRAINT item_seqPK PRIMARY KEY (id)
);

CREATE TABLE `order` (
	orderId VARCHAR(15) DEFAULT '0' NOT NULL UNIQUE,
	orderDate DATETIME NOT NULL,
	ACCOUNTusername VARCHAR(100) NOT NULL,
	
	CONSTRAINT orderPK PRIMARY KEY (orderId)
);

CREATE TABLE orderline (
	orderlineId VARCHAR(15) DEFAULT '0' NOT NULL UNIQUE,
	ORDERorderId VARCHAR(15) NOT NULL,
	ITEMserialnumber VARCHAR(50) NOT NULL,
	
	CONSTRAINT orderlinePK PRIMARY KEY (orderlineId)
);

CREATE TABLE orderline_seq (
	id INT(11) AUTO_INCREMENT,
	
	CONSTRAINT orderline_seqPK PRIMARY KEY (id)
);

CREATE TABLE order_seq (
	id INT(11) AUTO_INCREMENT,
	
	CONSTRAINT order_seqPK PRIMARY KEY (id)
);

CREATE TABLE permission (
	permission VARCHAR(255) NOT NULL,
	
	CONSTRAINT permissionPK PRIMARY KEY (permission)
);

CREATE TABLE person (
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(60) NOT NULL,
	middleName VARCHAR(10),
	gender CHAR(1), #genderneutraal, dus mag NULL
	birthDate DATE NOT NULL,
	RELATIONrelationNumber VARCHAR(15) NOT NULL UNIQUE,
	
	CONSTRAINT personPK PRIMARY KEY (RELATIONrelationNumber)
);

CREATE TABLE product (
	productId VARCHAR(50) DEFAULT '0' NOT NULL UNIQUE,
	productName VARCHAR(255) NOT NULL,
	productDesc TEXT,
	purchasePrice DECIMAL(19,2) NOT NULL,
	salesPrice DECIMAL(19,2) NOT NULL,
	rentalPrice DECIMAL(19,2),
	COMPANYRELATIONrelationNumber VARCHAR(15),
	
	CONSTRAINT productPK PRIMARY KEY (productId)
);

CREATE TABLE product_seq (
	id INT(11) AUTO_INCREMENT,
	
	CONSTRAINT product_seqPK PRIMARY KEY (id)
);

CREATE TABLE relation (
	relationNumber VARCHAR(15) DEFAULT '0' NOT NULL,
	emailAddress VARCHAR(50),
	phonenumber VARCHAR(25),
	relationType VARCHAR(15),
	isActive TINYINT(1) DEFAULT '1' NOT NULL,
	
	CONSTRAINT relationPK PRIMARY KEY (relationNumber)
);

CREATE TABLE relationType (
	type VARCHAR(15) NOT NULL,

	CONSTRAINT relationTypeFK PRIMARY KEY (type)
);


CREATE TABLE relation_address (
	RELATIONrelationNumber VARCHAR(15) NOT NULL,
	ADDRESSstreet VARCHAR(100) NOT NULL,
	ADDRESShousenumber VARCHAR(15) NOT NULL,
	ADDRESSpostcode VARCHAR(15) NOT NULL,
	
	CONSTRAINT rel_addPK PRIMARY KEY (RELATIONrelationNumber, ADDRESSstreet, ADDRESShousenumber, ADDRESSpostcode)
);

CREATE TABLE relation_seq (
	id INT(11) AUTO_INCREMENT,
	
	CONSTRAINT relation_seqPK PRIMARY KEY (id)
);

CREATE TABLE rent (
	ORDERLINEorderlineId VARCHAR(15) NOT NULL UNIQUE,
	ITEMserialnumber VARCHAR(50) NOT NULL,
	startDate DATETIME NOT NULL,
	endDate DATETIME NOT NULL,
	
	CONSTRAINT rentPK PRIMARY KEY (ORDERLINEorderlineId)
);

CREATE TABLE role (
	role VARCHAR(100) NOT NULL,
	
	CONSTRAINT rolePK PRIMARY KEY (role)
);

CREATE TABLE role_permission (
	ROLErole VARCHAR(100) NOT NULL,
	PERMISSIONpermission VARCHAR(255) NOT NULL,
	
	CONSTRAINT role_permPK PRIMARY KEY (ROLErole, PERMISSIONpermission)
);

CREATE TABLE subscription (
	ORDERLINEorderlineId VARCHAR(15),
  ITEMserialNumber VARCHAR(50),
  startDate DATETIME,
  endDate DATETIME,

  CONSTRAINT subscriptionPK PRIMARY KEY (ORDERLINEorderlineId)
);
## -----