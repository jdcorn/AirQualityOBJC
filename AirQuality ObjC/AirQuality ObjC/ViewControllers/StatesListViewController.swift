//
//  StatesListViewController.swift
//  AirQuality ObjC
//
//  Created by jdcorn on 12/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class StatesListViewController: UIViewController {
    
    // MARK: - PROPERTIES
    var country: String?
    var states: [String] = [] {
        didSet {
            updateTableView()
        }
    }
    
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        guard let country = country else {return}
        DVMCityAirQualityController.fetchSupportedStates(inCountry: country) { (states) in
            if let states = states {
                self.states = states
            }
        }
    }
    
    // MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCitiesVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
            let country = country,
                let destinationVC = segue.destination as? CitiesListViewController
                else {return}
            let selectedState = states[indexPath.row]
            destinationVC.country = country
            destinationVC.state = selectedState
        }
    }
    
    // MARK: - FUNCTIONS
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension StatesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        let state = states[indexPath.row]
        cell.textLabel?.text = state
        return cell
    }
}
