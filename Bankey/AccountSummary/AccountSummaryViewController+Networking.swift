//
//  AccountSummaryViewController+Networking.swift
//  Bankey
//
//  Created by Emircan Özer on 2.03.2026.
//

import Foundation
import UIKit


//bu tipe çevirecez 
struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    static func makeSkeleton() -> Account {
          return Account(id: "1", type: .Banking, name: "Account name", amount: 0.0, createdDateTime: Date())
      }
    
    
}

// result type otomatik olarak ya succes ya da failure dönüyor success olursa tanımladğımız  account structu failre olursa tanımladığımız network error dönsün dedik
extension AccountSummaryViewController {
    func fetchAccounts(forUserId userId: String, completion: @escaping (Result<[Account],NetworkError>) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)/accounts")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async { // guard ile datayı erroru aldık
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                //completion ile tanımlanananlar yukarıda tanımladığımız result type da verdiğimiz structların caseleri . ile erişiliyor
               
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let accounts = try decoder.decode([Account].self, from: data)
                    completion(.success(accounts))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}

