### Laad eerst de bestanden:
## - 1-DDL-CREATE-TABLES.sql
## - 2-DDL-ALTER-ADD-FK.sql
## - 3-DDL--ADD-TRIGGERS.sql
## alvorens dit bestand in te laden



## Toevoegen van Stored Procedures


DELIMITER //
CREATE PROCEDURE sp_chart_account_status (
	OUT totalAccounts INT,
	OUT totalActiveAccounts INT
)
BEGIN
	SELECT COUNT(username) INTO totalAccounts 
	FROM account;
	
	SELECT COUNT(username) INTO totalActiveAccounts 
	FROM account
	WHERE account.status = 1;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_createAccount (
	IN _username VARCHAR(30),
	IN _password VARCHAR(255),
	IN _status TINYINT
)
BEGIN
	INSERT INTO relation (relationType) 
	VALUES ('Debiteur');
	
	SET @relnum = (
		SELECT relationNumber
		FROM relation
		ORDER BY relationNumber DESC
		LIMIT 1
	);
	
	INSERT INTO account(username,	`password`,	`status`, RELATIONrelationNumber) 
	VALUES (_username,	_password, _status, @relnum);
	
	SELECT RELATIONrelationNumber
	FROM account
	WHERE username = _username
	AND RELATIONrelationNumber = @relnum;	
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_createAccountAll (
	IN _username VARCHAR(200),
	IN _password VARCHAR(255),
	IN _firstname VARCHAR(50),
	IN _lastname VARCHAR(60),
	IN _middlename VARCHAR(10),
	IN _gender CHAR,
	IN _birthdate DATE,
	IN _street VARCHAR(100),
	IN _housenumber VARCHAR(10),
	IN _postcode VARCHAR(15),
	IN _province VARCHAR(30),
	IN _country VARCHAR(60),
	IN _typeOfAddress VARCHAR(10),
	IN _phonenr VARCHAR(25),
	IN _email VARCHAR(50)
)
BEGIN
    INSERT INTO relation (relationType, emailAddress, phonenumber)
    VALUES ('Debiteur', _email, _phonenr);

	SET @relnum = (
		SELECT relationNumber
      FROM relation
      ORDER BY relationNumber DESC
      LIMIT 1
	);

	INSERT INTO account (username, `password`, RELATIONrelationNumber)
   VALUES (_username, _password, @relnum);

   INSERT INTO person (firstName, lastName, middleName, gender, birthDate, RELATIONrelationNumber)
   VALUES (_firstname, _lastname, _middlename, _gender, _birthdate, @relnum);

   INSERT INTO address (street, housenumber, postcode, province, countryCode, typeOfAddress)
   VALUES (_street, _housenumber, _postcode, _province, _country, _typeOfAddress);

   INSERT INTO relation_address 
	VALUES (@relnum, _street, _housenumber, _postcode);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_getAccountEditData(
	IN _relationNumber VARCHAR(15)

)
BEGIN
  SELECT
    relation.relationNumber
    , account.username
    , account.`password`
    , account.`status`
    , address.street
    , address.housenumber
    , address.postcode
    , address.city
    , address.province
    , address.countryCode
    , address.typeOfAddress
    , person.firstName
    , person.middleName
    , person.lastName
    , person.gender
    , person.birthDate
    , relation.phoneNumber
    , relation.emailAddress
    , relation.relationType
    , relation.isActive
  FROM
    relation
    INNER JOIN
    account
      ON
        relation.relationNumber = account.RELATIONrelationNumber
    LEFT JOIN
    person
      ON
        relation.relationNumber = person.RELATIONrelationNumber
    LEFT JOIN
    relation_address
      ON relation.relationNumber = relation_address.RELATIONrelationNumber
    LEFT JOIN
    address
      ON relation_address.ADDRESSstreet = address.street
         AND relation_address.ADDRESShousenumber = address.housenumber
         AND relation_address.ADDRESSpostcode = address.postcode
  WHERE
    relation.relationNumber = `_relationNumber`;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_getCountries()
