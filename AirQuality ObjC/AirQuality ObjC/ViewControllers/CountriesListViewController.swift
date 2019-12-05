//
//  CountriesListViewController.swift
//  AirQuality ObjC
//
//  Created by jdcorn on 12/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CountriesListViewController: UIViewController {
    
    // MARK: - PROPERTIES
    var countries = [String]() {
        didSet {
            updateTableView()
        }
    }
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DVMCityAirQualityController.fetchSupportedCountries { (countries) in
            if let countries = countries {
                self.countries = countries
            }
        }
    }
    
    // MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStatesVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? StatesListViewController
                else {return}
            let selectedCountry = countries[indexPath.row]
            destinationVC.country = selectedCountry
        }
    }
    
    
    // MARK: - FUNCTIONS
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
} // class

    // MARK: - PROTOCOLS
extension CountriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country = countries[indexPath.row]
        
        cell.textLabel?.text = country
        
        return cell
    }
}
