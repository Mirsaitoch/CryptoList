//
//  CryptoTableViewCell.swift
//  CryptoList
//
//  Created by Мирсаит Сабирзянов on 3/13/23.
//

import UIKit

struct CryptoTableViewCellViewModel{
    let name: String
    let symbol: String
    let price: String
}

class CryptoTableViewCell: UITableViewCell {

    static let identifier = "CryptoTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)

    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.sizeToFit()
        symbolLabel.sizeToFit()
        priceLabel.sizeToFit()
        
        nameLabel.frame = CGRect(x: 25, y: 0, width: contentView.frame.size.width/2, height: contentView.frame.size.height/2)
        
        symbolLabel.frame = CGRect(x: 25, y: contentView.frame.size.height/2, width: contentView.frame.size.width/2, height: contentView.frame.size.height/2)
        
        priceLabel.frame = CGRect(x: contentView.frame.size.width/2, y: 0, width: contentView.frame.size.width/2 - 15, height: contentView.frame.size.height/2)
    }
    
    func configure(with viewModel: CryptoTableViewCellViewModel){
        nameLabel.text = viewModel.name
        symbolLabel.text = viewModel.symbol
        priceLabel.text = viewModel.price

    }

}
