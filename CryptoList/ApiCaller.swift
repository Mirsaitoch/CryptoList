//
//  ApiCaller.swift
//  CryptoList
//
//  Created by Мирсаит Сабирзянов on 3/11/23.
//

import Foundation

final class ApiCaller{
    
    static let shared = ApiCaller()
    
    private struct Constants{
        static let apikey = "2821C0B7-77A4-4DAA-BBE6-0E05C1A4E94B"
        static let assetsEndpoint = "https://rest.coinapi.io/v1/assets/"
    }
    public init(){
        
    }
    
    public func getAllCryptoData(completion: @escaping (Result<[Crypto], Error>) -> Void)
    {
        guard let url = URL(string: Constants.assetsEndpoint + "?apikey=" + Constants.apikey) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                completion(.success(cryptos))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
