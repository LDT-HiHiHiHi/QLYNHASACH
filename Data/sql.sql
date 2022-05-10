﻿USE MASTER
GO
IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME='QL_NHASACH')
BEGIN
        DROP DATABASE QL_NHASACH
END
CREATE DATABASE QL_NHASACH
GO
USE QL_NHASACH
GO

CREATE TABLE QUYEN (
	IDQUYEN INT IDENTITY PRIMARY KEY,
	MAQUYEN NCHAR(255),
	TENQUYEN NVARCHAR(255),
	DISABLED INT DEFAULT '0',
)
CREATE TABLE LOAIQUYEN (
	IDLOAIQUYEN INT IDENTITY PRIMARY KEY,
	MALOAIQUYEN NCHAR(255),
	TENLOAIQUYEN NVARCHAR(255),
	DISABLED INT DEFAULT '0',
)
CREATE TABLE LOAIQUYENOFQUYEN (
	IDQUYEN INT,
	IDLOAIQUYEN INT,
	DISABLED INT DEFAULT '0',
	CONSTRAINT PK_LOAIQUYENOFQUYEN PRIMARY KEY(IDQUYEN,IDLOAIQUYEN),
	CONSTRAINT FK_LOAIQUYENOFQUYEN_QUYEN FOREIGN KEY (IDQUYEN) REFERENCES QUYEN(IDQUYEN),
	CONSTRAINT FK_LOAIQUYENOFQUYEN_LOAIQUYEN  FOREIGN KEY (IDLOAIQUYEN) REFERENCES LOAIQUYEN(IDLOAIQUYEN)
)

CREATE TABLE CHINHANH(
	MACN NCHAR(10) PRIMARY KEY,
	TENCN NVARCHAR(500),
	DC NVARCHAR(500),
	STK NVARCHAR(20),
	SDT NVARCHAR(10),
	MOTA NVARCHAR(500),
	DISABLED INT DEFAULT '0',
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE
)
CREATE TABLE NHANVIEN(
	MANV NVARCHAR(10) PRIMARY KEY,
	TENNV NVARCHAR(255),
	DC NVARCHAR(255),
	EMAIL NVARCHAR(255),
	SDT NVARCHAR(255),
	NGAYSINH DATE,
	DISABLED INT DEFAULT '0',
	MATKHAU NVARCHAR(255),
	MACN NCHAR(10),
	IDQUYEN INT,
	CONSTRAINT FK_CN_QUYEN FOREIGN KEY (IDQUYEN) REFERENCES QUYEN(IDQUYEN),
	CONSTRAINT FK_CN_NHANVIEN FOREIGN KEY (MACN) REFERENCES CHINHANH(MACN)
) 
ALTER TABLE NHANVIEN ADD 
NGUOITAO NVARCHAR(10)
ALTER TABLE NHANVIEN ADD  NGAYTAO DATE DEFAULT GETDATE()
ALTER TABLE NHANVIEN ADD  NGUOISUA NVARCHAR(10)
ALTER TABLE NHANVIEN ADD NGAYSUA DATE
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NV_TAO FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV)
ALTER TABLE NHANVIEN ADD   CONSTRAINT FK_NV_SUA FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
ALTER TABLE CHINHANH ADD CONSTRAINT FK_CHINHANH_KHNGT FOREIGN KEY (NGUOITAO)REFERENCES NHANVIEN(MANV)
ALTER TABLE CHINHANH ADD  CONSTRAINT FK_CHINHANH_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)

CREATE TABLE LOAIQUYENOFNHANVIEN(
	MANV NVARCHAR(10),
	IDLOAIQUYEN INT,
	DISABLED INT DEFAULT '0',
	CONSTRAINT PK_LOAIQUYENOFNHANVIEN PRIMARY KEY(MANV,IDLOAIQUYEN),
	CONSTRAINT FK_LOAIQUYENOFNHANVIEN_NHANVIEN  FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_LOAIQUYENOFNHANVIEN_LOAIQUYEN  FOREIGN KEY (IDLOAIQUYEN) REFERENCES LOAIQUYEN(IDLOAIQUYEN)
)

CREATE TABLE MATHANG (
	MAMH NCHAR(10) PRIMARY KEY,
	TENMATHANG NVARCHAR(500),
	DISABLED INT DEFAULT '0',
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	CONSTRAINT FK_MH_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_MH_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)

