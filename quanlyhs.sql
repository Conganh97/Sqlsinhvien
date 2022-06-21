create database quanlyhs;

use quanlyhs;

create table khoa (
makhoa int primary key,
tenkhoa varchar(50)
);

create table Lop (
malop int primary key,
tenlop varchar(50),
makhoa int,
FOREIGN KEY (makhoa) REFERENCES khoa(makhoa)
);

create table sinhvien (
masv int primary key,
hoten varchar (50),
ngaysinh datetime,
hocbong varchar (50),
gioitinh varchar (50),
malop int,
FOREIGN KEY (malop) REFERENCES lop(malop)
);

create table monhoc (
mamonhoc int primary key,
tenmonhoc varchar (50),
sotiet varchar (50)
);


create table ketqua (
madiem int primary key,
diem float,
mamonhoc int,
masinhvien int,
FOREIGN KEY (mamonhoc) REFERENCES monhoc(mamonhoc),
FOREIGN KEY (masinhvien) REFERENCES sinhvien(masv)
);

INSERT INTO `quanlyhs`.`khoa` (`makhoa`, `tenkhoa`) VALUES ('1', 'Công nghệ thông tin');
INSERT INTO `quanlyhs`.`khoa` (`makhoa`, `tenkhoa`) VALUES ('2', 'Kỹ thuật');
INSERT INTO `quanlyhs`.`khoa` (`makhoa`, `tenkhoa`) VALUES ('3', 'Mỹ thuật');

INSERT INTO `quanlyhs`.`sinhvien` (`masv`, `hoten`, `ngaysinh`, `hocbong`, `gioitinh`, `malop`) VALUES ('1', 'Công Anh', '1997-01-12', 'top1', 'nam', '1');
INSERT INTO `quanlyhs`.`sinhvien` (`masv`, `hoten`, `ngaysinh`, `hocbong`, `gioitinh`, `malop`) VALUES ('2', 'Thu Hồi', '1996-05-02', 'top2', 'nữ', '3');
INSERT INTO `quanlyhs`.`sinhvien` (`masv`, `hoten`, `ngaysinh`, `hocbong`, `gioitinh`, `malop`) VALUES ('3', 'Hoàng', '1990-06-06', 'top3', 'nam', '2');

-- câu 5:
select * from sinhvien where hoten like 'Trần%';

-- câu 6:

select * from sinhvien where gioitinh like 'nữ' and hocbong >0; 

-- câu 7:

select * from sinhvien where gioitinh like 'nữ';

select * from sinhvien where hocbong > 0 ; 

-- câu 8:

select * from sinhvien where year(ngaysinh) between 1995 and 2000;

-- câu 9:

select * from sinhvien order by masv ;

-- câu 10:

select * from sinhvien order by hocbong desc;

-- câu 12:

select * from sinhvien inner join khoa where hocbong > 0 and tenkhoa = 'công nghệ thông tin';

-- câu 14:

select tenlop,count(masv) as 'số sinh vien' from lop join sinhvien on lop.malop = sinhvien.malop group by tenlop; 

-- câu 15:

select khoa.tenkhoa, count(sinhvien.masv) as 'số sinh viên' 
from khoa join lop on khoa.makhoa = lop.makhoa join sinhvien on lop.malop = sinhvien.malop 
group by khoa.tenkhoa;

-- câu 16:

select tenkhoa, count(sinhvien.masv) as 'số sinh viên nữ' 
from khoa join lop on khoa.makhoa = lop.makhoa join sinhvien on lop.malop = sinhvien.malop 
where sinhvien.gioitinh = 'nữ' 
group by khoa.tenkhoa;

-- cau 17 :

select Tenlop, sum(hocbong) as 'Số tiền học bổng' 
from lop join Sinhvien on lop.Malop = Sinhvien.Malop group by lop.Tenlop;

-- cau18 :

select khoa.Tenkhoa, sum(sinhvien.hocbong) as 'Số tiền học bổng' 
from khoa join lop on khoa.Makhoa = lop.Makhoa join Sinhvien on lop.Malop = Sinhvien.Malop  
group by khoa.Tenkhoa;

-- cau19

select khoa.Tenkhoa, count(sinhvien.Masv) as 'Số sinh viên' 
from khoa join lop on khoa.Makhoa = lop.Makhoa 
join Sinhvien on lop.Malop = Sinhvien.Malop  
group by khoa.Tenkhoa having count(sinhvien.Masv) > 1;

-- cau 20

select khoa.Tenkhoa, count(sinhvien.Masv) as 'Số sinh viên nữ' 
from khoa join lop on khoa.Makhoa = lop.Makhoa join Sinhvien on lop.Malop = Sinhvien.Malop 
where sinhvien.gioitinh='nu' 
group by khoa.Tenkhoa  
having count(sinhvien.Masv) > 0;

-- câu 22 :

select *  
from sinhvien 
where  hocbong = (select max(hocbong) From sinhvien);

-- câu 23:
select sinhvien.* , ketqua.diem, monhoc.tenmonhoc
from sinhvien join ketqua on sinhvien.masv = ketqua.masinhvien join monhoc on ketqua.mamonhoc = monhoc.mamonhoc
where tenmonhoc = 'Toán' 
and  diem =(select max(diem) 
from ketqua join monhoc on ketqua.mamonhoc = monhoc.mamonhoc 
where tenmonhoc = 'Toán');
