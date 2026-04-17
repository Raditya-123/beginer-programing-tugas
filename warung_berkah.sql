-- 1. Membuat Database
CREATE DATABASE DB_WarungBerkah;
GO
USE DB_WarungBerkah;
GO

-- 2. Tabel Distributor
CREATE TABLE Distributor (
    ID_Distributor VARCHAR(10) PRIMARY KEY,
    Nama_Supplier VARCHAR(100) NOT NULL,
    Tahun_Mulai_Kontrak INT,
    Alamat_Gudang VARCHAR(255),
    Nomor_Kontak VARCHAR(20)
);

-- 3. Tabel Faktur
CREATE TABLE Faktur (
    No_Faktur VARCHAR(10) PRIMARY KEY,
    ID_Distributor VARCHAR(10) FOREIGN KEY REFERENCES Distributor(ID_Distributor),
    Tanggal_Pesan DATE,
    Tanggal_Terima DATE,
    -- Otomatis menghitung selisih hari
    Lama_Proses AS DATEDIFF(day, Tanggal_Pesan, Tanggal_Terima)
);

-- 4. Tabel Barang
CREATE TABLE Barang (
    ID_Barang VARCHAR(10) PRIMARY KEY,
    No_Faktur VARCHAR(10) FOREIGN KEY REFERENCES Faktur(No_Faktur),
    Nama_Barang VARCHAR(100),
    Harga_Beli DECIMAL(18, 2),
    Harga_Jual DECIMAL(18, 2),
    -- Otomatis menghitung profit
    Margin AS (Harga_Jual - Harga_Beli)
);

-- 5. Tabel Detail Cabang
CREATE TABLE Distributor_Cabang (
    ID_Distributor VARCHAR(10) FOREIGN KEY REFERENCES Distributor(ID_Distributor),
    Lokasi_Cabang VARCHAR(50),
    PRIMARY KEY (ID_Distributor, Lokasi_Cabang)
);