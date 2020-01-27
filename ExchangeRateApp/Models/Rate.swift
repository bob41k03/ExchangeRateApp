//
//  Rate.swift
//  ExchangeRateApp
//
//  Created by Ihor Vozhdai on 23.01.2020.
//  Copyright © 2020 Ihor Vozhdai. All rights reserved.
//

import Foundation

struct Rate: Decodable {
    let currency: String
    let baseCurrency: String
    let buy: Double
    let sell: Double
    
    enum CodingKeys: String, CodingKey {
        case currency = "ccy"
        case baseCurrency = "base_ccy"
        case buy = "buy"
        case sell = "sale"
    }
}

extension Rate {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.currency = try container.decode(String.self, forKey: .currency)
        self.baseCurrency = try container.decode(String.self, forKey: .baseCurrency)
        self.buy = Double(try container.decode(String.self, forKey: .buy)) ?? 0.0
        self.sell = Double(try container.decode(String.self, forKey: .sell)) ?? 0.0
    }
}