CREATE TABLE LOAIMATHANG (
	MALOAI NCHAR(10) PRIMARY KEY,
	TENLOAI NVARCHAR(500),
	HINHMINHHOA NVARCHAR(255),
	MAMH NCHAR (10),
	DISABLED INT DEFAULT '0',
	CONSTRAINT FK_MH_LMH FOREIGN KEY (MAMH) REFERENCES MATHANG(MAMH ),
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	CONSTRAINT FK_LOAIMATHANG_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_LOAIMATHANG_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)
CREATE TABLE CHUDE (
	MACD NCHAR(10) PRIMARY KEY,
	TENCD NVARCHAR(500),
	HINHMINHHOA NVARCHAR(255),
	MALOAI NCHAR (10),
	DISABLED INT DEFAULT '0',
	CONSTRAINT FK_CD_LMH
	  FOREIGN KEY (MALOAI )
	  REFERENCES LOAIMATHANG (MALOAI ),
	  NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	CONSTRAINT FK_CD_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_CD_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)

CREATE TABLE LOAICHUDE (
	MALOAICD NCHAR(10) PRIMARY KEY,
	TENLOAICD NVARCHAR(500),
	HINHMINHHOA NVARCHAR(255),
	MACD NCHAR (10),
	DISABLED INT DEFAULT '0',
	CONSTRAINT FK_LOAICD_CD FOREIGN KEY (MACD ) REFERENCES CHUDE (MACD ),
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	CONSTRAINT FK_LOAICD_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_LOAICD_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)

CREATE TABLE TACGIA (
	MATG NCHAR(10) PRIMARY KEY,
	TENTG NVARCHAR(500),
	NGAYSINH DATE,
	DC NVARCHAR(500),
	SDT NVARCHAR(10),
	EMAIL NVARCHAR(50),
	GT NVARCHAR(3),
	MOTA NVARCHAR(500),
	DISABLED INT DEFAULT '0',
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	CONSTRAINT FK_TG_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_TG_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)

CREATE TABLE NHACC(
	MANCC NCHAR(10) PRIMARY KEY,
	TENCC NVARCHAR(500),
	DC NVARCHAR(500),
	STK NVARCHAR(20),
	SDT NVARCHAR(10),
	MOTA NVARCHAR(500),
	DISABLED INT DEFAULT '0',
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	CONSTRAINT FK_NCC_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_NCC_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)
CREATE TABLE NHAXB(
	MANXB NCHAR(10) PRIMARY KEY,
	TENNXB NVARCHAR(500),
	DC NVARCHAR(500),
	STK NVARCHAR(20),
	SDT NVARCHAR(10),
	MOTA NVARCHAR(500),
	DISABLED INT DEFAULT '0',
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	CONSTRAINT FK_NHAXB_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_NXB_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)
CREATE TABLE SANPHAM(
	MASP NCHAR(10) PRIMARY KEY,
	TENSP NVARCHAR(500),
	NGAYDANG DATE,
	GIABAN INT,
	GIANHAP INT,
	MANCC NCHAR(10),
	MANXB NCHAR(10),
	XUATXU NVARCHAR(500),
	THUONGHIEU NVARCHAR(500),
	NGONNGU NVARCHAR(500),
	KICHTHUOC NVARCHAR(500),
	SOTRANG NVARCHAR(500),
	MOTA NVARCHAR(500),
	DOTUOI NVARCHAR(500),
	HSD DATE,
	SLTON INT,
	TRONGLUONG INT,
	DISABLED INT DEFAULT '0'
	CONSTRAINT FK_MANCC_SP FOREIGN KEY (MANCC ) REFERENCES NHACC (MANCC),
	CONSTRAINT FK_MANXB_SP FOREIGN KEY (MANXB) REFERENCES NHAXB (MANXB),
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	CONSTRAINT FK_SP_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_SP_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
  )
    
CREATE TABLE SACHTG(
	MASP NCHAR(10),
	MATG NCHAR(10),
	CONSTRAINT PK_SACHTG PRIMARY KEY(MASP,MATG),
	CONSTRAINT FK_SACHTG_SP FOREIGN KEY (MASP) REFERENCES SANPHAM (MASP),
	CONSTRAINT FK_SACHTG_TG FOREIGN KEY (MATG) REFERENCES TACGIA (MATG),
	DISABLED INT DEFAULT '0',
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	CONSTRAINT FK_SCAHTG_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_SACHTG_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)

