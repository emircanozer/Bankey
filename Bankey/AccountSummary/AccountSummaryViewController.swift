//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Emircan Özer on 25.02.2026.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    // Request Models
    var profile: Profile?
    var accounts: [Account] = []
        
    // View Models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    //değerleri aldığımız array
    var accountCellViewModels: [AccountSummaryCell.ViewModel] = []
    
    var tableView = UITableView()
    var headerView = AccountSummaryHeaderView(frame: .zero)
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        setupNavigationBar()
        fetchData()
        
        
    }
    

    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //register zorunlu
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
            tableView.rowHeight = AccountSummaryCell.rowHeight
            tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView() {
        
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
    
    func setupNavigationBar() {
            navigationItem.rightBarButtonItem = logoutBarButtonItem
        }
    
    
    
    
    
}

// "YAYIN BAŞLADI: HERKES ÇIKIŞ YAPSIN!" post
extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
        
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
            
        // cell as! olduğu için sınıfa erişebiliyoruz
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
            let account = accountCellViewModels[indexPath.row]
            cell.configure(with: account)
            
            return cell
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//array dizine verileri ekliyoruz
extension AccountSummaryViewController {
    
}

/*
 //"Tüm bu farklı işler (profil çekme, hesapları çekme vb.) bitsin, hepsinin bittiğinden emin olduğumda tek bir seferde ekranı güncelleyeyim" demeni sağlayan bir "senkronizasyon" aracıdır. par.a parça yüklenmesin diye  dispatch group
  .enter(): Her bir yemek siparişi için mutfağa bir işaret bırakır (1, 2, 3...).
 .leave(): Her yemek hazırlandığında mutfak o işareti siler.
 .notify(): Masadaki tüm yemekler hazır olduğunda (işaretler sıfırlandığında), garson tepsiyi masaya getirir.*/
extension AccountSummaryViewController {
    private func fetchData() {
        let group = DispatchGroup()
        group.enter()
        fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let profile):         // diğer sayfada tanımladığımız fetch fonk @escaping  result type içindeki success ve failure içinde gelen kargoyu burada kullanıyoruz
                self.profile = profile
                self.configureTableHeaderView(with: profile)
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()  // her iş bloğunun başına ve sonuna enter ve leave toplu kullanım da notify da yapılır queqe main thread for ui seçimi relaod data hepsinde kullanılan fonksiyon olduğu için yazıldı
        }

        group.enter()
        fetchAccounts(forUserId: "1") { result in
                    switch result {
                    case .success(let accounts):
                        self.accounts = accounts
                        self.configureTableCells(with: accounts)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
            group.leave()
                }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    // işleyiş olarak her fonk parametre bekliyor ondan ona ondan ona parametre vere vere taşınıyor
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configure(viewModel: vm)
    }
    
    
    private func configureTableCells(with accounts: [Account]) {
         accountCellViewModels = accounts.map {
             AccountSummaryCell.ViewModel(accountType: $0.type,
                                          accountName: $0.name,
                                          balance: $0.amount)
         }
     }
}


