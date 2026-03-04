//
//  ProfileManager.swift
//  Bankey
//
//  Created by Emircan Özer on 3.03.2026.
//

import Foundation
import UIKit

/* DI için ve testedilebilirlik açınsından viewcontroller da network işlemi yapmak yerine bu işlemi farklı bir sınıfta yapmak için buraya aldık profile manager sınıfı bu protokolü imlepement edip fetchprofile fonksiyonunu kullanıyor sonrasında viewcontrollerda türü belirtilen instace oluşturuluyor profilemanagerden (incele)  Eğer bunu yapmasaydık her ViewController'ın içine 50 satır internet kodu yazacaktık. Şimdi ise ViewController sadece tek satır kod yazıyor: profileManager.fetchProfile ,single responsiblty  */

protocol ProfileManageable: AnyObject {
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile,NetworkError>) -> Void)
}


enum NetworkError: Error {
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

// İnternetten veri çekme işi arka planda (background thread) yapılır. Ama ekrana bir şey basacaksan (completion çağırmak gibi), bunu ana thread'e (main thread) çekmek zorundasın. Yoksa uygulama çöker veya çok yavaşlar.
class ProfileManager : ProfileManageable {
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile,NetworkError>) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }                   //completion ile tanımlanananlar yukarıda tanımladığımız result type da verdiğimiz structların caseleri . ile erişiliyor
                
                do {
                    let profile = try JSONDecoder().decode(Profile.self, from: data)
                    completion(.success(profile))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