CREATE TABLE SANPHAMHINHANH(
	MAHINH INT IDENTITY PRIMARY KEY,
	MASP NCHAR(10),
	HINH NVARCHAR(255),
	CONSTRAINT FK_SANPHAMHINHANH_SP FOREIGN KEY (MASP) REFERENCES SANPHAM (MASP),
	DISABLED INT DEFAULT '0',
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	CONSTRAINT FK_SPHINH_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_SPHINH_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)
CREATE TABLE SANPHAMLOAICHUDE(
	MASP NCHAR(10),
	MALOAICD NCHAR(10),
	DISABLED INT DEFAULT '0',
	CONSTRAINT PK_SANPHAMLOAICHUDE PRIMARY KEY(MASP,MALOAICD),
	CONSTRAINT FK_SANPHAMLOAICHUDE_SP FOREIGN KEY (MASP) REFERENCES SANPHAM (MASP),
	CONSTRAINT FK_SANPHAMLOAICHUDE_LOAICD FOREIGN KEY (MALOAICD) REFERENCES LOAICHUDE (MALOAICD),
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	CONSTRAINT FK_SPCD_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_SPCD_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)
CREATE TABLE SANPHAMCN(
	MASP NCHAR(10),
	MACN NCHAR(10),
	CONSTRAINT PK_SANPHAMCN PRIMARY KEY(MASP,MACN),
	CONSTRAINT FK_SANPHAMCN_SP FOREIGN KEY (MASP) REFERENCES SANPHAM (MASP),
	CONSTRAINT FK_CN_SP FOREIGN KEY (MACN) REFERENCES CHINHANH (MACN),
	DISABLED INT DEFAULT '0',
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	SLTON INT DEFAULT '0',
	CONSTRAINT FK_SANPHAMCN_KHNGT FOREIGN KEY (NGUOITAO)REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_SANPHAMCN_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)
CREATE TABLE KHACHHANG(
	MAKH INT IDENTITY PRIMARY KEY,
	HOKH NVARCHAR(255),
	TENKH NVARCHAR(255),
	DC NVARCHAR(255),
	EMAIL NVARCHAR(255),
	SDT NVARCHAR(10),
	DISABLED INT DEFAULT '0',
	MATKHAU NVARCHAR(255)
)

CREATE TABLE DANHGIA(
	MADG INT IDENTITY PRIMARY KEY,
	MASP NCHAR(10),
	MAKH INT,
	NGAYDANHGIA DATE,
	DIEMDANHGIA INT,
	CONSTRAINT FK_DANHGIA_SP FOREIGN KEY (MASP) REFERENCES SANPHAM (MASP),
	CONSTRAINT FK_DANHGIA_KH FOREIGN KEY (MAKH) REFERENCES KHACHHANG (MAKH)
)
CREATE TABLE KHUYENMAI(
	MAKHM NCHAR(10) PRIMARY KEY,
	GIATIEN INT,
	NGAYBD DATE,
	NGAYKET DATE,
	DIEUKIEN INT,
	HINHTHUCKM INT,
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	DISABLED INT DEFAULT '0',
	CONSTRAINT FK_KM_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_KM_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)
CREATE TABLE DONHANG(
	MADH INT IDENTITY PRIMARY KEY,
	NGAYLAP DATE DEFAULT GETDATE(),
	TONGTIEN INT DEFAULT 0,
	DCGIAO NVARCHAR(255),
	SDT NVARCHAR(255),
	QUOCGIA NVARCHAR(255),
	THANHPHO NVARCHAR(255),
	QUANHUYEN NVARCHAR(255),
	PHUONGXA NVARCHAR(255),
	EMAIL NVARCHAR(255),
	HINHTHUC INT,
	TRANGTHAI INT DEFAULT 0,
	MAKH INT DEFAULT NULL,
	MAKHM NCHAR(10) NULL,
	MACN NCHAR(10) NULL,
	HOTEN NVARCHAR(255),
	DIACHI NVARCHAR(255),
	CONSTRAINT FK_DONHANG_KH FOREIGN KEY (MAKH) REFERENCES KHACHHANG (MAKH),
	CONSTRAINT FK_DONHANG_CN FOREIGN KEY (MACN) REFERENCES CHINHANH (MACN),
	CONSTRAINT FK_DONHANG_KM FOREIGN KEY (MAKHM) REFERENCES KHUYENMAI (MAKHM)
)
ALTER TABLE DONHANG
ADD TIENGIAM INT  DEFAULT 0

