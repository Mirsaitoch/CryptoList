//
//  ExchangeViewController.swift
//  CryptoList
//
//  Created by Мирсаит Сабирзянов on 3/11/23.
//

import UIKit

class ExchangeViewController: UIViewController {

    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var eth: UILabel!
    @IBOutlet weak var btc: UILabel!
    
    let apiKey = "2821C0B7-77A4-4DAA-BBE6-0E05C1A4E94B"
    
    let dispatchGroup = DispatchGroup()
 
    
    var btcPrice: Double = 0 {
            didSet {
                DispatchQueue.main.async {
                    self.btc.text = String(format: "%.2f", self.btcPrice) + "$"
                    self.updateTotal()
                }
            }
        }

    var ethPrice: Double = 0 {
            didSet {
                DispatchQueue.main.async {
                    self.eth.text = String(format: "%.2f", self.ethPrice) + "$"
                    self.updateTotal()
                }
            }
        }

    var btcEthRatio: Double {
        if ethPrice == 0 {
            return 0
        }
        return btcPrice / ethPrice
    }

    func updateTotal() {
            let totalValue = String(format: "%.2f", btcEthRatio)
            total.text = "\(totalValue) ETH"
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewBack.layer.cornerRadius = 20
        let symbol = "BTC/USD"
        let symbol2 = "ETH/USD"
        
        fetchExchangeRate(for: symbol, apiKey: apiKey) { result in
            switch result {
                    case .success(let rate):
                        if let rate = rate {
                            self.btcPrice = rate
                        } else {
                            print("Unable to fetch exchange rate for \(symbol)")
                        }
                    case .failure(let error):
                        print("Error fetching exchange rate: \(error)")
                    }
        }
        fetchExchangeRate(for: symbol2, apiKey: apiKey) { result in
            switch result {
                    case .success(let rate):
                        if let rate = rate {
                            self.ethPrice = rate
                        } else {
                            print("Unable to fetch exchange rate for \(symbol)")
                        }
                    case .failure(let error):
                        print("Error fetching exchange rate: \(error)")
                    }
        }
    }
    
  

    func fetchExchangeRate(for symbol: String, apiKey: String, completion: @escaping (Result<Double?, Error>) -> Void) {
        let apiUrl = "https://rest.coinapi.io/v1/exchangerate/\(symbol)"
        guard let url = URL(string: apiUrl) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Empty response", code: 0, userInfo: nil)))
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("JSON data: \(json)")
                guard let jsonDict = json as? [String: Any], let rateData = jsonDict["rate"] as? Double else {
                    completion(.failure(NSError(domain: "Invalid JSON data", code: 0, userInfo: nil)))
                    return
                }
                completion(.success(rateData))


            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
