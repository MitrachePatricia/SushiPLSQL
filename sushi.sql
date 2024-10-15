set serveroutput on;

-- deleting the existing tables 

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE PROJECT_BILLS CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE PROJECT_EMPLOYEES CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE CHEFS CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE PROJECT_WAITERS CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE PROJECT_TABLES CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE PROJECT_CUSTOMERS CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE PROJECT_MENU_ITEMS CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE PROJECT_INGREDIENTS CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE PROJECT_INGREDIENT_LISTS CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE PROJECT_ORDERS CASCADE CONSTRAINTS';
END;

--CREATING THE TABLES

BEGIN
   EXECUTE IMMEDIATE 'CREATE TABLE PROJECT_EMPLOYEES(
    employee_id NUMBER(6) CONSTRAINT pk_employees PRIMARY KEY,
    phone_number VARCHAR2(12) CONSTRAINT ck_phone CHECK(phone_number LIKE ''+40%''),
    first_name VARCHAR2(20),
    last_name VARCHAR2(20),
    email VARCHAR2(50) CONSTRAINT ck_email CHECK(email LIKE ''%@%''),
    job_name VARCHAR2(20) NOT NULL,
    hire_date DATE
)';

  EXECUTE IMMEDIATE 'CREATE TABLE CHEFS(
    chef_id NUMBER(6) CONSTRAINT pk_chefs PRIMARY KEY,
    chef_speciality VARCHAR2(20),
    employee_id NUMBER(6) CONSTRAINT fk_chef_employee REFERENCES PROJECT_EMPLOYEES(employee_id),
    CONSTRAINT uk_chefs UNIQUE(employee_id)
)';

  EXECUTE IMMEDIATE 'CREATE TABLE PROJECT_WAITERS(
    waiter_id NUMBER(6) CONSTRAINT pk_waiter PRIMARY KEY,
    employee_id NUMBER(6) CONSTRAINT fk_waiter_employee REFERENCES PROJECT_EMPLOYEES(employee_id),
    CONSTRAINT uk_waiter UNIQUE(employee_id)
)';

  EXECUTE IMMEDIATE 'CREATE TABLE PROJECT_TABLES(
    table_no NUMBER(2) CONSTRAINT pk_table PRIMARY KEY,
    capacity NUMBER(2),
    location VARCHAR2(20)
)';

  EXECUTE IMMEDIATE 'CREATE TABLE PROJECT_CUSTOMERS(
    customer_id NUMBER(7) CONSTRAINT pk_customers PRIMARY KEY,
    customer_name VARCHAR2(50),
    customer_phone VARCHAR2(12) CONSTRAINT ck2_phone CHECK(customer_phone LIKE ''+40%'')
)';

  EXECUTE IMMEDIATE 'CREATE TABLE PROJECT_MENU_ITEMS(
    item_id NUMBER(4) CONSTRAINT pk_menu PRIMARY KEY,
    item_name VARCHAR2(50),
    item_type VARCHAR2(20),
    item_allergens VARCHAR2(50),
    item_price NUMBER(5,2) NOT NULL,
    chef_id NUMBER(6) CONSTRAINT fk_menu_chef REFERENCES CHEFS(chef_id)
)';

  EXECUTE IMMEDIATE 'CREATE TABLE PROJECT_INGREDIENTS(
    ingredient_id NUMBER(4) CONSTRAINT pk_ingredients PRIMARY KEY,
    ingredient_name VARCHAR2(50),
    expiration_date DATE,
    measurement_type VARCHAR2(10),
    ingredient_price_per_measurement NUMBER(5,2)
)';

  EXECUTE IMMEDIATE 'CREATE TABLE PROJECT_INGREDIENT_LISTS(
    list_id NUMBER(5) CONSTRAINT pk_list PRIMARY KEY,
    quantity NUMBER(5),
    item_id NUMBER(4) CONSTRAINT fk_list_item REFERENCES PROJECT_MENU_ITEMS(item_id),
    ingredient_id NUMBER(4) CONSTRAINT fk_list_ingredient REFERENCES PROJECT_INGREDIENTS(ingredient_id)
)';

  EXECUTE IMMEDIATE 'CREATE TABLE PROJECT_ORDERS(
    order_id NUMBER(10) PRIMARY KEY,
    tips NUMBER(5,2),
    order_type VARCHAR2(20),
    item_quantity NUMBER(2),
    waiter_id NUMBER(6) CONSTRAINT fk_order_waiter REFERENCES PROJECT_WAITERS(waiter_id),
    customer_id NUMBER(7) CONSTRAINT fk_order_reservation REFERENCES PROJECT_CUSTOMERS(customer_id),
    table_no NUMBER(2) CONSTRAINT fk_order_table REFERENCES PROJECT_TABLES(table_no),
    item_id NUMBER(4) CONSTRAINT fk_order_item REFERENCES PROJECT_MENU_ITEMS(item_id)
)';