CREATE TABLE DONHANGCT(
	MADH INT,
	MASP NCHAR(10),
	SL INT,
	THANHTIEN INT DEFAULT 0,
	CONSTRAINT PK_DONHANGCT PRIMARY KEY(MADH,MASP),
	CONSTRAINT FK_DONGHANGCT_DONHANG FOREIGN KEY (MADH) REFERENCES DONHANG (MADH),
	CONSTRAINT FK_DONHANGCT_SP FOREIGN KEY (MASP) REFERENCES SANPHAM (MASP)
)
CREATE TABLE QUANGCAO(
	MA INT IDENTITY PRIMARY KEY,
	HINH NVARCHAR(255),
	DISABLED INT DEFAULT '0',
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	CONSTRAINT FK_QUANGCAO_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_QUANGCAO_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)
CREATE TABLE NHACCNHAP(
	MANCC NCHAR(10) PRIMARY KEY,
	TENCC NVARCHAR(500),
	DC NVARCHAR(500),
	STK NVARCHAR(20),
	SDT NVARCHAR(10),
	MOTA NVARCHAR(500),
	KYHIEUHD NVARCHAR(500),
	KYHIEUMAUDH NVARCHAR(500),
	DISABLED INT DEFAULT '0',
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	NGAYSUA DATE,
	CONSTRAINT FK_NCCNHAP_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_NCCNHAP_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV)
)
CREATE TABLE PHIEUNHAP(
	MAPHIEU INT IDENTITY PRIMARY KEY,
	SOHD NCHAR(10),
	KYHIEUHD NVARCHAR(500),
	KYHIEUMAUDH NVARCHAR(500),
	NGAYNHAP DATE,
	NGAYHD DATE,
	NGAYNHANHD DATE,
	MACN NCHAR(10),
	TONG FLOAT,
	VAT FLOAT,
	TIENVAT FLOAT,
	THANHTIENVAT FLOAT,
	GHICHU NVARCHAR(500),
	NGUOITAO NVARCHAR(10),
	NGAYTAO DATE DEFAULT GETDATE(),
	NGUOISUA NVARCHAR(10),
	TRANGTHAI INT DEFAULT 0,
	NGAYSUA DATE,
	MANCC NCHAR(10),
	CONSTRAINT FK_PN_KHNGT FOREIGN KEY (NGUOITAO) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_PN_KHNGS FOREIGN KEY (NGUOISUA) REFERENCES NHANVIEN(MANV),
	CONSTRAINT FK_CN_PHIEUNHAP FOREIGN KEY (MACN) REFERENCES CHINHANH(MACN),
	CONSTRAINT FK_CN_PHIEUNHAPNCC FOREIGN KEY (MANCC) REFERENCES NHACCNHAP(MANCC)
)
CREATE TABLE PHIEUNHAPCT(
	MAPHIEU INT,
	MASP NCHAR(10),
	SL INT,
	THANHTIEN FLOAT,
	THANHTIENVAT FLOAT,
	DONGIA FLOAT,
	DONGIAVAT FLOAT,
	DISABLED INT DEFAULT '0',
	CONSTRAINT PK_PHIEUNHAPCT PRIMARY KEY(MAPHIEU,MASP),
	CONSTRAINT FK_PNCT_KHNGT FOREIGN KEY (MAPHIEU) REFERENCES PHIEUNHAP(MAPHIEU),
	CONSTRAINT FK_PNCT_KHNGS FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP)
)
--ADD ADMIN
INSERT INTO NHANVIEN(MANV,TENNV,MATKHAU) VALUES ('ADMIN','ADMIN','123')
--ADD MẶT HÀNG
INSERT INTO MATHANG(MAMH,TENMATHANG,NGUOITAO) VALUES ('MH001',N'SACH','ADMIN')
INSERT INTO MATHANG(MAMH,TENMATHANG,NGUOITAO) VALUES ('MH002',N'ĐỒ CHƠI','ADMIN')
INSERT INTO MATHANG(MAMH,TENMATHANG,NGUOITAO) VALUES ('MH003',N'DỤNG CỤ','ADMIN')
--
INSERT INTO LOAIMATHANG(MALOAI,TENLOAI,MAMH,NGUOITAO) VALUES ('LMH001',N'SÁCH TRONG NƯỚC','MH001','ADMIN')
INSERT INTO LOAIMATHANG(MALOAI,TENLOAI,MAMH,NGUOITAO) VALUES ('LMH002',N'FOREIGN BOOKS','MH001','ADMIN')
INSERT INTO LOAIMATHANG(MALOAI,TENLOAI,MAMH,NGUOITAO) VALUES ('LMH003',N'ĐỒ CHƠI','MH002','ADMIN')
INSERT INTO LOAIMATHANG(MALOAI,TENLOAI,MAMH,NGUOITAO) VALUES ('LMH004',N'VPP-DỤNG CỤ HỌC SINH','MH003','ADMIN')

