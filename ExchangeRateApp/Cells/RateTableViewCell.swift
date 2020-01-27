//
//  RateTableViewCell.swift
//  ExchangeRateApp
//
//  Created by Ihor Vozhdai on 23.01.2020.
//  Copyright © 2020 Ihor Vozhdai. All rights reserved.
//

import UIKit

class RateTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var currentImage: UIImageView!
    @IBOutlet private weak var сurrency: UILabel!
    @IBOutlet private weak var buyLabel: UILabel!
    @IBOutlet private weak var sellLabel: UILabel!
    
    func setImage(image: UIImage) {
        currentImage.image = image
    }
    
    func setBaseCurrency(currency: String, baseCurrency: String) {
        сurrency.text = currency + "/" + baseCurrency
    }
    
    func setBuy(buy: Double) {
        buyLabel.text = "Buy: " + String(format: "%.2f", buy)
    }
    
    func setSell(sell: Double) {
        sellLabel.text = "Sell: " + String(format: "%.2f", sell)
    }
}
