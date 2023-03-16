//
//  CryptoViewController.swift
//  CryptoList
//
//  Created by Мирсаит Сабирзянов on 3/11/23.
//

import UIKit

class CryptoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        tableView.backgroundView = UIImageView(image: UIImage(named: "bg"))
        return tableView
    }()
    
    
    private var viewModels = [CryptoTableViewCellViewModel]()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .default
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        ApiCaller.shared.getAllCryptoData{[ weak self] results in
            switch results{
            case .success(let models):
                self?.viewModels = models.compactMap({
                    let price = $0.price_usd ?? 0
                    let formatter = CryptoViewController.numberFormatter
                    let priceString = formatter.string(from: NSNumber(value: price))
                    
                    return CryptoTableViewCellViewModel(name: $0.name ?? "N/A",
                                                        symbol: $0.asset_id, price: priceString ?? "N/A")
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else{
             fatalError()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.separatorInset = UIEdgeInsets(top: 20, left: 100, bottom: 20, right: 20)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
