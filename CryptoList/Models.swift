//
//  Models.swift
//  CryptoList
//
//  Created by Мирсаит Сабирзянов on 3/13/23.
//

import Foundation


struct Crypto: Codable{
    let asset_id: String
    let name: String?
    let price_usd: Float?
    let id_icon: String?
}
