-- Tạo database 
create database ShopDT;
use ShopDT;
--PHẦN 1 TẠO BẢNG
--Tạo bảng khách hàng
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),--Khóa chính, tự tăng
    FullName NVARCHAR(100),                  --Họ tên khách hàng
    Phone VARCHAR(15),                       --Số điện thoại
    Email VARCHAR(100),                      --Email liên hệ    
    Address NVARCHAR(200),                   --Địa chỉ khách hàng
    RegisterDate Date                        --Ngày đăng ký
);

--Tạo bảng Thông tin điện thoại
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),--Khóa chính, tự tăng
    ProductName NVARCHAR(100),              --Tên điện thoại
    Brand NVARCHAR(50),                     --Hãng( Apple, Samsung, Oppo,..)
    Model NVARCHAR(50),                     --Mã Model
    Price DECIMAL(12,2),                    --Giá bán
    Stock int,                              --Số lượng tồn kho
    ReleaseYear int                         --Năm phát hành
);

--Tạo bảng đơn hàng
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),--Khóa chính, tự tăng
    CustomerID int,                       --Khóa ngoại
    OrderDate DATE,                       --Ngày đặt hàng
    TotalAmount DECIMAL(12,2),            --Tổng tiền
    Status NVARCHAR(20),                  --Trạng thái
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Bảng Chi tiết đơn hàng
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),  -- Khóa chính
    OrderID INT,                                  -- FK → Orders
    ProductID INT,                                -- FK → Products
    Quantity INT,                                 -- Số lượng
    UnitPrice DECIMAL(12,2),                      -- Giá tại thời điểm bán
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Bảng Nhà cung cấp
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),  -- Khóa chính
    SupplierName NVARCHAR(100),                -- Tên nhà cung cấp
    Phone VARCHAR(15),                         -- Điện thoại
    Address NVARCHAR(200)                      -- Địa chỉ
);
--PHẦN 2 THÊM THÔNG TIN VÀO BẢNG
--Thêm thông tin vào bảng khách hàng
INSERT INTO Customers (FullName, Phone, Email, Address, RegisterDate) VALUES
(N'Nguyễn Văn A', '0901111111', 'vana@gmail.com', N'Hồ Chí Minh', '2025-01-10'),
(N'Trần Thị B', '0902222222', 'thib@gmail.com', N'Hà Nội', '2025-02-15'),
(N'Lê Văn C', '0903333333', 'vanc@gmail.com', N'Hồ Chí Minh', '2025-03-05'),
(N'Phạm Thị D', '0904444444', 'thid@gmail.com', N'Đà Nẵng', '2025-04-20'),
(N'Hoàng Văn E', '0905555555', 'vane@gmail.com', N'Cần Thơ', '2025-05-12');

--Thêm thông tin vào bảng sản phẩm
INSERT INTO Products (ProductName, Brand, Model, Price, Stock, ReleaseYear) VALUES
(N'iPhone 14 Pro Max', N'Apple', N'A2894', 30000000, 15, 2023),
(N'iPhone 13', N'Apple', N'A2633', 20000000, 10, 2022),
(N'Samsung Galaxy S23 Ultra', N'Samsung', N'S918B', 25000000, 20, 2023),
(N'Samsung Galaxy A54', N'Samsung', N'A546E', 10000000, 30, 2023),
(N'Xiaomi Redmi Note 12', N'Xiaomi', N'2209116AG', 7000000, 25, 2023),
(N'Oppo Reno8', N'Oppo', N'CPH2359', 12000000, 12, 2022),
(N'Vivo V27', N'Vivo', N'V2231', 11000000, 8, 2023);

--Thêm thông tin vào bảng đơn hàng
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status) VALUES
(1, '2025-09-01', 30500000, N'Paid'),
(2, '2025-09-02', 20000000, N'Pending'),
(3, '2025-09-05', 26000000, N'Shipped'),
(4, '2025-09-07', 10000000, N'Paid'),
(5, '2025-09-10', 12000000, N'Paid');

--Thêm thông tin vào bảng chi tiết đơn hàng
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
-- Đơn hàng 1: Nguyễn Văn A
(1, 1, 1, 30000000),   -- iPhone 14 Pro Max
(1, 2, 1, 500000),     -- Chuột giả định

-- Đơn hàng 2: Trần Thị B
(2, 2, 1, 20000000),   -- iPhone 13

-- Đơn hàng 3: Lê Văn C
(3, 3, 1, 25000000),   -- Galaxy S23 Ultra
(3, 5, 1, 1000000),    -- Redmi phụ kiện

