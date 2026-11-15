# SPHEREx Sky Explorer — Teknik ve Bilimsel Yöntem Kaydı

Tarih: 14 Kasım 2026. NASA Space Apps Challenge 2026 — Planet X and SPHEREx.
Bu dosya uygulamanın dahili teknik kaydıdır; resmî bir NASA bilimsel yayını değildir.

## Neden ve kapsam

Amaç, gerçek SPHEREx spektral gözlemlerini halkın inceleyebileceği bir zaman
çizelgesinde sunmak, nicel kalite metrikleri ve bilimsel olarak ihtiyatlı
karşılaştırmalarla araştırılabilir hâle getirmektir.

## Mevcut mimari

1. Floot React 19 arayüzü: tarih sırası oynatıcısı, iki kareyi harmanlama,
   işlem günlüğü, ilerleme çubuğu, Türkçe bilimsel rapor.
2. NASA/IPAC IRSA SIA2 GET: DR1 ve QR3 Level 2 spectral image kataloglarını
   seçilen ICRS RA/Dec koordinatlarında sorgular; dedektör seçilebilir.
3. NASA/IPAC IBE FITS cutout GET: size=0.1 veya size=0.2 derece.
4. FITS server parser: IMAGE, FLAGS, VARIANCE, ZODI, WCS TAN-SIP,
   WCS-WAVE yaklaşık dalga boyu/bant genişliği.
5. Ortak gökyüzü gridi: 96×96 piksel, kuzey yukarı/doğu sol,
   TAN-SIP ters izdüşümü ve en yakın komşu örnekleme.
6. Görselleştirme: IMAGE−ZODI; 2–99.5 persentil,
   asinh ölçek, sahte kızılötesi renk; 576×576 interpolasyonlu PNG.
7. Bilimsel fark: iki gridin aynı gökyüzü pikselinde, yaklaşık
   |λ1−λ2| ≤ (Δλ1+Δλ2)/2 olduğunda medyan merkezli B−A.
   Diğer pikseller koyu gösterilir. Ölçüm farkı gezegen/hareket keşfi değildir.
8. Ayrı Floot PostgreSQL (Neon) veritabanı: spherex_targets,
   spherex_catalog_cache, spherex_processed_frames, spherex_reports.
   SIA2 sorgu sonucu 24 saat geçerlidir. Güncelleme, hedef açıldığında
   veya kullanıcının NASA'da Ara düğmesine bastığında yapılır; gece
   boyunca kullanıcı olmadan arşiv indiren bir cron *kurulmamıştır*.
9. Processed frame cache: kaynak URL, FITS SHA-256, bilimsel sayı dizilerinin
   GZIP/B64 hâli, işlenmiş PNG, geçerli piksel oranı ve yaklaşık λ.
   Orijinal tam FITS dosyaları kullanıcının veritabanına kopyalanmaz;
   NASA/IPAC üzerinde kalır. Veri dosyalarının kopya kontrolü/görsel kalite
   orijinal kaynak kalitesiyle karıştırılmaz.
10. Bilimsel sonuç raporu: kare başına geçerli piksel oranı, yaklaşık
    dalga boyu, medyan IMAGE−ZODI ve tarih çiftleri için ortak gökyüzü
    pikselleri/örtüşen bantlar/medyan fark/robust MAD. Kayıtlı hedeflere
    ait raporlar ayrı PostgreSQL tablosunda sürümlenir.

## Doğrulanan 12 hedef (14 Kasım 2026 UTC)

| Hedef | D2 katalog kayıtları | Bilimsel FITS kesitleri |
|--|--:|--:|
| M101 | 52 | 6 |
| Barnard | 36 | 6 |
| M31 | 39 | 3 |
| M33 | 43 | 3 |
| M42 | 39 | 3 |
| M45 | 38 | 3 |
| M51 | 75 | 3 |
| M81 | 39 | 4 |
| M82 | 38 | 3 |
| M87 | 37 | 4 |
| M104 | 39 | 3 |
| M13 | 39 | 3 |

**Toplam: 12 hedef, 44 gerçek NASA FITS gözleminin işlenmiş alt-kesiti.**
Bu tablo tüm NASA gözlemlerini indirdiğimiz anlamına gelmez.
HTTP 502/503 geçici IRSA erişim sorunlarına karşı gerçek gözlem adayları
kontrollü denenir; sahte astronomik görüntü üretilmez.

