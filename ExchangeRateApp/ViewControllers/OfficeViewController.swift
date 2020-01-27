//
//  OfficeViewController.swift
//  ExchangeRateApp
//
//  Created by Ihor Vozhdai on 24.01.2020.
//  Copyright © 2020 Ihor Vozhdai. All rights reserved.
//

import UIKit

class OfficeViewController: UITableViewController {
    // MARK: Variables
    let networkService = NetworkService()
    var offices = [Offices]()
    let city = ["Винница",
                "Луцк",
                "Житомир",
                "Львов",
                "Херсон",
                "Чернигов",
                "Харьков",
                "Киев",
                "Черкассы",
                "Днепропетровск"]
    override func viewDidLoad() {
        super.viewDidLoad()
        getOffices(searchValue: city[8])
    }
    
    func getOffices(searchValue: String) {
        networkService.fetchOffices(search: searchValue) { [weak self] (offices, error) in
            DispatchQueue.main.async {
                self?.offices = offices ?? [Offices]()
                self!.tableView.reloadData()
            }
        }
    }
    
    func callAlert() {
        let alert = UIAlertController(title: "Please select the city", message: "\n\n\n\n\n", preferredStyle: .alert)
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("OfficesTableViewCell", owner: self, options: nil)?.first
        as! OfficesTableViewCell
        cell.countryLabel.text = " \(offices[indexPath.row].country)"
        cell.stateLabel.text = " \(offices[indexPath.row].state) область"
        cell.cityLabel.text = " г. \(offices[indexPath.row].city)"
        cell.indexLabel.text = " Индекс: \(offices[indexPath.row].index)"
        cell.addressLabel.text = " Адрес: \(offices[indexPath.row].address)"
        cell.phoneLabel.text = " Тел.:\(offices[indexPath.row].phone)"
        cell.nameLabel.text = " \(offices[indexPath.row].name)"
        return cell
    }
    
    @IBAction private func searchButtonTapped(_ sender: UIBarButtonItem) {
        callAlert()
    }
}

extension OfficeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return city.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return city[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getOffices(searchValue: city[row])
    }
}
