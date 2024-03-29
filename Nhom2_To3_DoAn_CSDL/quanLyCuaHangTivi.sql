﻿CREATE DATABASE quanLyCuaHangTivi


go

use quanLyCuaHangTivi

go

--Tạo bảng người quản lý:
CREATE TABLE MANAGER (
  MA_ITEM INT NOT NULL,
  MA_NAME NVARCHAR(45) NOT NULL,
  MA_SALARY INT NOT NULL,
  MA_ADDRESS NVARCHAR(45) NOT NULL,
  PRIMARY KEY (MA_ITEM))

 -- Tạo bảng loại tivi:
CREATE TABLE KIND_OF_TIVI (
  KT_ITEM INT NOT NULL,
  KT_NAME NVARCHAR(45) NOT NULL,
  PRIMARY KEY (KT_ITEM))

--Tạo bảng kệ trưng bày tivi:
CREATE TABLE TIVISHELF (
  TS_ITEM INT NOT NULL,
  TS_NAME NVARCHAR(45) NOT NULL,
  TS_ADDRESS NVARCHAR(45) NOT NULL,
  MANAGER_MA_ITEM INT NOT NULL,
  KIND_OF_TIVI_KT_ITEM INT NOT NULL,
  PRIMARY KEY (TS_ITEM),
  INDEX fk_TIVISHELF_MANAGER1_idx (MANAGER_MA_ITEM ASC),
  INDEX fk_TIVISHELF_KIND_OF_TIVI1_idx (KIND_OF_TIVI_KT_ITEM ASC),
  CONSTRAINT fk_TIVISHELF_MANAGER1
    FOREIGN KEY (MANAGER_MA_ITEM)
    REFERENCES MANAGER(MA_ITEM)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_TIVISHELF_KIND_OF_TIVI1
    FOREIGN KEY (KIND_OF_TIVI_KT_ITEM)
    REFERENCES KIND_OF_TIVI (KT_ITEM)
    ON DELETE CASCADE
    ON UPDATE CASCADE)