END;

--DDL, ALTERING TABLES:

BEGIN
 EXECUTE IMMEDIATE 'ALTER TABLE CHEFS RENAME TO PROJECT_CHEFS';
END;

BEGIN
 EXECUTE IMMEDIATE 'ALTER TABLE PROJECT_EMPLOYEES ADD (salary NUMBER(9,2))';
END;

BEGIN
 EXECUTE IMMEDIATE 'ALTER TABLE PROJECT_EMPLOYEES DROP CONSTRAINT ck_phone';
 EXECUTE IMMEDIATE 'ALTER TABLE PROJECT_CUSTOMERS DROP CONSTRAINT ck2_phone';
END;

BEGIN
 EXECUTE IMMEDIATE 'ALTER TABLE PROJECT_EMPLOYEES MODIFY (email VARCHAR2(40))';
 EXECUTE IMMEDIATE 'ALTER TABLE PROJECT_CHEFS MODIFY (chef_speciality VARCHAR(60))';
 EXECUTE IMMEDIATE 'ALTER TABLE PROJECT_TABLES MODIFY(location VARCHAR2(50))';
END;

BEGIN 
 EXECUTE IMMEDIATE 'ALTER TABLE PROJECT_CUSTOMERS ADD (reservation_date DATE)';
END;

--inserting data :D

BEGIN 
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_EMPLOYEES (employee_id, phone_number, first_name, last_name, email, job_name, hire_date, salary) VALUES (3212, ''+40732445444'', ''Patricia-Andreea'', ''Mitrache'', ''patriciamitrache@gmail.com'', ''Host'', TO_DATE(''11-03-2020'', ''DD-MM-YYYY''), 90000)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_EMPLOYEES (employee_id, phone_number, first_name, last_name, email, job_name, hire_date, salary) VALUES (54365, ''+40723441073'', ''Jemima'', ''Suharto'', ''Jsuh@gmail.com'', ''Chef'', TO_DATE(''12-02-2020'', ''DD-MM-YYYY''), 80000)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_EMPLOYEES (employee_id, phone_number, first_name, last_name, email, job_name, hire_date, salary) VALUES (78439, ''+40754367125'', ''Carolyn'', ''Radomir'', ''caro2314@gmail.com'', ''Waiter'', TO_DATE(''22-01-2020'', ''DD-MM-YYYY''), 19000)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_EMPLOYEES (employee_id, phone_number, first_name, last_name, email, job_name, hire_date, salary) VALUES (76652, ''+40776243615'', ''Mártuska'', ''Isidora'', ''martuskaisia@hotmail.com'', ''Chef'', TO_DATE(''31-10-2021'', ''DD-MM-YYYY''), 40000)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_EMPLOYEES (employee_id, phone_number, first_name, last_name, email, job_name, hire_date, salary) VALUES (12134, ''+40787824567'', ''Kassidy'', ''Lawson'', ''fdgendiv@yahoo.com'', ''Host'', TO_DATE(''14-05-2022'', ''DD-MM-YYYY''), 50000)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_EMPLOYEES (employee_id, phone_number, first_name, last_name, email, job_name, hire_date, salary) VALUES (12435, ''+40776432156'', ''Vincent'', ''Davis'', ''vincenrloe@yahoo.com'', ''Manager'', TO_DATE(''19-12-2019'', ''DD-MM-YYYY''), 50000)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_EMPLOYEES (employee_id, phone_number, first_name, last_name, email, job_name, hire_date, salary) VALUES (65437, ''+40775422785'', ''Gordon'', ''Emily'', ''ramsey125@john.com'', ''Cook'', TO_DATE(''02-03-2018'', ''DD-MM-YYYY''), 23200)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_EMPLOYEES (employee_id, phone_number, first_name, last_name, email, job_name, hire_date, salary) VALUES (75437, ''+40733214111'', ''Johnnie'', ''Afton'', ''kimojohn@gmail.com'', ''Waiter'', TO_DATE(''04-09-2020'', ''DD-MM-YYYY''), 53000)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_EMPLOYEES (employee_id, phone_number, first_name, last_name, email, job_name, hire_date, salary) VALUES (54671, ''+40769696969'', ''Allice'', ''DeChant'', ''messifan123@yahoo.com'', ''Cleaner'', TO_DATE(''08-11-2022'', ''DD-MM-YYYY''), 19000)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_EMPLOYEES (employee_id, phone_number, first_name, last_name, email, job_name, hire_date, salary) VALUES (24653, ''+40765726886'', ''Jeritza'', ''Noir'', ''jernoir123@yahoo.com'', ''Waiter'', TO_DATE(''08-11-2022'', ''DD-MM-YYYY''), 61000)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_EMPLOYEES (employee_id, phone_number, first_name, last_name, email, job_name, hire_date, salary) VALUES (32145, ''+40769696969'', ''Bonnie'', ''Balsa'', ''balsabon@gmail.com'', ''Chef'', TO_DATE(''08-08-2018'', ''DD-MM-YYYY''), 42000)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_EMPLOYEES (employee_id, phone_number, first_name, last_name, email, job_name, hire_date, salary) VALUES (86542, ''+40720005145'', ''Charles'', ''Degreau'', ''charleseye@gmail.com'', ''Waiter'', TO_DATE(''24-11-2023'', ''DD-MM-YYYY''), 49000)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_EMPLOYEES (employee_id, phone_number, first_name, last_name, email, job_name, hire_date, salary) VALUES (76583, ''+40746467367'', ''Nan-Jho'', ''Kim'', ''rwqenan@hotmail.com'', ''Chef'', TO_DATE(''12-12-2012'', ''DD-MM-YYYY''), 89000)';
END;

