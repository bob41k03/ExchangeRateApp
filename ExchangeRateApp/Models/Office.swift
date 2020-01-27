//
//  Office.swift
//  ExchangeRateApp
//
//  Created by Ihor Vozhdai on 23.01.2020.
//  Copyright © 2020 Ihor Vozhdai. All rights reserved.
//

import Foundation

struct Offices: Decodable {
    let country: String
    let state: String
    let city: String
    let index: String
    let address: String
    let phone: String
    let email: String
    let name: String
}
