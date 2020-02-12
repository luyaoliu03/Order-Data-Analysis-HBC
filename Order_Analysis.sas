/*-------------------------------------------Order (Customer & Product) level----------------------------------------------*/

libname SDDB oracle user=dorisliu pass='****' path=neworacle  schema=SDMRK;

/*1.Find customers, orders, demand, returns, cancel, net, gross for Nov FY19, in both $ and units*/

%LET NovFY19start = '03Nov2019:00:00:00'DT;
%LET NovFY19end = '30Nov2019:23:59:59'DT;

/*1.(1) By SaksFirst*/

/* Order_Line_Status: X - Cancel, R - Return, D - Deal */

PROC SQL;
CREATE TABLE Order_SaksFirst AS
	SELECT COUNT( DISTINCT(INDIVIDUAL_ID) ) AS CUSTOMERS,
	       COUNT( DISTINCT(ORDER_NUMBER) ) AS ORDERS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D','R','X') THEN DEMAND_DOLLARS /*DEMAND in $ & unit*/
		   	     END) AS DEMAND_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D','R','X') THEN DEMAND_UNITS
		   	     END) AS DEMAND_UNITS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'R' THEN DEMAND_DOLLARS /*RETURN in $ & unit*/
			     END) AS RETURN_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'R' THEN DEMAND_UNITS
			     END) AS RETURN_UNITS, 
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'X' THEN DEMAND_DOLLARS /*CANCEL in $ & unit*/
			     END) AS CANCEL_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'X' THEN DEMAND_UNITS
			     END) AS CANCEL_UNITS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'D' THEN DEMAND_DOLLARS /*NET in $ & unit*/
			     END) AS NET_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'D' THEN DEMAND_UNITS
			     END) AS NET_UNITS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D', 'R') THEN DEMAND_DOLLARS /*GROSS in $ & unit*/
		   	     END) AS GROSS_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D', 'R') THEN DEMAND_UNITS
		   	     END) AS GROSS_UNITS,
	       SAKS_FIRST_INDICATOR
	FROM Sddb.Orders
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end
	GROUP BY SAKS_FIRST_INDICATOR;
QUIT;


/*By Saks First Tier*/

PROC SQL;
CREATE TABLE Order_SaksFirst_Tier AS
	SELECT COUNT( DISTINCT(A.INDIVIDUAL_ID) ) AS CUSTOMERS,
	       COUNT( DISTINCT(ORDER_NUMBER) ) AS ORDERS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D','R','X') THEN DEMAND_DOLLARS /*DEMAND in $ & unit*/
		   	     END) AS DEMAND_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D','R','X') THEN DEMAND_UNITS
		   	     END) AS DEMAND_UNITS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'R' THEN DEMAND_DOLLARS /*RETURN in $ & unit*/
			     END) AS RETURN_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'R' THEN DEMAND_UNITS
			     END) AS RETURN_UNITS, 
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'X' THEN DEMAND_DOLLARS /*CANCEL in $ & unit*/
			     END) AS CANCEL_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'X' THEN DEMAND_UNITS
			     END) AS CANCEL_UNITS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'D' THEN DEMAND_DOLLARS /*NET in $ & unit*/
			     END) AS NET_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'D' THEN DEMAND_UNITS
			     END) AS NET_UNITS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D', 'R') THEN DEMAND_DOLLARS /*GROSS in $ & unit*/
		   	     END) AS GROSS_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D', 'R') THEN DEMAND_UNITS
		   	     END) AS GROSS_UNITS,
	       SAKS_FIRST_TIER
	FROM Sddb.Orders A
	JOIN Sddb.Individual B
	ON A.INDIVIDUAL_ID = B.INDIVIDUAL_ID
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end
	GROUP BY SAKS_FIRST_TIER;
QUIT;


/*1.(2) By Employees*/