--
INSERT INTO CHUDE(MACD,TENCD,MALOAI,NGUOITAO) VALUES ('CDH001',N'VĂN HỌC','LMH001','ADMIN')
INSERT INTO CHUDE(MACD,TENCD,MALOAI,NGUOITAO) VALUES ('CDH002',N'KINH TẾ','LMH001','ADMIN')
INSERT INTO CHUDE(MACD,TENCD,MALOAI,NGUOITAO) VALUES ('CDH003',N'TÂM LÝ - KỸ NĂNG SỐNG','LMH001','ADMIN')
INSERT INTO CHUDE(MACD,TENCD,MALOAI,NGUOITAO) VALUES ('CDH004',N'NUÔI DẬY CON','LMH001','ADMIN')
INSERT INTO CHUDE(MACD,TENCD,MALOAI,NGUOITAO) VALUES ('CDH005',N'SÁCH THIẾU NHI','LMH001','ADMIN')
INSERT INTO CHUDE(MACD,TENCD,MALOAI,NGUOITAO) VALUES ('CDH006',N'TIỂU SỬ - HỒI KÝ','LMH001','ADMIN')
INSERT INTO CHUDE(MACD,TENCD,MALOAI,NGUOITAO) VALUES ('CDH007',N'GIÁO KHOA - KHAM KHẢO','LMH001','ADMIN')
INSERT INTO CHUDE(MACD,TENCD,MALOAI,NGUOITAO) VALUES ('CDH008',N'SÁCH HỌC NGOẠI NGỮ','LMH001','ADMIN')
INSERT INTO CHUDE(MACD,TENCD,MALOAI,NGUOITAO) VALUES ('CDH009',N'BÚT - VIẾT','LMH004','ADMIN')
INSERT INTO CHUDE(MACD,TENCD,MALOAI,NGUOITAO) VALUES ('CDH010',N'DỤNG CỤ HỌC SINH','LMH004','ADMIN')
--
INSERT INTO LOAICHUDE(MALOAICD,TENLOAICD,MACD,NGUOITAO) VALUES ('LCDH001',N'TIỂU THUYẾT','CDH001','ADMIN')
INSERT INTO LOAICHUDE(MALOAICD,TENLOAICD,MACD,NGUOITAO) VALUES ('LCDH002',N'TRUYÊN NGẮN -  TÀN VĂN','CDH001','ADMIN')
INSERT INTO LOAICHUDE(MALOAICD,TENLOAICD,MACD,NGUOITAO) VALUES ('LCDH003',N'NGÔN TÌNH','CDH001','ADMIN')
INSERT INTO LOAICHUDE(MALOAICD,TENLOAICD,MACD,NGUOITAO) VALUES ('LCDH004',N'SÁCH GIÁO KHOA','CDH007','ADMIN')
INSERT INTO LOAICHUDE(MALOAICD,TENLOAICD,MACD,NGUOITAO) VALUES ('LCDH005',N'SÁCH THAM KHẢO','CDH007','ADMIN')
INSERT INTO LOAICHUDE(MALOAICD,TENLOAICD,MACD,NGUOITAO) VALUES ('LCDH006',N'BÚT BI - RUỘT BÚT BI','CDH009','ADMIN')
INSERT INTO LOAICHUDE(MALOAICD,TENLOAICD,MACD,NGUOITAO) VALUES ('LCDH007',N'GÔM - TẨY','CDH010','ADMIN')
--
INSERT INTO QUANGCAO(HINH,NGUOITAO) VALUES ('D-DAY2_840X320_EDIT_MOI.JPG','ADMIN')
INSERT INTO QUANGCAO(HINH,NGUOITAO) VALUES ('HOISACHONLINE_T322_MAINBANNER__840X320_MOI.JPG','ADMIN')
INSERT INTO QUANGCAO(HINH,NGUOITAO) VALUES ('840X320_-_DISNEY-100.JPG','ADMIN')
INSERT INTO QUANGCAO(HINH,NGUOITAO) VALUES ('840X320_-_ALPHABOOKS_.JPG','ADMIN')
INSERT INTO QUANGCAO(HINH,NGUOITAO) VALUES ('840X320_DONG_A_EDIT_MOI.JPG','ADMIN')
INSERT INTO QUANGCAO(HINH,NGUOITAO) VALUES ('840X320_-_SHOPEEPAY_T3-100.JPG','ADMIN')
--
INSERT INTO NHACC(MANCC,TENCC) VALUES ('NC001',N'CTY PHƯƠNG NAM')
--
INSERT INTO NHAXB(MANXB,TENNXB) VALUES ('NXB01',N'NXB GIÁO DỤC VIỆT NAM')
--
INSERT INTO TACGIA (MATG,TENTG,NGUOITAO) VALUES ('TG001',N'BỘ GIÁO DỤC VÀ ĐÀO TẠO','ADMIN')
INSERT INTO TACGIA (MATG,TENTG,NGUOITAO) VALUES ('TG002',N'NAM CAO','ADMIN')
INSERT INTO TACGIA (MATG,TENTG,NGUOITAO) VALUES ('TG003',N'TÔ HOÀI','ADMIN')
--
INSERT INTO SANPHAM(MASP,TENSP,GIABAN,GIANHAP,MANCC,MANXB,KICHTHUOC,SOTRANG,NGUOITAO) VALUES ('SP001',N'TIẾNG ANH 3 - TẬP 2 - SÁCH HỌC SINH (2021)',35000,34000,'NC001','NXB01','26.5 X 19 X 0.4 CM','79','ADMIN')
INSERT INTO SACHTG(MASP,MATG,NGUOITAO) VALUES ('SP001','TG001','ADMIN')
INSERT INTO SANPHAMHINHANH(MASP,HINH) VALUES ('SP001','IMAGE_241202.JPG')
INSERT INTO SANPHAMHINHANH(MASP,HINH) VALUES ('SP001','2021_06_03_14_12_35_2-390X510.JPG')
INSERT INTO SANPHAMLOAICHUDE(MASP,MALOAICD) VALUES ('SP001','LCDH004')
INSERT INTO SANPHAMLOAICHUDE(MASP,MALOAICD) VALUES ('SP001','LCDH005')

