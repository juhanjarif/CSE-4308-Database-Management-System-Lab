DROP TABLE ACCOUNT;
DROP TABLE CUSTOMER;

CREATE TABLE ACCOUNT
(
    ACCOUNT_NUM VARCHAR2(10),
    BALANCE FLOAT,
    CONSTRAINT BALANCE_CHECK CHECK (BALANCE >= 0)
);
CREATE TABLE CUSTOMER
(
    CUSTOMER_NO VARCHAR2(10),
    CUSTOMER_NAME VARCHAR2(20) NOT NULL,
    CUSTOMER_CITY VARCHAR2(50),
    CONSTRAINT PK_CUSTOMER_NO PRIMARY KEY(CUSTOMER_NO)
);

INSERT INTO ACCOUNT (ACCOUNT_NUM, BALANCE) VALUES ('A-101', 1200.05);
INSERT INTO ACCOUNT (ACCOUNT_NUM, BALANCE) VALUES ('A-102', 320.00);
INSERT INTO ACCOUNT (ACCOUNT_NUM, BALANCE) VALUES ('A-103', 2600.00);
INSERT INTO ACCOUNT (ACCOUNT_NUM, BALANCE) VALUES ('A-104', 3100.25);
INSERT INTO ACCOUNT (ACCOUNT_NUM, BALANCE) VALUES ('A-105', 1600.50);
INSERT INTO ACCOUNT (ACCOUNT_NUM, BALANCE) VALUES ('P-101', 13000.00);
INSERT INTO ACCOUNT (ACCOUNT_NUM, BALANCE) VALUES ('P-102', 8100.00);
INSERT INTO ACCOUNT (ACCOUNT_NUM, BALANCE) VALUES ('A-106', 0.00);
INSERT INTO ACCOUNT (ACCOUNT_NUM, BALANCE) VALUES ('A-107', 120.60);

INSERT INTO CUSTOMER (CUSTOMER_NO, CUSTOMER_NAME, CUSTOMER_CITY) VALUES ('C-101', 'Niko', 'Liberty City');
INSERT INTO CUSTOMER (CUSTOMER_NO, CUSTOMER_NAME, CUSTOMER_CITY) VALUES ('C-102', 'Tommy', 'Vice City');
INSERT INTO CUSTOMER (CUSTOMER_NO, CUSTOMER_NAME, CUSTOMER_CITY) VALUES ('C-103', 'Trevor', 'Bone County');
INSERT INTO CUSTOMER (CUSTOMER_NO, CUSTOMER_NAME, CUSTOMER_CITY) VALUES ('C-104', 'Carl', 'Los Santos');
INSERT INTO CUSTOMER (CUSTOMER_NO, CUSTOMER_NAME, CUSTOMER_CITY) VALUES ('C-105', 'Lucia', 'Vice City');

ALTER TABLE CUSTOMER ADD DATE_OF_BIRTH DATE;
ALTER TABLE CUSTOMER RENAME COLUMN CUSTOMER_NO TO CUSTOMER_NUM;
ALTER TABLE ACCOUNT ADD CONSTRAINT PK_ACCOUNT_NUM PRIMARY KEY(ACCOUNT_NUM);

SELECT ACCOUNT_NUM FROM ACCOUNT WHERE BALANCE < (2 * (SELECT ACCOUNT_NUM FROM ACCOUNT WHERE ACCOUNT_NUM = 'A-101'));
SELECT CUSTOMER_NO, CUSTOMER_NAME FROM CUSTOMER WHERE CUSTOMER_CITY = 'Vice City';
SELECT CUSTOMER_NO, CUSTOMER_NAME FROM CUSTOMER WHERE CUSTOMER_CITY != 'Bone County';
UPDATE ACCOUNT SET BALANCE = (0.75 * (SELECT BALANCE FROM ACCOUNT WHERE ACCOUNT_NUM = 'P-101')) WHERE ACCOUNT_NUM = 'P-101';
UPDATE ACCOUNT SET BALANCE = (0.75 * (SELECT BALANCE FROM ACCOUNT WHERE ACCOUNT_NUM = 'P-102')) WHERE ACCOUNT_NUM = 'P-102';
UPDATE ACCOUNT SET BALANCE = ((SELECT BALANCE FROM ACCOUNT WHERE ACCOUNT_NUM = 'A-105') - 200.00) WHERE ACCOUNT_NUM = 'A-105';
UPDATE ACCOUNT SET BALANCE = ((SELECT BALANCE FROM ACCOUNT WHERE ACCOUNT_NUM = 'A-107') + 200.00) WHERE ACCOUNT_NUM = 'A-107';

DELETE FROM ACCOUNT WHERE BALANCE < (SELECT BALANCE FROM ACCOUNT WHERE ACCOUNT_NUM = 'A-107');

ALTER TABLE ACCOUNT ADD CUSTOMER_NUM VARCHAR2(20);

UPDATE ACCOUNT A
SET CUSTOMER_NUM = (
    SELECT C.CUSTOMER_NO
    FROM CUSTOMER C
    WHERE C.CUSTOMER_NO = 'C-' || SUBSTR(A.ACCOUNT_NUM, 3)
);

SELECT C.CUSTOMER_NAME
FROM CUSTOMER C
JOIN ACCOUNT A ON C.CUSTOMER_NO = A.CUSTOMER_NUM
WHERE A.BALANCE < 2000;

SELECT CUSTOMER_CITY
FROM CUSTOMER C
JOIN ACCOUNT A ON C.CUSTOMER_NO = A.CUSTOMER_NUM
GROUP BY CUSTOMER_CITY
ORDER BY AVG(A.BALANCE) ASC
FETCH FIRST 1 ROWS ONLY;