BEGIN
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_CHEFS (chef_id, chef_speciality, employee_id) VALUES (1345, ''Chefs special Temaki rolls'', 76652)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_CHEFS (chef_id, chef_speciality, employee_id) VALUES (4351, ''Chef Jemima special vegan plateau'', 54365)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_CHEFS (chef_id, chef_speciality, employee_id) VALUES (2345, ''Ramen Surprise'', 76583)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_CHEFS (chef_id, chef_speciality, employee_id) VALUES (4461, ''-'', 32145)';
END;

BEGIN
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_WAITERS (waiter_id, employee_id) VALUES (24516, 78439)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_WAITERS (waiter_id, employee_id) VALUES (54651, 75437)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_WAITERS (waiter_id, employee_id) VALUES (86347, 24653)';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_WAITERS (waiter_id, employee_id) VALUES (13461, 86542)';
END;

BEGIN
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_TABLES (table_no, capacity, location) VALUES (1, 2, ''Next to the entrance'')';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_TABLES (table_no, capacity, location) VALUES (2, 2, ''On the terrace'')';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_TABLES (table_no, capacity, location) VALUES (3, 4, ''Next to the entrance'')';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_TABLES (table_no, capacity, location) VALUES (4, 4, ''On the terrace'')';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_TABLES (table_no, capacity, location) VALUES (5, 6, ''Next to the drinks bar'')';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_TABLES (table_no, capacity, location) VALUES (6, 6, ''In the centre of the restaurant'')';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_TABLES (table_no, capacity, location) VALUES (7, 4, ''Next to the dessert bar'')';
END;