--
INSERT INTO SANPHAM(MASP,TENSP,GIABAN,GIANHAP,MANCC,MANXB,KICHTHUOC,SOTRANG,NGUOITAO) VALUES ('SP002',N'TIẾNG ANH 3 - TẬP 2 - SÁCH HỌC SINH (2021)',35000,34000,'NC001','NXB01','26.5 X 19 X 0.4 CM','79','ADMIN')
INSERT INTO SACHTG(MASP,MATG,NGUOITAO) VALUES ('SP002','TG001','ADMIN')
INSERT INTO SANPHAMHINHANH(MASP,HINH) VALUES ('SP002','IMAGE_241202.JPG')
INSERT INTO SANPHAMLOAICHUDE(MASP,MALOAICD) VALUES ('SP002','LCDH004')

INSERT INTO SANPHAM(MASP,TENSP,GIABAN,GIANHAP,MANCC,MANXB,KICHTHUOC,SOTRANG,NGUOITAO) VALUES ('SP003',N'TIẾNG ANH 3 - TẬP 2 - SÁCH HỌC SINH (2021)',35000,34000,'NC001','NXB01','26.5 X 19 X 0.4 CM','79','ADMIN')
INSERT INTO SACHTG(MASP,MATG,NGUOITAO) VALUES ('SP003','TG001','ADMIN')
INSERT INTO SANPHAMHINHANH(MASP,HINH) VALUES ('SP003','IMAGE_241202.JPG')
INSERT INTO SANPHAMLOAICHUDE(MASP,MALOAICD) VALUES ('SP003','LCDH004')
INSERT INTO SANPHAMLOAICHUDE(MASP,MALOAICD) VALUES ('SP003','LCDH005')