-- Đơn hàng 4: Phạm Thị D
(4, 4, 1, 10000000),   -- Galaxy A54

-- Đơn hàng 5: Hoàng Văn E
(5, 6, 1, 12000000);   -- Oppo Reno8

--Thêm thông tin vào bảng nhà cung cấp
INSERT INTO Suppliers (SupplierName, Phone, Address) VALUES
(N'Công ty TNHH Apple Việt Nam', '0281111111', N'Hồ Chí Minh'),
(N'Công ty Samsung Electronics', '0282222222', N'Hà Nội'),
(N'Công ty Xiaomi Việt Nam', '0283333333', N'Hồ Chí Minh'),
(N'Công ty Oppo Việt Nam', '0284444444', N'Hồ Chí Minh');

--CÁC CÂU TRUY VẤN TÌM THÔNG TIN
-- Liệt kê tất cả thông tin khách hàng
SELECT * 
FROM Customers;

--Tìm khách hàng có địa chỉ ở TP. Hồ Chí Minh.
SELECT *
FROM Customers
WHERE Address = N'Hồ Chí Minh';

--Tìm tất cả điện thoại của hãng Apple.
SELECT *
FROM Products
WHERE Brand = N'Apple';

--Liệt kê các điện thoại có giá > 15 triệu.
SELECT *
FROM Products
WHERE Price > 15000000;

--Tìm những điện thoại còn tồn kho ít hơn 10 chiếc.
SELECT *
FROM Products
WHERE Stock < 10;

--Tính tổng số lượng khách hàng đã đăng ký.
SELECT COUNT(*)
FROM Customers
WHERE RegisterDate IS NOT NULL;

--Tính tổng số lượng sản phẩm trong kho.
SELECT SUM(STOCK)
FROM Products;

--Liệt kê các đơn hàng trong tháng 9/2025.
SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2025-09-01' AND '2025-09-30';

--Tính tổng doanh thu từ tất cả đơn hàng.
SELECT SUM(TotalAmount) AS 'TỔNG DOANH THU'
FROM Orders;

--Tìm khách hàng mua nhiều tiền nhất.
SELECT Top 1 Customers.CustomerID, Customers.FullName, SUM(Orders.TotalAmount) AS TotalSpent
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.FullName
ORDER BY TotalSpent DESC;

--Tìm khách hàng mua nhiều đơn hàng nhất
SELECT TOP 1 Customers.CustomerID, Customers.FullName, SUM(OrderDetails.Quantity) as Total_quantity
FROM Customers, OrderDetails, Orders
WHERE Customers.CustomerID = Orders.CustomerID AND Orders.OrderID = OrderDetails.OrderID
GROUP BY Customers.CustomerID, Customers.FullName
ORDER BY Total_quantity DESC;

--Thống kê doanh thu theo từng tháng.
SELECT MONTH(OrderDate) AS THANG, SUM(TotalAmount) AS TOTAL_MONTH
FROM Orders
GROUP BY MONTH(OrderDate)
ORDER BY TOTAL_MONTH;

--Thống kê doanh thu theo từng hãng điện thoại.
SELECT Products.Brand, SUM(DISTINCT Orders.TotalAmount) AS TA_BRAND
FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.Brand
ORDER BY TA_BRAND DESC;

--Tìm sản phẩm bán chạy nhất (số lượng nhiều nhất).
SELECT Products.ProductName, Products.Brand, SUM(OrderDetails.Quantity) as Total_Quantity
FROM Products
JOIN OrderDetails ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName, Products.Brand
ORDER BY Total_Quantity;

--Tìm top 3 khách hàng chi tiêu nhiều nhất.
SELECT Top 3 Customers.CustomerID, Customers.FullName, SUM(Orders.TotalAmount) AS TotalSpent
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.FullName
ORDER BY TotalSpent DESC;

--Tính trung bình giá bán điện thoại.
SELECT CAST(AVG(Price) AS INT) AS Gia_trung_binh
FROM Products;

--Tìm đơn hàng có giá trị lớn nhất.
SELECT TOP 1 *
FROM Orders
ORDER BY TotalAmount DESC;

--Tìm tất cả điện thoại bán trong năm 2025.
SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31';

--Liệt kê danh sách điện thoại chưa từng được bán.
SELECT P.*
FROM Products P
LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
WHERE OD.ProductID IS NULL;

--Thống kê số lượng đơn hàng theo từng trạng thái (Pending, Paid, Shipped).
SELECT Status, COUNT(*) AS SO_LUONG
FROM Orders
GROUP BY Status;
