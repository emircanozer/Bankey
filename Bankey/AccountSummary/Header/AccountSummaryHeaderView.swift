//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Emircan Özer on 25.02.2026.
//

// projenin tek storyboard kısmı tableviewin headeri için zorunlu videoda ekranı size freeform yaptık height verdik file'S owner classını bu sayfa yaptık outleti sürükle bırak

import UIKit

class AccountSummaryHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    let shakeyBellView = ShakeyBellView()
    
    
    //mvvm için ekrana basmadan view model den geçiriyoruz
    struct ViewModel {
        let welcomeMessage: String
        let name: String
        let date: Date
        
        var dateFormatted: String {
            return date.monthDayYearString
        }
    }
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        override var intrinsicContentSize: CGSize {
            return CGSize(width: UIView.noIntrinsicMetric, height: 144)
        }
        
        private func commonInit() {
            let bundle = Bundle(for: AccountSummaryHeaderView.self)
            bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
            addSubview(contentView)
            contentView.backgroundColor = appColor
            
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
            setupShakeyBell()
        }
    
    private func setupShakeyBell() {
            shakeyBellView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(shakeyBellView)
            
            NSLayoutConstraint.activate([
                shakeyBellView.trailingAnchor.constraint(equalTo: trailingAnchor),
                shakeyBellView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    
    //veriler viewmodele gelicek bu fonk sayaesinde ekrana basılacak
    func configure(viewModel: ViewModel) {
        welcomeLabel.text = viewModel.welcomeMessage
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.dateFormatted
    }
    
    
}
