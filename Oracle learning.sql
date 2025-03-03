/* tablo olusturma */
create table deneme (
isim     varchar(50), 
soyisim  varchar(50),
yas      number(3) NOT NULL,
mail     varchar(100) PRIMARY KEY
);

create table veri_tipi (
tc_no char(11),
telefon char(11)
);

/* long kullanımı */
create table veri_tipi_2 (
tc_no long,
telefon number(11)
); /*sadece 1 sütun long içerebilir*/

/* tabloya veri ekleme */
INSERT INTO veri_tipi(telefon) VALUES ('05419999999');

/* küsüratlı sayı */
create table veri_tipi_3 (
uzunluk number(5,2)
);

INSERT INTO veri_tipi_3 VALUES (123.32134);



/* STORED PROCEDURE */



/* date */
create table tarih_ornek (
dogum_tarihi date
);

INSERT INTO tarih_ornek VALUES ('09-11-2002');
/* sysdate sistemin gosterdigi suanki tarihi alir */
select sysdate "SUANKI TARIH", dogum_tarihi from tarih_ornek;

/* deneme */

create table uygulama(
isim    varchar2(15),
soyisim varchar2(30),
dogum   date,
mail    varchar2(65)  UNIQUE ,
tc      char(11)      PRIMARY KEY ,
boy     number(3)
);

INSERT INTO uygulama VALUES ('Tugcan','Uslu','09-11-2002','tugcanslu@gmail.com',11111111111,178);
INSERT INTO uygulama VALUES ('Alp','Unal','09-12-2003','alpunlx@gmail.com',11111111112,180);

/* DML INSERT UPDATE DELETE */

create table dmlornek (
isim varchar2(20),
tc_numara char(11),
numara number(11)
);

INSERT INTO dmlornek VALUES ('Tugcan' ,12345678912,05419999999);
INSERT INTO dmlornek (isim,numara) VALUES ('Alp',05429999999);
/*----------------------------------------------------------*/
create table personel (
adi varchar2(20),
soyad varchar2(20),
tc_no char (11),
mail_Adresi varchar2(65),
tel_no number (11)
);

INSERT INTO personel VALUES ('Tugcan', 'Uslu', 11111111111, 'tugcanslu@gmail.com', 05419999999) ;

SELECT * FROM personel ;
SELECT adi, mail Adresi FROM personel;

SELECT mail Adresi "Mail" FROM personel;

SELECT DISTINCT * FROM personel; /* benzersiz */


/* order by */

create table dersedevam (
isim     varchar2(20),
soyisim  varchar2(20),
numara   number(3),
yas      number(3)
);

INSERT INTO dersedevam VALUES ('Tugcan','Uslu',131,15);
INSERT INTO dersedevam VALUES ('Alp','Unal',777,22);

SELECT yas FROM dersedevam ORDER BY yas ; /* ARTAN */
SELECT yas FROM dersedevam ORDER BY yas  ASC; /* ARTAN */
SELECT yas FROM dersedevam ORDER BY yas  DESC;  /* AZALAN */

SELECT isim FROM dersedevam ORDER BY isim ; /* alfabetik */
SELECT isim FROM dersedevam ORDER BY isim ASC; /* alfabetik */
SELECT isim FROM dersedevam ORDER BY isim DESC; /* tersten alfabetik */

SELECT numara , isim FROM dersedevam ORDER BY numara ASC , isim DESC;
SELECT numara , isim FROM dersedevam ORDER BY numara ASC , isim ASC;

SELECT numara , yas FROM dersedevam ORDER BY 2 ; /* yasa gore siralama */

/* aritmetik islemler */

create table isci(
isim varchar2(25),
soyisim varchar2(25),
maas number(4)
);

INSERT INTO isci VALUES ('Tugcan','Uslu',5000);
SELECT maas+250 as "yeni maas" from isci;
select maas+maas*5+5*9/3 "yeni maas" from isci where maas=5000;
select maas from isci;

/* WHERE */

CREATE TABLE iliskisel(
  isim varchar2(25),
  maaş number(4)
  );

INSERT TO iliskisel VALUES ('Tugcan',1000);

SELECT * FROM iliskisel WHERE maas = 1000 adn isim='Tugcan';


/* stored procedure */

/* ornek sorgular asagidakiler gibidir */

/* 1. Tüm Müşterileri Listeleyen SP yazınız. */

CREATE PROCEDURE spTumMusteriler
AS
SELECT * FROM Musteriler

EXEC spTumMusteriler

/* 2. Dışarıdan gönderilen bilgilere göre Nakliyeci kaydeden SP yi yazınız. */

CREATE PROCEDURE spNakliyeciEkle
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
AS
INSERT INTO Nakliyeciler (SirketAdi, Telefon)
VALUES (@sirketAdi, @telefon)

EXEC spNakliyeciEkle, 'NakliyeciAdi', '(555) 123-1234'

EXEC spNakliyeciEkle @sirketAdi = 'NakliyeciAdi', @telefon = '(555) 123-1234'

/* 3. Dışadırdan gönderilen bilgilere göre Nakliyecinin tüm bilgilerini güncelleyen SP yi yazınız. */

CREATE PROCEDURE spNakliyeciDuzenle
@nakliyeciID int,
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
AS
UPDATE Nakliyeciler SET SirketAdi = @sirketAdi, Telefon = @telefon WHERE NakliyeciID = @nakliyeciID

EXEC spNakliyeciDuzenle 4,'NakliyeciAdi','(444) 123-1234'

EXEC spNakliyeciDuzenle @nakliyeciID=4, @sirketAdi = 'NakliyeciAdi', @telefon = '(333) 123-1234'


/* 4. Dışarıdan gönderilen bilgiye göre Nakliyeciyi silen SP yi yazınız. */