PROC SQL;
CREATE TABLE Order_Employees AS
	SELECT COUNT( DISTINCT(INDIVIDUAL_ID) ) AS CUSTOMERS,
	       COUNT( DISTINCT(ORDER_NUMBER) ) AS ORDERS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D','R','X') THEN DEMAND_DOLLARS /*DEMAND in $ & unit*/
		             END) AS DEMAND_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D','R','X') THEN DEMAND_UNITS
		   	     END) AS DEMAND_UNITS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'R' THEN DEMAND_DOLLARS /*RETURN in $ & unit*/
			     END) AS RETURN_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'R' THEN DEMAND_UNITS
			     END) AS RETURN_UNITS, 
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'X' THEN DEMAND_DOLLARS /*CANCEL in $ & unit*/
			     END) AS CANCEL_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'X' THEN DEMAND_UNITS
			     END) AS CANCEL_UNITS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'D' THEN DEMAND_DOLLARS /*NET in $ & unit*/
			     END) AS NET_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'D' THEN DEMAND_UNITS
			     END) AS NET_UNITS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D', 'R') THEN DEMAND_DOLLARS /*GROSS in $ & unit*/
		   	     END) AS GROSS_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D', 'R') THEN DEMAND_UNITS
		   	     END) AS GROSS_UNITS,
	       EMPLOYEE_INDICATOR
	FROM Sddb.Orders
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end
	GROUP BY EMPLOYEE_INDICATOR;
QUIT;

/*1.(3) For Women's Apparel*/
/*Group ID = 14, 25*/

PROC SQL;
CREATE TABLE Order_WMapparel AS
	SELECT COUNT( DISTINCT(INDIVIDUAL_ID) ) AS CUSTOMERS,
	       COUNT( DISTINCT(ORDER_NUMBER) ) AS ORDERS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D','R','X') THEN DEMAND_DOLLARS /*DEMAND in $ & unit*/
		   	     END) AS DEMAND_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D','R','X') THEN DEMAND_UNITS
		   	     END) AS DEMAND_UNITS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'R' THEN DEMAND_DOLLARS /*RETURN in $ & unit*/
			     END) AS RETURN_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'R' THEN DEMAND_UNITS
			     END) AS RETURN_UNITS, 
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'X' THEN DEMAND_DOLLARS /*CANCEL in $ & unit*/
			     END) AS CANCEL_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'X' THEN DEMAND_UNITS
			     END) AS CANCEL_UNITS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'D' THEN DEMAND_DOLLARS /*NET in $ & unit*/
			     END) AS NET_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS = 'D' THEN DEMAND_UNITS
			     END) AS NET_UNITS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D', 'R') THEN DEMAND_DOLLARS /*GROSS in $ & unit*/
		   	     END) AS GROSS_DOLLARS,
	       SUM(CASE WHEN ORDER_LINE_STATUS IN ('D', 'R') THEN DEMAND_UNITS
		   	     END) AS GROSS_UNITS,
	FROM Sddb.Orders
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end 
	AND GROUP_ID IN ('14','25');
QUIT;


/*2.What were top 10 products (not skus) purchased in Nov FY19*/
/*Product ID = PRODUCT_CODE*/ /*Product Name: BRAND_NAME + BM_DESC*/
/*But there're other order_line_status if we don't limit it to D,X,R but we don't care*/

PROC SQL OUTOBS = 10;
CREATE TABLE TopProduct_Nov AS
	SELECT PRODUCT_CODE, 
	       SUM(Demand_UNITS) AS Sum_Demand_Units
	FROM Sddb.Orders A
	LEFT JOIN Sddb.Product B
	ON A.SKU = B.SKU
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end
	GROUP BY 1
	ORDER BY 2 DESC;
QUIT;

/*To discover the Brand & Description*/
PROC SQL;
CREATE TABLE TopProductName_Nov AS
	SELECT B.PRODUCT_CODE,
	       B.BRAND_NAME,
	       B.BM_DESC,
	       SUM(DEMAND_UNITS) AS Sum_Demand_Units
	FROM Sddb.Orders A
	LEFT JOIN Sddb.Product B
	ON A.SKU = B.SKU
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end
	AND B.PRODUCT_CODE IN
		(SELECT PRODUCT_CODE
		FROM Work.TopProduct_Nov
); 

/*what about top 10 products purchased on the app*/
/*Order_Type -- and: android; iph: iphone iOS; TEL: Call Center; WEB: full site; MOB: m site; ipd: tablet; STR: store*/

PROC SQL OUTOBS = 10;
CREATE TABLE TopProduct_Nov_app AS
	SELECT PRODUCT_CODE, 
	       SUM(Demand_UNITS) AS Sum_Demand_Units
	FROM Sddb.Orders A
	LEFT JOIN Sddb.Product B
	ON A.SKU = B.SKU
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end
	AND ORDER_TYPE IN ('and', 'iph')
	GROUP BY 1
	ORDER BY 2 DESC;
QUIT;

/*3. What were top 10 brands by revenue in Nov FY19*/

