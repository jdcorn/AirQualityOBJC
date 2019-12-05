//
//  CitiesListViewController.swift
//  AirQuality ObjC
//
//  Created by jdcorn on 12/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {
    
    // MARK: - PROPERTIES
    var state: String?
    var country: String?
    var cities: [String] = [] {
        didSet {
            updateTableView()
        }
    }

    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        guard let state = state,
            let country = country
            else { return }
        DVMCityAirQualityController.fetchSupportedCities(inState: state, country: country) { (cities) in
            if let cities = cities {
                self.cities = cities
            }
        }
    }
    
    // MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityDetailsVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let country = country,
                let state = state,
                let destinationVC = segue.destination as? CityDetailViewController
                else { return }
            
            let selectedCity = cities[indexPath.row]
            destinationVC.city = selectedCity
            destinationVC.state = state
            destinationVC.country = country
        }
    }
    
    // MARK: - FUNCTIONS
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
}