CREATE PROCEDURE spNakliyeciSil
@nakliyeciID INT
AS
DELETE FROM Nakliyeciler WHERE NakliyeciID = @nakliyeciID

EXEC spNakliyeciSil 4 
EXEC spNakliyeciSil @nakliyeciID=4

/* 5. Dışarıdan gönderilen bilgilere göre Nakliyeci kaydeden SP yi yazınız. Aynı telefon numarası varsa kaydetmeyiniz. */

CREATE PROCEDURE spNakliyecilerEkle
@SirketAdi nvarchar(40),
@Telefon nvarchar(24)
AS
DECLARE @sayi INT SET @sayi = (SELECT COUNT (*) FROM Nakliyeciler WHERE Telefon = @Telefon) 
IF @sayi>0
BEGIN
    print 'Böyle bir telefon numarası kayıtlı'
END
ELSE
BEGIN
    INSERT INTO Nakliyeciler (SirketAdi,Telefon)
    VALUES (@SirketAdi, @Telefon)
    print 'Nakliyeci Eklendi.'
END

EXEC spNakliyecilerEkle 'NakliyeciAdi', '(555) 123-1234'

EXEC spNakliyecilerEkle @sirketAdi = 'NakliyeciAdi', @telefon = '(555) 123-1234'

/* 6. Gönderilen KategoriID ye göre ürünleri listeleyen SP yi yazınız (UrunID, UrunAdi, KategoriAdi) */

CREATE PROCEDURE spUrunlerKategoriID
@kategoriID INT
AS
SELECT u.UrunID, u.UrunAdi, k.KategoriAdi
FROM Urunler u INNER JOIN Kategoriler k ON u.KategoriID = k.KategotiID
WHERE k.KategoriID = @kategoriID

EXEC spUrunlerKategoriID 2
EXEC spUrunlerKategoriID @kategoriID=2

/* 7. Dışarıdan gönderilen musteriID ye göre o müşterinin satın aldığı ürünleri ve kaç adet satın aldığını listeleyen SP yazınız. */

CREATE PROCEDURE spMusteriUrunAdet
@MusteriID nchar(5)
AS
SELECT u.UrunAdi, SUM(sd.Miktar) AS
ToplamAdet FROM Urunler u
INNER JOIN [Satis Detaylar] sd ON
u.UrunID=sd.UrunID
INNER JOIN Satislar s ON sd.SatisID = s.SatisID
WHERE s.MusteriID = @MusteriID
GROUP BY u.UrunAdi

EXEC spMusteriUrunAdet 'ALFKI'

EXEC spMusteriUrunAdet @MusteriID='ALFKI'

/* 8. Dışarıdan gönderilen iki tarih arasında sevk edilen satışları listeleyen SP yi yazınız. */

CREATE PROCEDURE spSatisIkiTarih
@basTarih smalldatetime,
@bitTarih smalldatetime
AS
SELECT * FROM Satislar WHERE SevkTarihi
BETWEEN @basTarih AND @bitTarih

EXEC spSatisIkiTarih '01.01.1997','02.01.1997'
EXEC spSatisIkiTarih @basTarih='01.01.1997',@bitTarih='02.01.1997'

/* 9. Dışarıdan gönderilen SatisID ye göre yapılan satışın UrunAdi,BirimFiyatı,Miktar,İndirim,İndirimli toplam fiyatı şeklinde listeleyen SP yi yazınız. */

CREATE PROCEDURE spSatisDetay
@SatisID INT
AS
SELECT UrunAdi, BirimFiyatı=ROUND(Od.BirimFiyatı,2),
Miktar,
İndirim=CONVERT(int, İndirim * 100),
İndirimliToplamFiyati=ROUND(CONVERT(money, Miktar *(1-İndirim)*Od.BirimFiyatı),2)
FROM Urunler P, [Satis Detaylari] Od
WHERE Od.UrunID = P.UrunID AND Od.SatisID=@SatisID

EXEC spSatisDetay 10248
EXEC spSatisDetay @SatisID = 10248

/* 10. Dışarıdan gönderilen sayı kadar en yüksek fiyata sahip ürünleri listeleyen SP yi yazınzı. Sayı gönderilmezse 10 adet ürünleri listeleyiniz. */

CREATE PROCEDURE spEnPahaliUrunler
@sayi int = 10
AS
SET ROWCOUNT @sayi
SELECT Urunler.UrunAdi 
AS
TenMostExpensiveUrunler, Urunler.BirimFiyati 
FROM Urunler
ORDER BY UrunleR.BirimFiyati DESC
SET ROWCOUNT 0

EXEC spEnPahaliUrunler 5
EXEC spEnPahaliUrunler @sayi = 5
EXEC spEnPahaliUrunler /* kac urunse o kadar*/

/* 11. Dışarıdan gönderilen iki tarih arasında satışı yapılan indirimli ürünlerin UrunAdi, İndirim, SatisTarihi şeklinde listeleyen SP yi yazınız. */

CREATE PROCEDURE spIkiTarihArasiIndirimliUrunler
@basTarih smalldatetime,
@bitTarih smalldatetime
AS
SELECT u.UrunAdi, sdIndirim, s.SatisTarihi
FROM Urunler u
INNER JOIN [Satis Detaylari] sd ON u.UrunID = sd.UrunID
INNER JOIN Satislar s ON s.SatisID = sd.SatisID
WHERE sd.Indirim > 0 AND
s.satisTarihi BETWEEN @basTarih AND @bitTarih

EXEC spIkiTarihArasiIndirimliUrunler @basTarih = '01.01.1996', @bitTarih='12.12.1996'
EXEC spIkiTarihArasiIndirimliUrunler '01.01.1996', '12.12.1996'
