-- Sử dụng CSDL Quản lý bán hàng
CREATE DATABASE IF NOT EXISTS QuanLyBanHang;
USE QuanLyBanHang;

-- ========================================================
-- 1. THÊM DỮ LIỆU VÀO CÁC BẢNG
-- ========================================================

-- Thêm dữ liệu bảng Customer
INSERT INTO Customer (cID, Name, cAge) VALUES 
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

-- Thêm dữ liệu bảng Order (Định dạng ngày chuẩn YYYY-MM-DD)
INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES 
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

-- Thêm dữ liệu bảng Product
INSERT INTO Product (pID, pName, pPrice) VALUES 
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

-- Thêm dữ liệu bảng OrderDetail
INSERT INTO OrderDetail (oID, pID, odQTY) VALUES 
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- ========================================================
-- 2. THỰC THI CÁC CÂU LỆNH TRUY VẤN
-- ========================================================

-- Yêu cầu 1: Hiển thị các thông tin gồm oID, oDate, oTotalPrice của tất cả hóa đơn
SELECT oID, oDate, oTotalPrice 
FROM `Order`;

-- Yêu cầu 2: Hiển thị danh sách khách hàng đã mua hàng và danh sách sản phẩm được mua
SELECT 
    c.Name AS CustomerName, 
    p.pName AS ProductName
FROM Customer c
JOIN `Order` o ON c.cID = o.cID
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID;

-- Yêu cầu 3: Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào (Kỹ thuật Anti-Join)
SELECT c.Name
FROM Customer c
LEFT JOIN `Order` o ON c.cID = o.cID
WHERE o.oID IS NULL;

-- Yêu cầu 4: Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn
SELECT 
    o.oID, 
    o.oDate, 
    SUM(od.odQTY * p.pPrice) AS TotalPrice
FROM `Order` o
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID
GROUP BY o.oID, o.oDate;
