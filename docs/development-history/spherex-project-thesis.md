# SPHEREx Sky Explorer — Bilimsel tanıtım için kalıcı proje özü

## Projenin temel cümlesi

> Biz NASA'nın SPHEREx teleskobundan gelen gerçek kızılötesi verileri
> analiz edebilen bir web platformu geliştirdik. Platformumuz aynı gökyüzü
> bölgesinin farklı tarihlerdeki görüntülerini gösteriyor, astronomik
> koordinatlarını hizalıyor, yaklaşık dalga boyu uyumunu kontrol ediyor,
> parlaklık farklarını hesaplıyor ve sonuçları bilimsel bir ön rapor
> hâlinde sunuyor. Amacımız yalnızca fotoğrafları göstermek değil,
> insanların gerçek uzay verilerini araştırabilmesini sağlamak.

## Gelecekte hazırlanacak tanıtım makalesinin ana başlıkları

1. SPHEREx görevine ve 102 spektral kanala giriş.
2. NASA/IPAC IRSA veri kaynakları ve Level 2 FITS formatı.
3. Öğrencilerin belirlediği sorun, kullanıcılar ve erişilebilirlik tasarımı.
4. 12 astronomik hedeften oluşan gözlem kataloğu; kaynak doğrulaması.
   14 Kasım kontrolünde 49 gerçek FITS kaynaklı bilimsel görüntü hazırdır:
   M101 9, Barnard 6, M87 6, M81 4, diğer 8 hedef 3'er görüntü.
   Bunlar seçilmiş ziyaretlerdir; NASA arşivinin bütünü değildir.
5. TAN-SIP koordinat hizalaması; IMAGE/FLAGS/VARIANCE/ZODI/WCS-WAVE.
6. Kızılötesi sahte renk önizleme ve zamansal animasyon.
7. Ön bilimsel ölçümler; ePSF kaynaklı yerel görüntü yanıtı, yaklaşık
   görüntü genişliği eşleştirmesi ve merkezi açıklık fotometrisi.
8. Veri kalitesi kapıları ve spektral uyumluluk; yanlılık ve sistematikler.
9. Kalıcı Floot PostgreSQL arşivi; 24 saatlik isteğe bağlı katalog kontrolü,
   kaynak FITS SHA-256 özetleri ve bilimsel rapor sürümlenmesi.
10. Sayısal doğrulamalar, sentetik negatif ve pozitif yazılım kontrolleri.
    14 Kasım sürümünde 15/15 sentetik yazılım kontrolü başarılıdır; buna
    merkez pikselleri maskelenmiş karelerde sahte fotometriyi önleme,
    izole tek piksel sıçramasını eleme, komşu piksel bölgelerini ayırma,
    sabit tohumlu 24 negatif ve 24 belirgin enjeksiyon deneyi dahildir.
    Bu rakamlar gerçek astronomik yanlış alarm oranı değildir.
11. Sağlanan fonksiyonlarla sınırlı bilimsel bulgular ve henüz
    doğrulanmamış gezegen/hareket iddialarına ilişkin açık sınırlamalar.
12. NASA Space Apps 2026 görev şartlarıyla karşılaştırma, canlı ürün
    gösterimi, öğrenci katkıları, görev dağılımı ve gelecek çalışmalar.

## Bilimsel ifade ilkeleri

- SPHEREx görüntüsü optik fotoğraf değil, kızılötesi ölçümdür.
- Kızılötesi sahte renk gerçek görünür rengin kanıtı değildir.
- Görüntü büyütme teleskobun gerçek doğal çözünürlüğünü artırmaz.
- EPSF ikinci moment genişliği, tam alan- ve dalga boyu bağımlı PSF
  modeliyle yapılan hassas fotometrinin yerini almaz.
- DR1/QR3 EPSF örnekleme ölçeği orijinal FITS başlığından OVSMPX/OVSMPY
  olarak 5 okunmalıdır. İlk sürümün 10 varsayımı düzeltilmiş;
  arşivdeki eski modeller okunduğunda genişlikler bir kereye mahsus
  doğru birime dönüştürülür. 49/49 karede EPSF genişliği bulunmuştur.
- M42 ve M51'in birer karesinde geçerli piksel kapsamı %50 altında:
  bu kareler otomatik aday taramasında dışlanır, orijinal verileri korunur.
- M101'in ilk altı zaman karesi arasında yeterli spektral örtüşme
  bulunamadığı için aynı hedeften üç gerçek Aralık 2025 gözlemi
  alındı. Dokuz karelik raporda en iyi çift için 7.549 yaklaşık
  dalga boyu eşleşen piksel bulundu. Komşu yüksek skorlu bölgeler
  sadece insan incelemesine adaydır, keşif değildir.
- WCS-WAVE, görselleştirme amaçlı yaklaşık spektral bilgidir; tam
  bilimsel spektrum/kanal eşleştirmesi için CWAVE/CBAND gerekir.
- Korrele yeniden örnekleme gürültüsü ve model sistematikleri
  kalibre edilmeden 6σ tarama eşiği bilimsel keşif anlamına gelmez.
- Yeni gezegen veya hareket keşfi iddiası, bağımsız doğrulama olmadan
  kurulmaz. NASA yarışma görevinde böyle bir keşif ön koşul değildir.
- NASA'nın resmî Tractor tabanlı zorunlu spektrofotometri aracı,
  bilinen astronomik kaynak konumlarının bağımsız kalibrasyonu için
  ayrı bir doğrulama aşaması olarak değerlendirilebilir. Dokümantasyon:
  https://irsa.ipac.caltech.edu/onlinehelp/spherex/spherex/sp.html

## Veri ve araçlar

NASA/IPAC IRSA; SPHEREx DR1 ve QR3 Level 2 Spectral Images;
TAN-SIP; WCS-WAVE; EPSF; FITS; PostgreSQL; Floot web uygulaması;
ölçüme dayalı ve kaynağı denetlenebilir raporlar.

## Kaynak

SPHEREx DR1 Spectral Images DOI 10.26131/IRSA678.
https://irsa.ipac.caltech.edu/data/SPHEREx/docs/overview_dr1.html

Bu dosya proje geliştirme notudur; jüri için hazırlanmış onaylanmış
bilimsel sonuç belgesi değildir.
