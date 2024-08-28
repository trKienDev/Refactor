-- Before refactoring

SELECT 
		HDBH.Showroom, 
		HDBH.SoPhieu, 
		(HDBH.Showroom + HDBH.SoPhieu) AS PHIEU, 
		HDBH.LoaiNghiepVu, 
		HDBH.SoHoaDon, 
		HDBH.NgayHoaDon,
		HDBH.DaiDienHopDong, 
		HDBH.PhuongThucThanhToan, 
		CASE 
			WHEN HDBH.DTGTGT_DoiTuongKhachHang = 'DTPBLE001' THEN 'KHVL_LD' 
			ELSE HDBH.DTGTGT_DoiTuongKhachHang 
		END AS MaKhachHang,
		KH.NguoiDaiDienPhapLuat, 
		KH.Ten_KhachHang, 
		KH.DiaChi, 
		KH.MaSoThue,
		KH.SoTaiKhoan, 
		CASE 
			WHEN SUBSTRING(KH.Ma_KhachHang, 3, 9) IN ('DTPBLE001', 'DTPBLE002', 'DTPBLE003') 
			THEN DSXHD.Email 
			ELSE KH.EmailGuiKhachHangHoaDon 
		END AS EmailGuiKhachHangHoaDon
INTO #Tmpdanhmuchoadon --/ #Tmpdanhmuchoadon /--
FROM QLBanhangHeThongSR_2017..HoaDonBanHang AS HDBH
			LEFT JOIN KhachHang AS KH 
								ON HDBH.DTGTGT_DoiTuongKhachHang = KH.Ma_KhachHang
			LEFT JOIN ( SELECT  
												Showroom, 
												MauSo, 
												KyHieu, 
												NoiXuatHoaDon, 
												Email 
									FROM DanhSachXuatHoaDon  
									WHERE hieuluc = 1 
												   AND mauso LIKE '1%') AS DSXHD
								ON DSXHD.Showroom = HDBH.Showroom
WHERE ISNULL(HDBH.SoHoaDon, '') <> ''
				AND (HDBH.Showroom + HDBH.SoPhieu) IN (SELECT showroom + SOPHIEU FROM tblDanhMucHoaDon)
				AND HDBH.Showroom = @Showroom
				AND HDBH.SoPhieu = @SOPHIEU;

-- After refactoring
SELECT 
		HDBH.Showroom, 
		HDBH.SoPhieu, 
		(HDBH.Showroom + HDBH.SoPhieu) AS PHIEU, 
		HDBH.LoaiNghiepVu, 
		HDBH.SoHoaDon, 
		HDBH.NgayHoaDon,
		HDBH.DaiDienHopDong, 
		HDBH.PhuongThucThanhToan, 
		CASE 
				WHEN HDBH.DTGTGT_DoiTuongKhachHang = 'DTPBLE001' THEN 'KHVL_LD' 
				ELSE HDBH.DTGTGT_DoiTuongKhachHang 
		END AS MaKhachHang,
		KH.NguoiDaiDienPhapLuat, 
		KH.Ten_KhachHang, 
		KH.DiaChi, 
		KH.MaSoThue,
		KH.SoTaiKhoan, 
		CASE 
				WHEN SUBSTRING(KH.Ma_KhachHang, 3, 9) IN ('DTPBLE001', 'DTPBLE002', 'DTPBLE003') 
				THEN DSXHD.Email 
				ELSE KH.EmailGuiKhachHangHoaDon 
		END AS EmailGuiKhachHangHoaDon
INTO #Tmpdanhmuchoadon --/ #Tmpdanhmuchoadon /--
FROM 
		QLBanhangHeThongSR_2017..HoaDonBanHang AS HDBH
LEFT JOIN 
		KhachHang AS KH ON HDBH.DTGTGT_DoiTuongKhachHang = KH.Ma_KhachHang
LEFT JOIN 
		( 
				SELECT  
							Showroom, 
							MauSo, 
							KyHieu, 
							NoiXuatHoaDon, 
							Email 
				FROM 
							DanhSachXuatHoaDon  
				WHERE hieuluc = 1 
								AND mauso LIKE '1%'
		) AS DSXHD ON DSXHD.Showroom = HDBH.Showroom
WHERE 
			ISNULL(HDBH.SoHoaDon, '') <> ''
			AND (HDBH.Showroom + HDBH.SoPhieu) IN (SELECT showroom + SOPHIEU FROM tblDanhMucHoaDon)
			AND HDBH.Showroom = @Showroom
			AND HDBH.SoPhieu = @SOPHIEU;
