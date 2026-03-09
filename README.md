# Bankey 🏦

Bankey, Swift ve Programmatic UI (Storyboard kullanmadan) ile geliştirilmiş modern bir iOS bankacılık uygulaması simülasyonudur. Uygulama, kullanıcılara temel bankacılık deneyimini sunmak için tasarlanmıştır.

## 🚀 Özellikler

- **Giriş Ekranı (Login):** Kullanıcı dostu ve güvenli bir giriş ekranı.
- **Karşılama Ekranı (Onboarding):** Yeni kullanıcılar için uygulamanın özelliklerini tanıtan bilgilendirici sayfalar.
- **Hesap Özeti (Account Summary):** Kullanıcının hesap bilgilerini, bakiyelerini ve işlemlerini listeleyen detaylı bir görünüm.
- **Tab Bar Navigasyonu:** Hesap Özeti (Summary), Para Transferi (Move Money) ve Daha Fazla (More) sekmeleri arasında kolay geçiş sağlayan alt menü çubuğu.
- **Skeleton Loading:** Veriler yüklenirken gösterilen modern iskelet (skeleton) yükleme animasyonları.
- **Pull-to-Refresh:** Listeyi aşağı kaydırarak yenileme özelliği.

## 🛠 Kullanılan Teknolojiler ve Mimari

- **Dil:** Swift
- **Kullanıcı Arayüzü (UI):** Programmatic UI (Storyboard kullanılmamıştır, arayüz kod ile oluşturulmuştur).
- **Mimari Yaklaşım:** MVC (Model-View-Controller) / MVVM esintili yapı (ViewModel kullanımı mevcuttur).
- **Ağ İstekleri:** `URLSession` ile ağ istekleri ve asenkron veri çekme. `DispatchGroup` ile birden fazla isteğin senkronizasyonu.
- **Navigasyon:** `UINavigationController` ve `UITabBarController`.
- **Hata Yönetimi:** Ağ hataları için özelleştirilmiş `enum` tabanlı hata yönetimi ve kullanıcıya uyarı (Alert) gösterme.

## 📂 Proje Yapısı

- **`Login/`**: Giriş işlemlerini ve arayüzünü barındıran modül.
- **`Onboarding/`**: Karşılama ekranları ve yönlendirme mantığını içeren modül.
- **`AccountSummary/`**: Hesap listesi, bakiye bilgileri, skeleton yükleme hücreleri ve `UITableView` yapısını barındıran modül.
- **`Components/`**: Yeniden kullanılabilir özel UI bileşenleri.
- **`Utils/`**: Yardımcı fonksiyonlar, uzantılar (extensions) ve genel ayarlar.
- **`MainViewController.swift`**: Uygulamanın temel TabBar yapısını ve sekmeleri (Summary, Move Money, More) yöneten ana iskelet sınıfı.

## ⚙️ Nasıl Çalıştırılır?

1. Projeyi bilgisayarınıza klonlayın:
   ```bash
   git clone <repo-url>
   ```
2. Xcode'u açın.
3. Klonladığınız dizindeki `Bankey.xcodeproj` dosyasını çift tıklayarak Xcode'da projeyi açın.
4. Hedef cihaz olarak bir iOS Simülatörü (örneğin: iPhone 15 Pro) seçin.
5. Projeyi derlemek ve çalıştırmak için `Cmd + R` (Run) kısayolunu kullanın veya sol üstteki **Play** butonuna basın.

## 📝 Notlar

- Bu proje, iOS geliştirme pratiklerini (Programmatic UI, Network istekleri, Skeleton views, DispatchGroup vs.) pekiştirmek amacıyla geliştirilmiştir.
- Uygulama içi veriler API üzerinden çekilecek şekilde simüle edilmiş veya yerel olarak sağlanmıştır.
