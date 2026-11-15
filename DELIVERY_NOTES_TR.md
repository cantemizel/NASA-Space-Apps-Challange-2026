# SPHEREx Sky Explorer — Nihai teslim paketi

**GitHub:** Bu ZIP dosyasını açın; kökteki `README.md`, `floot_project/`, `database/`, `assets/`, `scripts/`, `docs/` klasörlerini GitHub deposuna yükleyin. **Yalnızca ZIP dosyasını depoya koymak**, kodların GitHub üzerinden kolay incelenmesini sağlamaz.

Canlı çalışan demo: https://www.cemberlitasmeninhack.com/

İçerik: 217 doğrulanmış kaynak dosyası; 4 PostgreSQL tablosunda 214 kayıt; 114 NASA/IPAC FITS kaynaklı işlenmiş veri karesi; altı proje görseli; bilimsel açıklama, kaynakça ve testler.

Veritabanını başka bir ortama yüklemek için önce `database/RESTORE.md` dosyasını okuyun.

**Önemli sınır:** Kaynak Floot platformuna özgüdür. Bu ZIP, tüm taşınabilir kodu/veriyi saklayan bir yedektir; Floot altyapısı ve gizli DB bağlantıları olmadan bir komutla tek başına çalıştırılabilir bağımsız web uygulaması değildir. NASA FITS dosyalarının tam ham kopyaları da pakette yoktur; orijinal bağlantıları korunmuştur.

**Gizlilik:** Parola, API anahtarı ve aktif `DATABASE_URL` bu arşive eklenmedi.