PROC SQL OUTOBS = 10;
CREATE TABLE TopBrand_Nov AS
	SELECT BRAND_NAME, 
	SUM(Demand_DOLLARS) AS Sum_Demand_Dollars
	FROM Sddb.Orders A
	LEFT JOIN Sddb.Product B 
	ON A.SKU = B.SKU
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end
	GROUP BY 1
	ORDER BY 2 DESC;
QUIT;

/*4. What were top 10 international countries shipped to in Nov FY19*/

PROC SQL OUTOBS = 10;
	CREATE TABLE TopIntlcountr_Dec AS
	SELECT COUNTRY, 
	COUNT(DISTINCT ORDER_NUMBER) AS SUM_ORDER_NUMBER
	FROM Sddb.Orders A
	LEFT JOIN Sddb.Address B
	ON A.SHIP_TO_ADDRESS_ID = B.ADDRESS_ID  /**transfer datatype if it's scientific number**/
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end
	GROUP BY COUNTRY
	ORDER BY 2;
QUIT;


/*5.What are interesting findings for those who shop both shoes and kids in Nov FY19*/

/*Calculate the base - the number of orders in which people shopped both shoes and kids*/

PROC SQL;
CREATE TABLE Insights_0 AS
	SELECT COUNT(DISTINCT(ORDER_NUMBER)) AS sum_orders
	FROM Sddb.Orders  
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end 
	AND Orders.GROUP_ID IN ('35','36')
;
QUIT;

/*Explore the percentage of conversion in each device channel (APP, Site, Store...) and compare them by AOV*/

PROC SQL;
CREATE TABLE Insights_1 AS
	SELECT 
	ORDER_TYPE,
	100 * (COUNT(DISTINCT(ORDER_NUMBER))/ (SELECT sum_orders FROM Insights_0) ) AS PERCENTAGE,
	SUM(DEMAND_DOLLARS)/ COUNT(DISTINCT(ORDER_NUMBER)) AS AOV
	FROM Sddb.Orders
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end 
	AND Orders.GROUP_ID IN ('35','36')
	GROUP BY 1
	ORDER BY 2 DESC;
QUIT;

/*Explore the percentage of conversion and AOV by Saksfirst*/
PROC SQL;
CREATE TABLE Insights_2 AS
	SELECT 
	SAKS_FIRST_INDICATOR,
	100 * (COUNT(DISTINCT(ORDER_NUMBER))/ (SELECT sum_orders FROM Insights_0) ) AS PERCENTAGE,
	SUM(DEMAND_DOLLARS)/ COUNT(DISTINCT(ORDER_NUMBER)) AS AOV
	FROM Sddb.Orders
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end 
	AND Orders.GROUP_ID IN ('35','36')
	GROUP BY 1
	ORDER BY 2 DESC;
QUIT;

/*Explore the percentage of conversion and AOV by Registered customers*/
PROC SQL;
CREATE TABLE Insights_3 AS
	SELECT 
	REGISTERED_CUSTOMER,
	COUNT(DISTINCT(A.ORDER_NUMBER)) AS SUM_ORDERS,
	SUM(DEMAND_DOLLARS)/ COUNT(DISTINCT(A.ORDER_NUMBER)) AS AOV
	FROM Sddb.Orders AS A
	LEFT JOIN Sddb.Customer AS B
	ON A.CUSTOMER_NUMBER = B.CUSTOMER_ID
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end 
	AND Orders.GROUP_ID IN ('35','36')
	GROUP BY 1
	ORDER BY 2 DESC;
QUIT;


/*Explore the percentage of conversion and AOV by Employee*/
PROC SQL;
CREATE TABLE Insights_5 AS
	SELECT 
	EMPLOYEE_INDICATOR,
	100 * (COUNT(DISTINCT(ORDER_NUMBER))/ (SELECT sum_orders FROM Insights_0) ) AS PERCENTAGE
	FROM Sddb.Orders
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end 
	AND Orders.GROUP_ID IN ('35','36')
	GROUP BY 1
	ORDER BY 2 DESC;
QUIT;

/*Explore top 10 State that ordered*/
PROC SQL OUTOBS = 10;
	CREATE TABLE Insights_6 AS
	SELECT STATE, 
	COUNT(DISTINCT ORDER_NUMBER) AS SUM_ORDER_NUMBER
	FROM Sddb.Orders AS A
	LEFT JOIN Sddb.Customer AS B 
	ON A.INDIVIDUAL_ID = B.INDIVIDUAL_ID  /**transfer datatype since it's scientific number**/
	WHERE ORDERDATE GE &NovFY19start AND ORDERDATE LE &NovFY19end
	GROUP BY 1
	ORDER BY 2 DESC;
QUIT;
