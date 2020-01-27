//
//  RateViewController.swift
//  ExchangeRateApp
//
//  Created by Ihor Vozhdai on 23.01.2020.
//  Copyright © 2020 Ihor Vozhdai. All rights reserved.
//

import UIKit

class RateViewController: UITableViewController {
    let images = ["Dollar", "Euro", "Ruble", "Bitcoin"]
    let networkService = NetworkService()
    var rates = [Rate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRatesData()
    }
    
    func getRatesData() {
        self.networkService.fetchRate(completionHandler: { [weak self] (rates, error) in
                DispatchQueue.main.async {
                self?.rates = rates ?? [Rate]()
                self!.tableView.reloadData()
                   }
               })
           }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }

  
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("RateTableViewCell", owner: self, options: nil)?.first as! RateTableViewCell
        cell.setImage(image: UIImage(named: images[indexPath.row])!)
        cell.setBaseCurrency(currency: rates[indexPath.row].currency, baseCurrency: rates[indexPath.row].baseCurrency)
        cell.setBuy(buy: rates[indexPath.row].buy)
        cell.setSell(sell: rates[indexPath.row].sell)
        return cell
       }

    @IBAction func refreshButton(_ sender: UIBarButtonItem) {
        getRatesData()
    }
}