INSERT INTO SANPHAM(MASP,TENSP,GIABAN,GIANHAP,MANCC,MANXB,KICHTHUOC,SOTRANG,NGUOITAO) VALUES ('SP004',N'TIẾNG ANH 3 - TẬP 2 - SÁCH HỌC SINH (2021)',35000,34000,'NC001','NXB01','26.5 X 19 X 0.4 CM','79','ADMIN')
INSERT INTO SACHTG(MASP,MATG,NGUOITAO) VALUES ('SP004','TG001','ADMIN')
INSERT INTO SANPHAMHINHANH(MASP,HINH) VALUES ('SP004','IMAGE_241202.JPG')
INSERT INTO SANPHAMLOAICHUDE(MASP,MALOAICD) VALUES ('SP004','LCDH004')

INSERT INTO SANPHAM(MASP,TENSP,GIABAN,GIANHAP,MANCC,MANXB,KICHTHUOC,SOTRANG,NGUOITAO) VALUES ('SP005',N'TIẾNG ANH 3 - TẬP 2 - SÁCH HỌC SINH (2021)',35000,34000,'NC001','NXB01','26.5 X 19 X 0.4 CM','79','ADMIN')
INSERT INTO SACHTG(MASP,MATG,NGUOITAO) VALUES ('SP005','TG001','ADMIN')
INSERT INTO SANPHAMHINHANH(MASP,HINH) VALUES ('SP005','IMAGE_241202.JPG')
INSERT INTO SANPHAMLOAICHUDE(MASP,MALOAICD) VALUES ('SP005','LCDH004')


INSERT INTO SANPHAM(MASP,TENSP,GIABAN,GIANHAP,MANCC,MANXB,KICHTHUOC,SOTRANG,NGUOITAO) VALUES ('SP006',N'TIẾNG ANH 3 - TẬP 2 - SÁCH HỌC SINH (2021)',35000,34000,'NC001','NXB01','26.5 X 19 X 0.4 CM','79','ADMIN')
INSERT INTO SACHTG(MASP,MATG,NGUOITAO) VALUES ('SP006','TG001','ADMIN')
INSERT INTO SANPHAMHINHANH(MASP,HINH) VALUES ('SP006','IMAGE_241202.JPG')
INSERT INTO SANPHAMLOAICHUDE(MASP,MALOAICD) VALUES ('SP006','LCDH004')
SELECT * FROM CHUDE WHERE DISABLED=0 AND MALOAI='LMH001'

SELECT * FROM LOAICHUDE WHERE DISABLED=0 AND MACD='CDH001'

SELECT * FROM QUANGCAO WHERE DISABLED=0

SELECT * FROM KHACHHANG

SELECT * FROM NHACC

SELECT * FROM SANPHAMHINHANH SELECT TOP 4 SANPHAM.MASP,TENSP,GIABAN  FROM SANPHAM,DONHANGCT WHERE SANPHAM.MASP=DONHANGCT.MASP AND DISABLED=0  
GROUP BY SANPHAM.MASP,TENSP,GIABAN 
HAVING SUM(DONHANGCT.SL)>=10
ORDER BY SANPHAM.MASP,TENSP,GIABAN


SELECT DISTINCT  SANPHAM.MASP,SANPHAM.TENSP,GIABAN FROM SANPHAM INNER JOIN SACHTG ON (SACHTG.MASP=SANPHAM.MASP)  INNER JOIN TACGIA ON (SACHTG.MATG=SACHTG.MATG)  WHERE (TENSP LIKE N'%%' OR SANPHAM.MASP LIKE N'%%' OR TENTG LIKE N'%%')  AND SANPHAM.DISABLED=0 UNION  ALL  SELECT DISTINCT  SANPHAM.MASP,SANPHAM.TENSP,GIABAN FROM SANPHAM LEFT JOIN SACHTG ON (SACHTG.MASP=SANPHAM.MASP) WHERE (TENSP LIKE N'%%' OR SANPHAM.MASP LIKE N'%%') AND SANPHAM.DISABLED=0