--Tạo bảng nhân viên
CREATE TABLE EMPLOYEE (
  EMP_ITEM INT NOT NULL,
  EMP_NAME NVARCHAR(45) NOT NULL,
  EMP_SALARY INT NOT NULL,
  EMP_ADDRESS NVARCHAR(45) NOT NULL,
  TIVISHELF_TS_ITEM INT NOT NULL,
  MANAGER_MA_ITEM INT NOT NULL,
  PRIMARY KEY (EMP_ITEM),
  INDEX fk_EMPLOYEE_TIVISHELF_idx (TIVISHELF_TS_ITEM ASC),
  INDEX fk_EMPLOYEE_MANAGER1_idx (MANAGER_MA_ITEM ASC),
  CONSTRAINT fk_EMPLOYEE_TIVISHELF
    FOREIGN KEY (TIVISHELF_TS_ITEM)
    REFERENCES TIVISHELF(TS_ITEM)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_EMPLOYEE_MANAGER1
    FOREIGN KEY (MANAGER_MA_ITEM)
    REFERENCES MANAGER(MA_ITEM)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


--Tạo bảng khách hàng:
CREATE TABLE CUSTOMER (
  C_ITEM INT NOT NULL,
  C_NAME NVARCHAR(45) NOT NULL,
  C_ADDRESS VARCHAR(45) NOT NULL,
  PRIMARY KEY (C_ITEM))

--Tạo bảng nhà sản xuất
CREATE TABLE MANUFACTURER (
  MAN_ITEM INT NOT NULL,
  MAN_NAME NVARCHAR(40) NOT NULL,
  MAN_ADDRESS VARCHAR(45) NOT NULL,
  PRIMARY KEY (MAN_ITEM))

--Tạo bảng hóa đơn nhập vào
CREATE TABLE INVOICES_IN (
  IN_ITEM INT NOT NULL,
  IN_DATE DATETIME NOT NULL,
  EMPLOYEE_EMP_ITEM INT NOT NULL,
  MANUFACTURER_MAN_ITEM INT NOT NULL,
  PRIMARY KEY (IN_ITEM),
  INDEX fk_INVOICES_IN_EMPLOYEE1_idx (EMPLOYEE_EMP_ITEM ASC),
  INDEX fk_INVOICES_IN_MANUFACTURER1_idx (MANUFACTURER_MAN_ITEM ASC),
  CONSTRAINT fk_INVOICES_IN_EMPLOYEE1
    FOREIGN KEY (EMPLOYEE_EMP_ITEM)
    REFERENCES EMPLOYEE(EMP_ITEM)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_INVOICES_IN_MANUFACTURER1
    FOREIGN KEY (MANUFACTURER_MAN_ITEM)
    REFERENCES MANUFACTURER (MAN_ITEM)
    ON DELETE CASCADE
    ON UPDATE CASCADE)


--Tạo bảng hóa đơn xuất cho khách hàng
CREATE TABLE INVOICES_OUT (
  OUT_ITEM INT NOT NULL,
  OUT_DATE DATETIME NOT NULL,
  EMPLOYEE_EMP_ITEM INT NOT NULL,
  CUSTOMER_C_ITEM INT NOT NULL,
  PRIMARY KEY (OUT_ITEM),
  INDEX fk_INVOICES_OUT_EMPLOYEE1_idx (EMPLOYEE_EMP_ITEM ASC),
  INDEX fk_INVOICES_OUT_CUSTOMER1_idx (CUSTOMER_C_ITEM ASC),
  CONSTRAINT fk_INVOICES_OUT_EMPLOYEE1
    FOREIGN KEY (EMPLOYEE_EMP_ITEM)
    REFERENCES EMPLOYEE (EMP_ITEM)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_INVOICES_OUT_CUSTOMER1
    FOREIGN KEY (CUSTOMER_C_ITEM)
    REFERENCES CUSTOMER(C_ITEM)
    ON DELETE CASCADE
    ON UPDATE CASCADE)

--Tạo bảng tivi:
CREATE TABLE TIVI (
  T_ITEM INT NOT NULL,
  T_NAME NVARCHAR(45) NOT NULL,
  T_AUTHORS NVARCHAR(45) NOT NULL,
  T_COST INT NOT NULL,
  T_SIZE INT NOT NULL,
  T_DATE DATETIME NOT NULL,
  T_NUMBER INT NOT NULL,
  KIND_OF_TIVI_KT_ITEM INT NOT NULL,
  PRIMARY KEY (T_ITEM),
  --INDEX fk_BO TIVI OK_KIND_OF_TIVI1_idx (KIND_OF_TIVI_KT_ITEM ASC),
  CONSTRAINT fk_BOOK_KIND_OF_TIVI1
    FOREIGN KEY (KIND_OF_TIVI_KT_ITEM)
    REFERENCES  KIND_OF_TIVI (KT_ITEM)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

--Bảng thể hiện mối quan hệ  n-m giữa nhà xuất bản(MANUFACTURER) với tivi (TIVI)
CREATE TABLE MANUFACTURER_has_TIVI (
  MANUFACTURER_MAN_ITEM INT NOT NULL,
  TIVI_T_ITEM INT NOT NULL,
  PRIMARY KEY (MANUFACTURER_MAN_ITEM, TIVI_T_ITEM),
  INDEX fk_MANUFACTURER_has_TIVI_TIVI1_idx (TIVI_T_ITEM ASC),
  INDEX fk_MANUFACTURER_has_TIVI_MANUFACTURER_idx (MANUFACTURER_MAN_ITEM ASC),
  CONSTRAINT fk_MANUFACTURER_has_TIVI_MANUFACTURER1
    FOREIGN KEY (MANUFACTURER_MAN_ITEM)
    REFERENCES MANUFACTURER(MAN_ITEM)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_MANUFACTURER_has_TIVI_TIVI1
    FOREIGN KEY (TIVI_T_ITEM)
    REFERENCES TIVI(T_ITEM)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

--Bảng thể hiện mối quan hệ nhiều nhiều giữa hóa đơn nhập với tivi
CREATE TABLE INVOICES_IN_INCLUDE(
  INVOICES_IN_IN_ITEM INT NOT NULL,
  TIVI_T_ITEM INT NOT NULL,
  IN_NUMBER INT NOT NULL,
  INDEX fk_INVOICES_IN_has_TIVI_TIVI2_idx (TIVI_T_ITEM ASC),
  INDEX fk_INVOICES_IN_has_TIVI_INVOICES_IN2_idx (INVOICES_IN_IN_ITEM ASC),
  PRIMARY KEY (TIVI_T_ITEM, INVOICES_IN_IN_ITEM),
  CONSTRAINT fk_INVOICES_IN_has_TIVI_INVOICES_IN2
    FOREIGN KEY (INVOICES_IN_IN_ITEM)
    REFERENCES INVOICES_IN (IN_ITEM)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_INVOICES_IN_has_TIVI_TIVI2
    FOREIGN KEY (TIVI_T_ITEM)
    REFERENCES TIVI(T_ITEM)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

--Bảng thể hiện mối quan hệ nhiều nhiều giữa hóa đơn nhập với tivi
CREATE TABLE INVOICES_OUT_INCLUDE(
  INVOICES_OUT_OUT_ITEM INT NOT NULL,
  TIVI_T_ITEM INT NOT NULL,
  OUT_NUMBER INT NOT NULL,
  INDEX fk_INVOICES_OUT_has_TIVI_TIVI1_idx (TIVI_T_ITEM ASC),
  INDEX fk_INVOICES_OUT_has_TIVI_INVOICES_OUT1_idx (INVOICES_OUT_OUT_ITEM ASC),
  PRIMARY KEY (INVOICES_OUT_OUT_ITEM, TIVI_T_ITEM),
  CONSTRAINT fk_INVOICES_OUT_has_TIVI_INVOICES_OUT1
    FOREIGN KEY (INVOICES_OUT_OUT_ITEM)
    REFERENCES INVOICES_OUT (OUT_ITEM)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_INVOICES_OUT_has_TIVI_TIVI1
    FOREIGN KEY (TIVI_T_ITEM)
    REFERENCES TIVI(T_ITEM)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

--nhập dữ liệu

--truy vấn cơ bản
