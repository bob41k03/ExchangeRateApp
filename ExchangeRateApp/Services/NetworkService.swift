//
//  NetworkService.swift
//  ExchangeRateApp
//
//  Created by Ihor Vozhdai on 23.01.2020.
//  Copyright © 2020 Ihor Vozhdai. All rights reserved.
//

import Foundation

class NetworkService {
    func fetchRate(completionHandler: @escaping ([Rate]?, Error?) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.privatbank.ua"
        components.path = "/p24api/pubinfo"
        components.queryItems = [URLQueryItem(name: "exchange", value: nil),
                                 URLQueryItem(name: "json", value: nil),
                                 URLQueryItem(name: "coursid", value: "11")]
        guard let url = components.url else { return }
        URLSession
            .shared
            .dataTask(with: url) { data, response, error in
                guard let response = response as? HTTPURLResponse else { return }
                if let data = data, (200...299).contains(response.statusCode) {
                    do {
                        let rates = try JSONDecoder().decode([Rate].self, from: data)
                        completionHandler(rates, nil)
                    } catch {
                        debugPrint(error.localizedDescription)
                        completionHandler(nil, error)
                    }
                }
        }.resume()
    }
    func fetchOffices(search: String?, completionHandler: @escaping ([Offices]?, Error?) -> Void) {
        
       var components = URLComponents()
        components.scheme = "https"
        components.host = "api.privatbank.ua"
        components.path = "/p24api/pboffice"
        components.queryItems = [URLQueryItem(name: "json", value: nil),
                                 URLQueryItem(name: "city", value: search),
                                 URLQueryItem(name: "name", value: "name")]
        guard let url = components.url else { return }
        URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else { return }
                if let data = data, (200...299).contains(response.statusCode) {
                    do {
                        let branches = try JSONDecoder().decode([Offices].self, from: data)
                        completionHandler(branches, nil)
                    } catch {
                        print(error)
                        completionHandler(nil, error)
                    }
                }
        }.resume()
    }
}

