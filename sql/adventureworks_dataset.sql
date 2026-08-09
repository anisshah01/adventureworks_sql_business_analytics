DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS territories;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS product_subcategories;
DROP TABLE IF EXISTS product_categories;
DROP TABLE IF EXISTS customers;


CREATE TABLE Customers (
    CustomerKey INT PRIMARY KEY,
    Prefix VARCHAR(10),
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    BirthDate DATE,
    MaritalStatus VARCHAR(20),
    Gender VARCHAR(10),
    Email VARCHAR(255),
    AnnualIncome DECIMAL(10,4),
    TotalChildren INT,
    EducationLevel VARCHAR(100),
    Occupation VARCHAR(100),
    HomeOwner VARCHAR(10)
);
CREATE TABLE  ProductCategories (
    ProductCategoryKey INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);
CREATE TABLE ProductSubcategories (
    ProductSubcategoryKey INT PRIMARY KEY,
    SubcategoryName VARCHAR(100),
    ProductCategoryKey INT,
    FOREIGN KEY (ProductCategoryKey) REFERENCES ProductCategories (ProductCategoryKey)
);
CREATE TABLE Products (
    ProductKey INT PRIMARY KEY,
    ProductSubcategoryKey INT,
    ProductSKU VARCHAR(100),
    ProductName VARCHAR(255),
    ModelName VARCHAR(100),
    ProductDescription TEXT,
    ProductColor VARCHAR(50),
    ProductSize VARCHAR(20),
    ProductStyle VARCHAR(20),
    ProductCost DECIMAL(10,4),
    ProductPrice DECIMAL(10,4),
    FOREIGN KEY (ProductSubcategoryKey) REFERENCES ProductSubcategories (ProductSubcategoryKey)
);
CREATE TABLE Territories (
    SalesTerritoryKey INT PRIMARY KEY,
    Region VARCHAR(100),
    Country VARCHAR(255),
    Continent VARCHAR(100)
);
CREATE TABLE Sales (
    OrderDate DATE,
    StockDate DATE,
    OrderNumber VARCHAR(100),
    ProductKey INT,
    CustomerKey INT,
    TerritoryKey INT,
    OrderLineItem INT,
    OrderQuantity INT,
    FOREIGN KEY (ProductKey) REFERENCES Products (ProductKey),
    FOREIGN KEY (CustomerKey) REFERENCES Customers (CustomerKey),
    FOREIGN KEY (TerritoryKey) REFERENCES Territories (SalesTerritoryKey)
);
CREATE TABLE Returns (
    ReturnDate DATE,
    TerritoryKey INT,
    ProductKey INT,
    ReturnQuantity INT,
    FOREIGN KEY (TerritoryKey) REFERENCES Territories (SalesTerritoryKey),
    FOREIGN KEY (ProductKey) REFERENCES Products (ProductKey)
);
CREATE TABLE calender (
    date DATE
);