## Bilimsel sınırlar

- DR1/QR3 aynı genel kalibrasyon neslinin ürünleridir; yine de
  zaman farkı tek başına hareket ya da astronomik değişim kanıtı değildir.
- Tek dedektörde bile piksellerin yaklaşık dalga boyları aynı olmayabilir.
  WCS-WAVE yaklaşık bir filtredir; hassas spektral karşılaştırma için
  CWAVE/CBAND ve PSF eşleştirmesi gereklidir.
- FLAGS/VARIANCE kullanımı analiz uygunluğunu iyileştirir; burada
  elde edilen bir sayısal 3σ piksel değeri nesne tespiti diye sunulmaz.
- Yeniden örnekleme yakın komşudur, ölçüm hataları koreledir. Sahte renk
  görüntü / interpolasyon görünümü iyileştirir, teleskobun gerçek
  astronomik açısal çözünürlüğünü artırmaz.
- İlk örnek hedefler M101 ve Barnard; yeni 10 hedef ilave edilmiştir.
  Özel koordinatlar ayrı bir dataset değil RA/Dec ile adlandırılmamış
  gökyüzü bölgesini sorgulama seçeneğidir.
- SPHEREx 102 nominal spektral kanalda gökyüzünü tarar; bu proje 102
  kanallı DR1 all-sky cube'un tamamını indirmez veya bağımsız BNN
  eğitim/gezegen keşfi iddiasında bulunmaz.

## Kaynaklar ve atıf

- NASA/IPAC SPHEREx Data Release 1 Spectral Images DOI:10.26131/IRSA678
- https://irsa.ipac.caltech.edu/data/SPHEREx/docs/overview_dr1.html
- https://irsa.ipac.caltech.edu/spherex-archive-documentation/spherex-data-products/
- https://irsa.ipac.caltech.edu/spherex-archive-documentation/spherex-data-access/
- SPHEREx DR1 All-Sky Cube DOI:10.26131/IRSA679 (bu proje henüz kullanmıyor).

## İşletim notları

- Kasım 2026 geliştirmesi: DR1/QR3 EPSF tablosundan seçilen konum için
  gerçek yerel noktasal kaynak yanıtı (33×33 örnek) okunur; ikinci moment
  yardımıyla yerel PSF genişliği hesaplanır. İki kare için yalnızca
  genişliğin yaklaşık izotropik Gauss eşitlenmesi yapılır; bu, tam
  uzaysal / spektral EPSF model eşleştirmesi değildir.
- Merkezi dairesel açıklık ve arka plan halkası üzerinden ölçülen
  parlaklık fazlası MJy/sr × grid piksel biriminde deneysel bir ön
  ölçümdür. Resmî kalibre edilmiş µJy kaynağı fotometrisi diye sunulmaz.
- Tarih çiftlerinde ampirik robust MAD, VARIANCE ve spektral bant
  örtüşmesi kullanan 6 eşik üstü görüntü-piksel taraması eklenmiştir.
  Bu skor kalibre edilmiş istatistiksel p-değeri, hareket doğrulaması
  veya ötegezegen keşfi değildir.
- Yedi sentetik yazılım kontrolü (özdeş kare, sentetik değişim, farklı
  dalga boyu reddi, eksik EPSF, genişlik eşleme, sabit arka plan,
  maskeli veri) bağımsız `/_api/spherex-self-test` endpoint'i ile
  çağrılabilir; fiziksel gözlem doğruluğunu değil kod işlevselliğini
  sınar.

- Kamuya açık üretim dağıtımı yayınlandıysa bile kod kontrolünden sonra
  URL başka oturumdan doğrulanmalıdır.
- 24h katalog TTL bir arka plan görevi değildir. Kullanıcı yeniden hedef
  açınca tazelenir; kaynak dosyaların SHA-256 ve kopya durumu kaydedilir.
- Ayrı günlük kaynak takibi otomasyonu, yalnızca
  kaynak değişimlerini raporlar; Floot veritabanına yazdığı varsayılmaz.
- Kullanıcıyla ilgili başka Supabase veritabanları, özellikle havacılık
  iş arama verileri, bu projede değiştirilmemiştir.