UPDATE DONHANG SET TONGTIEN+=(SELECT THANHTIEN FROM DONHANGCT WHERE MASP='SP002' AND MADH=1003) WHERE MADH=1003

INSERT INTO SANPHAM(MASP,TENSP,MOTA,GIABAN,GIANHAP,KICHTHUOC,SOTRANG,DOTUOI,TRONGLUONG,MANCC,MANXB,NGONNGU,XUATXU) VALUES(N'123',N'321','123','321',N'312','321','321',N'321','312','NC001   ','NXB01     ',N'ANH',N'ANH')

SELECT LOAICHUDE.* FROM LOAICHUDE INNER JOIN CHUDE ON (LOAICHUDE.MACD=CHUDE.MACD) INNER JOIN LOAIMATHANG ON (LOAIMATHANG.MALOAI=CHUDE.MALOAI)  INNER JOIN MATHANG ON (LOAIMATHANG.MAMH=MATHANG.MAMH) WHERE LOAICHUDE.DISABLED=0 AND MATHANG.MAMH= 'MH001'
SELECT DISTINCT SANPHAM.MASP,SANPHAM.TENSP,GIABAN,CHUDE.MACD FROM SANPHAM INNER JOIN SANPHAMLOAICHUDE ON (SANPHAM.MASP=SANPHAMLOAICHUDE.MASP) 
INNER JOIN LOAICHUDE ON (LOAICHUDE.MALOAICD=SANPHAMLOAICHUDE.MALOAICD) 
INNER JOIN CHUDE ON (CHUDE.MACD=LOAICHUDE.MACD)
INNER JOIN LOAIMATHANG ON (LOAIMATHANG.MALOAI=CHUDE.MALOAI) WHERE LOAIMATHANG.MAMH = 'MH001'


SELECT * FROM SANPHAMHINHANH WHERE DISABLED=0  AND MASP='3  '
UPDATE PHIEUNHAP SET TRANGTHAI = 0
SELECT * FROM SANPHAMHINHANH WHERE MASP='SP005'

SELECT * FROM MATHANG WHERE DISABLED=0

SELECT COUNT(*) FROM LOAIMATHANG WHERE LOAIMATHANG.MALOAI='LMH004'

SELECT * FROM LOAICHUDE WHERE MACD='CDH001'

SELECT * FROM SANPHAMCN
SELECT * FROM LOAIQUYEN
INSERT INTO SANPHAMCN(MACN,MASP,NGAYTAO) VALUES(N'MACN01','SP001',N'ADMIN')

UPDATE PHIEUNHAP SET TRANGTHAI= 0 WHERE MAPHIEU=1

UPDATE QUYEN SET MAQUYEN= 'ADMINISTRATOR',TENQUYEN =N'ADMIN' WHERE IDQUYEN=1

UPDATE SANPHAMCN SET SLTON= SLTON + 3 WHERE MASP='SP003     ' AND MACN= '1'

UPDATE LOAIQUYENOFNHANVIEN
SET LOAIQUYENOFNHANVIEN.DISABLED = 1
FROM NHANVIEN WHERE IDQUYEN='1' AND LOAIQUYENOFNHANVIEN.IDLOAIQUYEN ='4'

SELECT LOAIQUYEN.IDLOAIQUYEN,MALOAIQUYEN,TENLOAIQUYEN FROM LOAIQUYENOFNHANVIEN,NHANVIEN,LOAIQUYEN WHERE LOAIQUYENOFNHANVIEN.MANV =  NHANVIEN.MANV AND LOAIQUYEN.IDLOAIQUYEN = LOAIQUYENOFNHANVIEN.IDLOAIQUYEN AND NHANVIEN.IDQUYEN = '1' AND LOAIQUYEN.IDLOAIQUYEN IN (SELECT IDLOAIQUYEN FROM LOAIQUYENOFQUYEN WHERE IDQUYEN='1' AND DISABLED = 0)