BEGIN
	SELECT * FROM country;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_getOrderHistory(
	IN _relationNumber VARCHAR(15)
)
BEGIN
	SELECT
		`order`.orderDate
		, `order`.orderId
		, account.RELATIONrelationNumber
	FROM `order`
	LEFT JOIN account
		ON `order`.ACCOUNTusername = account.username
	WHERE
		account.RELATIONrelationNumber = _relationNumber;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_getOrderLineHistory(
	IN _relationNumber VARCHAR(15)
)
BEGIN
	SELECT
		`order`.orderDate
		, `order`.orderId
		, product.productName
		, item.serialNumber
		, product.salesPrice
		, account.RELATIONrelationNumber
	FROM orderline
	LEFT JOIN `order`
		ON orderline.ORDERorderId = `order`.orderId
	LEFT JOIN item
		ON orderline.ITEMserialnumber = item.serialNumber
	LEFT JOIN product
		ON item.PRODUCTproductId = product.productId
	LEFT JOIN account
		ON `order`.ACCOUNTusername = account.username
	WHERE
		account.RELATIONrelationNumber = `_relationNumber`;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_getProductById(
	IN _productId VARCHAR(50)
)
BEGIN
    SELECT * FROM product WHERE productId = _productId;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_saveAddress(
  IN _relationNumber VARCHAR(15),
  IN _street VARCHAR(100),
  IN _housenumber VARCHAR(15),
  IN _postcode VARCHAR(15),
  IN _city VARCHAR(50),
  IN _province VARCHAR(30),
  IN _countryCode CHAR(2),
  IN _typeOfAddress VARCHAR(10)
)
BEGIN
  INSERT INTO address (
    street,
    housenumber,
    postcode,
    city,
    province,
    countryCode,
    typeofaddress
  ) VALUES (
    _street,
    _housenumber,
    _postcode,
    _city,
    _province,
    _countryCode,
    _typeOfAddress
  )
  ON DUPLICATE KEY UPDATE
    address.street = _street,
    address.housenumber = _housenumber,
    address.postcode = _postcode,
    address.city = _city,
    address.province = _province,
    address.countryCode = _countryCode,
    address.typeofaddress = _typeOfAddress;

  INSERT INTO relation_address (
    RELATIONRelationNumber,
    ADDRESSstreet,
    ADDRESShousenumber,
    ADDRESSpostcode
  ) VALUES (
    _relationNumber
    , _street
    , _housenumber
    , _postcode
  )
  ON DUPLICATE KEY UPDATE
    relation_address.RELATIONRelationNumber = _relationNumber,
    relation_address.ADDRESSStreet = _street,
    relation_address.ADDRESShousenumber = _housenumber,
    relation_address.ADDRESSpostcode = _postcode;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_savePerson(
  IN _relationNumber VARCHAR(15),
  IN _firstName VARCHAR(50),
  IN _middleName VARCHAR(10),
  IN _lastName VARCHAR(60),
  IN _gender CHAR(1),
  IN _birthDate DATE
)
BEGIN
  INSERT INTO person (
    RELATIONrelationNumber,
    firstName,
    middleName,
    lastName,
    gender,
    birthDate
  ) VALUES (
    _relationNumber,
    _firstName,
    _middleName,
    _lastName,
    _gender,
    _birthDate
  )
  ON DUPLICATE KEY UPDATE
    person.RELATIONrelationNumber = _relationNumber,
    person.firstName = _firstName,
    person.middleName = _middleName,
    person.lastName = _lastName,
    person.gender = _gender,
    person.birthDate = _birthDate;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_saveProduct(
  IN _productId VARCHAR(50),
  IN _productName VARCHAR(50),
  IN _productDesc TEXT,
  IN _purchasePrice DECIMAL,
  IN _salesPrice DECIMAL,
  IN _rentalPrice DECIMAL,
  IN _relationNumber VARCHAR(15)
)
BEGIN
  INSERT INTO product (
    productId,
    productName,
    productDesc,
    purchasePrice,
    salesPrice,
    rentalPrice,
    COMPANYRELATIONrelationNumber
  ) VALUES (
    _productId,
    _productName,
    _productDesc,
    _purchasePrice,
    _salesPrice,
    _rentalPrice,
    _relationNumber
  )
  ON DUPLICATE KEY UPDATE
    product.productId = _productId,
    product.productName = _productName,
    product.productDesc = _productDesc,
    product.purchasePrice = _purchasePrice,
    product.salesPrice = _salesPrice,
    product.rentalPrice = _rentalPrice,
    product.COMPANYRELATIONrelationNumber = _relationNumber;

    SELECT productId FROM product
    WHERE productId = _productId;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_saveRelation (
  IN `_relationNumber` varchar(15),
  IN `_relationType` varchar(15),
  IN `_isActive` tinyint(1),
  IN `_emailAddress` varchar(255),
  IN `_phoneNumber` varchar(25)
)
  BEGIN
    UPDATE relation
    SET
      relation.relationNumber = `_relationNumber`,
      relation.relationType = `_relationType`,
      relation.isActive = `_isActive`,
      relation.emailAddress = `_emailAddress`,
      relation.phoneNumber = `_phoneNumber`
    WHERE
      relation.relationNumber = `_relationNumber`;
  END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_toggleStatus(IN `_username` VARCHAR(255), IN `_status` TINYINT)
  BEGIN
    UPDATE account SET
      `status` = `_status`
    WHERE
      username = `_username`;
  END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_updateAccount(
  IN `_relationNumber` VARCHAR(15),
  IN `_username` VARCHAR(100),
  IN `_password` VARCHAR(128),
  IN `_status` TINYINT
)
  BEGIN
    UPDATE account SET
      `password` = `_password`,
      `status` = `_status`
    WHERE
      RELATIONrelationNumber = `_relationNumber`
      AND username = _username;
  END //
DELIMITER ;
## -----