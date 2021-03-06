### Laad eerst het bestand 1-DDL-CREATE-TABLES.sql alvorens dit bestand in te laden


## Toevoegen van Foreign Keys
ALTER TABLE account
ADD CONSTRAINT accountFK FOREIGN KEY (RELATIONrelationNumber)
	REFERENCES relation (relationNumber)
		ON UPDATE CASCADE
		ON DELETE RESTRICT;

ALTER TABLE account_role
ADD CONSTRAINT acc_rolFK FOREIGN KEY (ACCOUNTusername)
	REFERENCES account (username)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
ADD CONSTRAINT rol_accFK FOREIGN KEY (ROLErole)
	REFERENCES role (role)
		ON UPDATE CASCADE
		ON DELETE CASCADE;

ALTER TABLE address
ADD CONSTRAINT addressFK FOREIGN KEY (countryCode)
	REFERENCES country (code)
		ON UPDATE CASCADE
		ON DELETE RESTRICT;

ALTER TABLE company
ADD CONSTRAINT companyFK FOREIGN KEY (RELATIONrelationNumber)
	REFERENCES relation (relationNumber)
		ON UPDATE CASCADE
		ON DELETE RESTRICT;

ALTER TABLE item
ADD CONSTRAINT itemFK FOREIGN KEY (PRODUCTproductId)
	REFERENCES product (productId)
		ON UPDATE CASCADE
		ON DELETE RESTRICT;

ALTER TABLE `order`
ADD CONSTRAINT orderFK FOREIGN KEY (ACCOUNTusername)
	REFERENCES account (username)
		ON UPDATE CASCADE
		ON DELETE RESTRICT;

ALTER TABLE orderline
ADD CONSTRAINT orderlineFK1 FOREIGN KEY (ORDERorderId)
	REFERENCES `order` (orderId)
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
ADD CONSTRAINT orderlineFK2 FOREIGN KEY (ITEMserialnumber)
	REFERENCES item (serialnumber)
		ON UPDATE CASCADE
		ON DELETE RESTRICT;

ALTER TABLE product
ADD CONSTRAINT productFK FOREIGN KEY (COMPANYRELATIONrelationNumber)
	REFERENCES company (RELATIONrelationNumber)
		ON UPDATE CASCADE
		ON DELETE RESTRICT;

ALTER TABLE relation
ADD CONSTRAINT relationFK FOREIGN KEY (relationType)
	REFERENCES relationType (type)
		ON UPDATE CASCADE
		ON DELETE RESTRICT;

ALTER TABLE relation_address
ADD CONSTRAINT rel_addFK FOREIGN KEY (RELATIONrelationNumber)
	REFERENCES relation (relationNumber)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
ADD CONSTRAINT add_relFK FOREIGN KEY (ADDRESSstreet, ADDRESShousenumber, ADDRESSpostcode)
	REFERENCES address (street, housenumber, postcode)
		ON UPDATE CASCADE
		ON DELETE CASCADE;

ALTER TABLE rent
ADD CONSTRAINT rentFK1 FOREIGN KEY (ORDERLINEorderlineId)
	REFERENCES orderline (orderlineId)
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
ADD CONSTRAINT rentFK2 FOREIGN KEY (ITEMserialNumber)
	REFERENCES item (serialNumber)
		ON UPDATE CASCADE
		ON DELETE CASCADE;

ALTER TABLE role_permission
ADD CONSTRAINT per_rolFK FOREIGN KEY (PERMISSIONpermission)
	REFERENCES permission (permission)
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
ADD CONSTRAINT rol_perFK FOREIGN KEY (ROLErole)
	REFERENCES role (role)
		ON UPDATE CASCADE
		ON DELETE CASCADE;

ALTER TABLE subscription
ADD CONSTRAINT subscriptionFK1 FOREIGN KEY (ORDERLINEorderlineId)
	REFERENCES orderline (orderlineId)
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
ADD CONSTRAINT subscriptionFK2 FOREIGN KEY (ITEMserialNumber)
	REFERENCES item (serialNumber)
		ON UPDATE CASCADE
		ON DELETE RESTRICT;
## -----