BEGIN
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_CUSTOMERS (customer_id, customer_name, customer_phone, reservation_date) VALUES (70999, ''Smith'', ''+40782914211'', TO_DATE(''11-03-2024'', ''DD-MM-YYYY''))';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_CUSTOMERS (customer_id, customer_name, customer_phone, reservation_date) VALUES (70009, ''Ashiya'', ''+4074156714'', TO_DATE(''24-01-2024'', ''DD-MM-YYYY''))';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_CUSTOMERS (customer_id, customer_name, customer_phone, reservation_date) VALUES (71346, ''Ionescu'', ''+40723145153'', TO_DATE(''28-02-2024'', ''DD-MM-YYYY''))';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_CUSTOMERS (customer_id, customer_name, customer_phone, reservation_date) VALUES (75671, ''Zalan'', ''+40776783234'', TO_DATE(''05-12-2026'', ''DD-MM-YYYY''))';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_CUSTOMERS (customer_id, customer_name, customer_phone, reservation_date) VALUES (73214, ''Gonjur'', ''+40789178456'', TO_DATE(''31-12-2023'', ''DD-MM-YYYY''))';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_CUSTOMERS (customer_id, customer_name, customer_phone, reservation_date) VALUES (77623, ''Shieda'', ''+40765879824'', TO_DATE(''31-12-2023'', ''DD-MM-YYYY''))';
  EXECUTE IMMEDIATE 'INSERT INTO PROJECT_CUSTOMERS (customer_id, customer_name, customer_phone, reservation_date) VALUES (79814, ''Fennel'', ''+40745346751'', TO_DATE(''25-01-2024'', ''DD-MM-YYYY''))';
END;

