# Bankey 🏦

[🇹🇷 Türkçe](#türkçe) | [🇬🇧 English](#english)

---

<h2 id="türkçe">🇹🇷 Türkçe</h2>

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
   git clone https://github.com/emircanozer/BankeyApp.git
   ```
2. Xcode'u açın.
3. Klonladığınız dizindeki `Bankey.xcodeproj` dosyasını çift tıklayarak Xcode'da projeyi açın.
4. Hedef cihaz olarak bir iOS Simülatörü (örneğin: iPhone 15 Pro) seçin.
5. Projeyi derlemek ve çalıştırmak için `Cmd + R` (Run) kısayolunu kullanın veya sol üstteki **Play** butonuna basın.

## 📝 Notlar

- Bu proje, iOS geliştirme pratiklerini (Programmatic UI, Network istekleri, Skeleton views, DispatchGroup vs.) pekiştirmek amacıyla geliştirilmiştir.
- Uygulama içi veriler API üzerinden çekilecek şekilde simüle edilmiş veya yerel olarak sağlanmıştır.

---

<h2 id="english">🇬🇧 English</h2>

Bankey is a modern iOS banking application simulation developed using Swift and Programmatic UI (without Storyboards). The application is designed to provide users with a foundational banking experience.

## 🚀 Features

- **Login Screen:** A user-friendly and secure login interface.
- **Onboarding:** Informative pages introducing the app's features to new users.
- **Account Summary:** A detailed view listing user account information, balances, and transactions.
- **Tab Bar Navigation:** A bottom menu bar providing easy switching between Account Summary, Move Money, and More tabs.
- **Skeleton Loading:** Modern skeleton loading animations displayed while data is being fetched.
- **Pull-to-Refresh:** The ability to refresh the list by pulling it down.

## 🛠 Technologies and Architecture Used

- **Language:** Swift
- **User Interface (UI):** Programmatic UI (Storyboards were not used, the interface is created entirely with code).
- **Architectural Approach:** MVC (Model-View-Controller) / MVVM-inspired structure (uses ViewModels).
- **Network Requests:** Network requests and asynchronous data fetching using `URLSession`. Synchronization of multiple requests using `DispatchGroup`.
- **Navigation:** `UINavigationController` and `UITabBarController`.
- **Error Handling:** Custom `enum`-based error handling for network errors, displaying alerts to the user.

## 📂 Project Structure

- **`Login/`**: Module containing login operations and interface.
- **`Onboarding/`**: Module containing onboarding screens and routing logic.
- **`AccountSummary/`**: Module containing the account list, balance info, skeleton loading cells, and the `UITableView` structure.
- **`Components/`**: Reusable custom UI components.
- **`Utils/`**: Helper functions, extensions, and general settings.
- **`MainViewController.swift`**: The main skeleton class that manages the core TabBar structure and tabs (Summary, Move Money, More).

## ⚙️ How to Run?

1. Clone the project to your computer:
   ```bash
   git clone https://github.com/emircanozer/BankeyApp.git
   ```
2. Open Xcode.
3. Open the project in Xcode by double-clicking the `Bankey.xcodeproj` file in the cloned directory.
4. Select an iOS Simulator (e.g., iPhone 15 Pro) as the target device.
5. Use the `Cmd + R` (Run) shortcut or press the **Play** button in the top left to build and run the project.

## 📝 Notes

- This project was developed to reinforce iOS development practices (Programmatic UI, Network requests, Skeleton views, DispatchGroup, etc.).
- In-app data is simulated to be fetched via API or provided locally.
