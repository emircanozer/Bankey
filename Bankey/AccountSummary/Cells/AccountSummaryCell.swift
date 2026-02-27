//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Emircan Özer on 25.02.2026.
//

import Foundation
import UIKit

//tableviewin içi fonksiyonlar ve diğer gerekliler acsumviewcon içinde tanımlanıyor incele
class AccountSummaryCell : UITableViewCell {
    
    
    //String? rawValue özelliği sayesinde Banking.rawValue dediğinde sana "Banking" metnini verir. Bu metni direkt ekrana basmak için kullanırız.enum sayesinde yazarken hata yapma olasığımız 0 oluyor kodlar daha temiz buradan direk erişilebiliyor Uygulamanın içinde dolaşacak "hesap türlerini" birer sabit haline getirdik.
    enum AccountType: String {
        case Banking
        case CreditCard
        case Investment
        
    }
    
    /* Bir hücrenin içinde 10 tane label olabilir. Bunları hücreye tek tek (name, date, amount...) göndermek yerine, hepsini bir ViewModel paketine koyup tek seferde teslim ediyoruz. zaten viewcontroller da kullanırken senden bu 2 veri türünü bekliyor */
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal // new
        
        var balanceAsAttributedString: NSAttributedString {
                return CurrencyFormatter().makeAttributedCurrency(balance)
            }
      
    }

    let viewModel: ViewModel? = nil
    
    
    let typeLabel = UILabel()
    let underlineView = UIView()
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    let nameLabel = UILabel()
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    let chevronImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


extension AccountSummaryCell {
    
    
    func setup() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account type"
        //tableviewcell içinde olduğumuz için direk contentview'a addsubview oluyor bunların tamamını diğer sayfada view.addsubview(tableview) yapıcaz
        contentView.addSubview(typeLabel)
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = appColor
        contentView.addSubview(underlineView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.text = "Account name"
       
        
        contentView.addSubview(nameLabel)
        
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0

        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        balanceLabel.adjustsFontSizeToFitWidth = true
        balanceLabel.text = "Some balance"
        

        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "XXX,XXX", cents: "XX")


        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
            
        contentView.addSubview(balanceStackView)
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")!.withTintColor(appColor, renderingMode: .alwaysOriginal)
        chevronImageView.image = chevronImage

        contentView.addSubview(chevronImageView)


         
        
    }
    
    func layout() {
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
            balanceStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
            
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        ])
        
    }
    
    /* Örneğin, bir bakiye ekranında:
    1.250,00 TL -> Burada "1.250" kısmı büyük ve kalın, ",00" kısmı küçük, "TL" kısmı ise farklı bir renkte olabilir. Bunların hepsini tek bir UILabel içinde NSAttributedString ile yaparsın. */
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
            let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
            let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
            let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
            
        // NSMutableAttributedString seçilmesinin sebebi, üzerine yeni parçalar eklenecek (append yapılacak)
            let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
            let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
            let centString = NSAttributedString(string: cents, attributes: centAttributes)
            
            rootString.append(dollarString)
            rootString.append(centString)
            
            return rootString
        }
    
    
}

/* gelen senaryoya (ViewModel) göre kostüm değiştirir.*/
extension AccountSummaryCell {
    //Bu metod, hücrenin "giyinme odasıdır".
    //vm paketine bakar ve "Benim tipim Investment mış, o zaman mor olayım" der.
    func configure(with vm: ViewModel) {
        
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        //enumdaki tipe göre renk ve yazı seçiliyor
        switch vm.accountType {
        case .Banking:
            underlineView.backgroundColor = .systemTeal
            balanceLabel.text = "Current balance"
        case .CreditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Current balance"
        case .Investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }
}

//"Yeni bir hesap tipi geldi: Altın Hesabı" dediklerinde, tüm uygulamayı değiştirmeyeceksin. Sadece Enum'a .Gold ekleyip, configure içine bir case .Gold rengi eklemen yeterli olacak. İşte profesyonel kod budur!
