//
//  MainViewController.swift
//  Bankey
//
//  Created by Emircan Özer on 25.02.2026.
//

import UIKit

//Bu sınıf uygulamanın "iskeleti"dir. Alt taraftaki sekmeleri ve o sekmelerin içine girecek sayfaları yönetir.

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }

    private func setupViews() {
        let summaryVC = AccountSummaryViewController()
        let moneyVC = MoveMoneyViewController()
        let moreVC = MoreViewController()

        // settabbarımage utils kısmında tanımladık 
        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        

        /* Burada sayfalar doğrudan TabBar'a eklenmez. Önce bir `UINavigationController` (NC) içine konur. Çünkü bu sayfalarda bir butona basıp "detay" sayfasına gitmek istersen (Push/Pop), o sayfanın bir NC'ye sahip olması gerekir.*/
        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)

        summaryNC.navigationBar.barTintColor = appColor
        hideNavigationBarLine(summaryNC.navigationBar)
        
        //sayfaları arraye atadık
        let tabBarList = [summaryNC, moneyNC, moreNC]

        //önemli
        viewControllers = tabBarList
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
}

class AccountSummaryViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemGreen
    }
}

class MoveMoneyViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
    }
}

class MoreViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemPurple
    }
}