BEGIN
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (1, ''MANGO ROLL / 8 BUC'', ''SUSHI ROLLS'', ''Dairy, Fish'', 59.00, 1345)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (2, ''GOLDEN ROLL / 8 BUC'', ''SUSHI ROLLS'', ''Dairy, Fish'', 69.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (3, ''PHILADEPHIA DE LUX  / 8 BUC'', ''SUSHI ROLLS'', ''Dairy, Fish'', 108.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (4, ''OKINAWA SOMON / 8 BUC'', ''SUSHI ROLLS'', ''Dairy, Fish'', 79.00, 1345)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (5, ''BANZAI CLASSIC'', ''TEMPURA / HOT ROLLS'', ''Dairy, Fish'', 59.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (6, ''CRUNCH UNAGHI'', ''MAKI'', ''Dairy, Fish, Eggs'', 79.00, 1345)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (7, ''SOMON MAKI'', ''MAKI'', ''Fish'', 29.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (8, ''KAPA MAKI'', ''MAKI'', ''-'', 15.00, 1345)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (9, ''AVOCADO MAKI'', ''MAKI'', ''-'', 19.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (10, ''VEGETARIAN MAKI'', ''MAKI'', ''-'', 25.00, 1345)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (11, ''SAKE SPICY MAKI'', ''MAKI'', ''Fish'', 30.00, 4351)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (12, ''NIGIRI SOMON'', ''NIGIRI'', ''Fish'', 25.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (13, ''NIGIRI CREVEȚI'', ''NIGITI'', ''Shellfish'', 20.00, 4351)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (14, ''NIGIRI TON'', ''NIGIRI'', ''Fish'', 28.00, 4351)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (15, ''NOODLES DIN HRIȘCĂ CU LEGUME'', ''NOODLES'', ''-'', 38.00, 1345)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (16, ''NOODLES DIN OREZ CU CARNE DE PUI'', ''NOODLES'', ''-'', 38.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (17, ''NOODLES DIN HRIȘCĂ CU FRUCTE DE MARE'', ''NOODLES'', ''Shellfish'', 60.00, 4351)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (18, ''NOODLES DIN HRIȘCĂ CU MUȘCHIULEȚ VITĂ'', ''NOODLES'', ''-'', 70.00, 1345)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (19, ''OREZ SIMPLU'', ''RICE'', ''-'', 11.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (20, ''OREZ CU LEGUME'', ''RICE'', ''-'', 32.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (21, ''OREZ CU FRUCTE DE MARE'', ''RICE'', ''Shellfish'', 56.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (22, ''OREZ CU CARNE DE PUI'', ''RICE'', ''-'', 28.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (23, ''CREVEȚI TEMPURA'', ''ZENSAI'', ''Shellfish'', 56.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (24, ''LEGUME TEMPURA'', ''ZENSAI'', ''-'', 29.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (25, ''GYOZA CU CARNE'', ''ZENSAI'', ''-'', 40.00, 1345)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (26, ''GROZA CU LEGUME'', ''ZENSAI'', ''-'', 35.00, 4351)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (27, ''MOCHI'', ''DESSERT'', ''Dairy, Soy'', 40.00, 1345)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (28, ''EXOTIC ROLL'', ''DESSERT'', ''Dairy'', 33.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (29, ''BANANE PRAJITE'', ''DESSERT'', ''-'', 23.00, 4461)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (30, ''SOS SOYA'', ''EXTRA'', ''Soy'', 5.00, 2345)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (31, ''WASABI'', ''EXTRA'', ''-'', 5.00, 2345)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (32, ''GHIMBIR MARINAT'', ''EXTRA'', ''-'', 5.00, 2345)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_MENU_ITEMS (item_id, item_name, item_type, item_allergens, item_price, chef_id) VALUES (33, ''SOS TERIYAKI'', ''EXTRA'', ''Soy, Sesame'', 5.00, 2345)';
END;

BEGIN
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (40, ''Sushi Rice'', TO_DATE(''25-01-2024'',''DD-MM-RRRR''),''kg'',''10.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (41, ''Tuna'', TO_DATE(''27-02-2024'',''DD-MM-RRRR''),''kg'',''120.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (42, ''Somon'', TO_DATE(''25-12-2023'',''DD-MM-RRRR''),''kg'',''155.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (43, ''Flour'', TO_DATE(''31-12-2023'',''DD-MM-RRRR''),''kg'',''10.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (44, ''Cream cheese'', TO_DATE(''12-11-2023'',''DD-MM-RRRR''),''kg'',''60.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (45, ''Soy Sauce'', TO_DATE(''01-02-2025'',''DD-MM-RRRR''),''liter'',''100.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (46, ''Simple Rice'', TO_DATE(''11-01-2026'',''DD-MM-RRRR''),''kg'',''12.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (47, ''Noodles'', TO_DATE(''25-01-2025'',''DD-MM-RRRR''),''kg'',''40.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (48, ''Teriaky Sauce'', TO_DATE(''24-01-2024'',''DD-MM-RRRR''),''liter'',''39.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (49, ''Seaweed'', TO_DATE(''26-05-2024'',''DD-MM-RRRR''),''kg'',''600.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (50, ''Oil'', TO_DATE(''22-09-2024'',''DD-MM-RRRR''),''liter'',''10.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (51, ''Shrimp'', TO_DATE(''25-12-2023'',''DD-MM-RRRR''),''kg'',''45.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (52, ''Avocado'', TO_DATE(''31-12-2023'',''DD-MM-RRRR''),''kg'',''30.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (53, ''Cucumber'', TO_DATE(''04-01-2024'',''DD-MM-RRRR''),''kg'',''10.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (54, ''Squid'', TO_DATE(''25-12-2023'',''DD-MM-RRRR''),''unit'',''10.00'')';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENTS (ingredient_id, ingredient_name, expiration_date, measurement_type, ingredient_price_per_measurement) VALUES (55, ''Mango'', TO_DATE(''22-12-2023'',''DD-MM-RRRR''),''kg'',''10.00'')';
END;

BEGIN
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENT_LISTS (list_id, quantity, item_id, ingredient_id) VALUES (101, 2, 2, 44)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENT_LISTS (list_id, quantity, item_id, ingredient_id) VALUES (102, 22, 1, 41)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENT_LISTS (list_id, quantity, item_id, ingredient_id) VALUES (103, 27, 4, 53)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENT_LISTS (list_id, quantity, item_id, ingredient_id) VALUES (104, 19, 1, 45)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENT_LISTS (list_id, quantity, item_id, ingredient_id) VALUES (105, 1, 1, 55)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENT_LISTS (list_id, quantity, item_id, ingredient_id) VALUES (106, 32, 5, 55)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENT_LISTS (list_id, quantity, item_id, ingredient_id) VALUES (107, 6, 7, 43)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENT_LISTS (list_id, quantity, item_id, ingredient_id) VALUES (108, 17, 8, 47)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENT_LISTS (list_id, quantity, item_id, ingredient_id) VALUES (109, 29, 2, 53)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENT_LISTS (list_id, quantity, item_id, ingredient_id) VALUES (110, 3, 2, 55)';
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_INGREDIENT_LISTS (list_id, quantity, item_id, ingredient_id) VALUES (111, 27, 6, 55)';
END;

BEGIN
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_ORDERS (order_id, tips, waiter_id, customer_id, table_no, item_id, item_quantity) VALUES (200, 20, 54651, 75671, 1, 33, 1)'; 
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_ORDERS (order_id, tips, waiter_id, customer_id, table_no, item_id, item_quantity) VALUES (201, 15, 24516, 75671, 1, 2, 6)'; 
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_ORDERS (order_id, tips, waiter_id, customer_id, table_no, item_id, item_quantity) VALUES (202, 20, 54651, 73214, 4, 26, 1)'; 
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_ORDERS (order_id, tips, waiter_id, customer_id, table_no, item_id, item_quantity) VALUES (203, 10, 13461, 79814, 4, 18, 6)'; 
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_ORDERS (order_id, tips, waiter_id, customer_id, table_no, item_id, item_quantity) VALUES (204, 25, 54651, 70999, 2, 22, 3)'; 
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_ORDERS (order_id, tips, waiter_id, customer_id, table_no, item_id, item_quantity) VALUES (205, 20, 24516, 70009, 6, 16, 6)'; 
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_ORDERS (order_id, tips, waiter_id, customer_id, table_no, item_id, item_quantity) VALUES (206, 10, 86347, 70009, 7, 19, 8)'; 
    EXECUTE IMMEDIATE 'INSERT INTO PROJECT_ORDERS (order_id, tips, waiter_id, customer_id, table_no, item_id, item_quantity) VALUES (207, 15, 13461, 70009, 5, 28, 2)';
END;

--select statements & in row and group functions 

--1. Display the first and last name of the hosts that have worked for the restaurant for minimum 4 years

DECLARE 
  v_first_name EMPLOYEES.first_name%TYPE;
  v_last_name EMPLOYEES.last_name%TYPE;
BEGIN 
  SELECT FIRST_NAME, LAST_NAME INTO v_first_name, v_last_name
    FROM PROJECT_EMPLOYEES
    WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) >= 4 
      AND UPPER(job_name) = 'HOST';
    DBMS_OUTPUT.PUT_LINE('The host with more than 4 years of experience in the establishment is: '||v_first_name || ' ' || v_last_name);
END;

--2. Display the number of chefs that have a smaller salary than the average one

DECLARE 
  v_count NUMBER;
BEGIN 
  SELECT COUNT(employee_id) INTO v_count FROM project_employees WHERE UPPER(job_name) = 'CHEF' 
    AND salary < 50000;
   DBMS_OUTPUT.PUT_LINE('The number of chefs that have a smaller salary than 50000 is ' || v_count);
END;

--B. Alternative and repetitive structures (IF, CASE, FOR, LOOP, WHILE).

-- display the number of menu items with and without alergens 

DECLARE
    v_no_al NUMBER := 0;
    v_al NUMBER := 0;
BEGIN
    FOR item IN (SELECT ITEM_ALLERGENS FROM PROJECT_MENU_ITEMS) LOOP
        IF item.ITEM_ALLERGENS = '-' THEN
            v_no_al := v_no_al + 1;
        ELSE
            v_al := v_al + 1;
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Items with allergens: ' || v_al);
    DBMS_OUTPUT.PUT_LINE('Items with no allergens: ' || v_no_al);
END;

-- create an index by table data collection to display all the menu items that have the item type 'SUSHI ROLLS'

DECLARE
  TYPE T_SUSHI_ROLLS IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
  V T_SUSHI_ROLLS;
BEGIN
  SELECT ITEM_NAME BULK COLLECT INTO V FROM PROJECT_MENU_ITEMS
        WHERE ITEM_TYPE = 'SUSHI ROLLS';
  DBMS_OUTPUT.PUT_LINE(V.COUNT);
  FOR I IN V.FIRST..V.LAST LOOP
   IF V.EXISTS(I) THEN
     DBMS_OUTPUT.PUT_LINE(I||'.'||V(I));
   END IF;  
  END LOOP;
END;
/

-- create a nested table in otder to store and display the chef specialties

DECLARE
  TYPE specialty_table IS TABLE OF VARCHAR2(50);
  v_specialties specialty_table := specialty_table();
BEGIN
  v_specialties.EXTEND;
  v_specialties(1) := 'Chefs special Temaki rolls';
  v_specialties.EXTEND;
  v_specialties(2) := 'Chef Jemima special vegan plateau';
  v_specialties.EXTEND;
  v_specialties(3) := 'Ramen Surprise';

  FOR i IN 1..v_specialties.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(i||'.'||v_specialties(i));
  END LOOP;
END;

--create a varray in order to stoare and display all the available locations for sitting

DECLARE
  TYPE location_varray IS VARRAY(5) OF VARCHAR2(50);
  v_locations location_varray := location_varray('Next to the entrance', 'On the terrace', 'Next to the drinks bar','In the centre of the restaurant','Next to the dessert bar');
  v_table_no NUMBER;
BEGIN
  FOR i IN 1..v_locations.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Table no '||i||' is located '||LOWER(v_locations(i)));
  END LOOP;
END;

--create a procedure to delete a customer

CREATE OR REPLACE PROCEDURE delete_customer(pro_id NUMBER) IS 
BEGIN
  DELETE FROM PROJECT_CUSTOMERS 
  WHERE customer_id = pro_id;
END;

BEGIN
  delete_customer(31413);
END;

--create a trigger that verifies if a reservation date is in one of the working dates (the restaurant is closed on mondays)

CREATE OR REPLACE TRIGGER check_reservation_date
BEFORE INSERT OR UPDATE ON project_customers
FOR EACH ROW
DECLARE
    v_working_date NUMBER;
BEGIN
    v_working_date := TO_NUMBER(TO_CHAR(:NEW.reservation_date, 'DD'));
    IF v_working_date BETWEEN 3 AND 10 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Reservations cannot be made from the 3rd to the 10th of each month. Please choose another date.');
    END IF;
END;

INSERT INTO project_customers (customer_id, customer_name, reservation_date) VALUES (68903, 'Veritas', TO_DATE('2024-05-05', 'YYYY-MM-DD'));
INSERT INTO project_customers (customer_id, customer_name, reservation_date) VALUES (68903, 'Jordan', TO_DATE('2024-25-05', 'YYYY-DD-MM'));

--use an explicit cursor in order to display the name and expiration date of the ingredients that expired on before 1st of February 2024

DECLARE
  CURSOR c_expired_ingredients IS
    SELECT ingredient_name, expiration_date
    FROM project_ingredients
    WHERE expiration_date < TO_DATE('2024-02-01', 'YYYY-MM-DD');

  v_ingredient_name project_ingredients.ingredient_name%TYPE;
  v_expiration_date project_ingredients.expiration_date%TYPE;
BEGIN

  OPEN c_expired_ingredients;
  
  LOOP
    FETCH c_expired_ingredients INTO v_ingredient_name, v_expiration_date;
    EXIT WHEN c_expired_ingredients%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Ingredient ' || v_ingredient_name || ' expired on : ' || TO_CHAR(v_expiration_date, 'YYYY-MM-DD'));
  END LOOP;
  CLOSE c_expired_ingredients;
END;

--display the menu_items that are more expensive than a given value (50)

DECLARE
  CURSOR c_expensive (p_val NUMBER) IS
   SELECT item_name, item_price
   FROM project_menu_items
   WHERE item_price > p_val;
  v_menu_item_name project_menu_items.item_name%TYPE;
  v_price project_menu_items.item_price%TYPE;
  n_val NUMBER(3):= 50;
 BEGIN 
   DBMS_OUTPUT.PUT_LINE('The products that have a price higer than '|| n_val ||' lei:');
   OPEN c_expensive (n_val);
  LOOP
   FETCH c_expensive into v_menu_item_name, v_price;
   EXIT WHEN c_expensive%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE(v_menu_item_name || ' costs ' || v_price ||' lei');
  END LOOP;
 CLOSE c_expensive;
END;

BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE PROJECT_ORDERS RENAME COLUMN ORDER_TYPE TO BILL';
END;

--Create a package that contains a  procedure and a function. 
--The procedure returns the number of customers that made no orders and the function displays that number and returns YES or NO if a customer made orders or not.

--Create a procedure that return the reservation date and name of a customer whose id is given

CREATE OR REPLACE PROCEDURE pr_customer
(p_cust_id IN NUMBER,
p_name OUT project_customers.customer_name%TYPE,
p_date OUT project_customers.reservation_date%TYPE)
IS
BEGIN 
 SELECT customer_name,reservation_date into p_name, p_date FROM project_customers 
 WHERE customer_id = p_cust_id;
END;

DECLARE
 p_name project_customers.customer_name%TYPE;
 p_date project_customers.reservation_date%TYPE;
BEGIN
 pr_customer(70999, p_name, p_date);
 DBMS_OUTPUT.PUT_LINE('The employee '||p_name||' has a reservation on the date: '||p_date);
END;


--create a function that returns if a table has the capacity larger than 4

CREATE OR REPLACE FUNCTION f_available
(p_table_no IN project_tables.table_no%TYPE)
  RETURN VARCHAR2
  IS
  v_cap project_tables.capacity%type;
BEGIN
  SELECT capacity into v_cap from project_tables where table_no = p_table_no;
  DBMS_OUTPUT.PUT_LINE('The capacity is '||v_cap);
  IF v_cap > 4 THEN
   RETURN 'YES';
  ELSE
   return 'NO';
  END IF;
EXCEPTION 
  WHEN no_data_found THEN
  return 'NO';
END;

select f_available(7) from dual;

--Create a function that return the value of the order placed by a customer using their id

CREATE OR REPLACE FUNCTION GET_ORDERS_VALUE(P_CUSTOMER_ID NUMBER) RETURN NUMBER IS
V_VAL NUMBER;
BEGIN
  SELECT SUM(ITEM_PRICE*ITEM_QUANTITY) INTO V_VAL FROM project_orders O JOIN project_menu_items mi ON O.item_id=mi.item_id
     WHERE o.CUSTOMER_ID=P_CUSTOMER_ID;
  IF SQL%NOTFOUND then
  DBMS_OUTPUT.PUT_LINE('The customer does not exist');
  END IF;

  RETURN V_VAL;
  EXCEPTION
WHEN no_data_found THEN
return NULL;
END;

select get_orders_value(70009) from dual;

--Raise an exception when someone tries to acess the PL\SQL block outside work hours

DECLARE
e_hour EXCEPTION;

BEGIN
IF TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'))<=11 OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'))>=23 THEN
RAISE e_hour;
END IF;

EXCEPTION
WHEN e_hour THEN
dbms_output.put_line('It is '||TO_CHAR(SYSDATE, 'HH24'));
dbms_output.put_line('You cannot access the database at this hour.');
END;


--Create a trigger that prevents decreasing the salary of the chefs

CREATE OR REPLACE TRIGGER restrict_chefs
BEFORE UPDATE ON PROJECT_EMPLOYEES
FOR EACH ROW
BEGIN
   DBMS_OUTPUT.PUT_LINE(:NEW.LAST_NAME||' HAS A JOB OF '||:NEW.JOB_NAME||' AN OLD SALARY OF '||:OLD.SALARY||
   ' AND A NEW SALARY OF '||:NEW.SALARY);
   IF :NEW.SALARY<:OLD.SALARY AND :NEW.JOB_NAME='Chef' THEN
    RAISE_APPLICATION_ERROR(-20001,'We cannot decrease the salary of the chefs.');      
   END IF;
 END;


SELECT * FROM PROJECT_EMPLOYEES WHERE EMPLOYEE_ID BETWEEN 70000 AND 100000;
UPDATE project_EMPLOYEES SET SALARY=SALARY-10*SALARY/100 WHERE EMPLOYEE_ID BETWEEN 70000 AND 100000;
  

--Create a trigger that prevents tables from being deleted

CREATE OR REPLACE TRIGGER t_delete
BEFORE DELETE ON PROJECT_TABLES
BEGIN 
  RAISE_APPLICATION_ERROR(-20004, 'Deletions from TABLES table is forbidden.');
END;

DELETE FROM PROJECT_TABLES WHERE table_no = 3;

--Create a trigger that is raised each time a the ingredients table is updated; 

CREATE OR REPLACE TRIGGER t_ingredients_update
BEFORE UPDATE ON PROJECT_INGREDIENTS
  BEGIN dbms_output.put_line('An update was triggered at '||SYSDATE);
END;

BEGIN   
  UPDATE PROJECT_INGREDIENTS
  SET expiration_date = ADD_MONTHS(SYSDATE, 2) --we restock the expired ingredients today
  WHERE expiration_date < SYSDATE;
END;

  