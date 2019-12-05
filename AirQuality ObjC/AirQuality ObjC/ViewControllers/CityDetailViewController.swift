//
//  CityDetailViewController.swift
//  AirQuality ObjC
//
//  Created by jdcorn on 12/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    // MARK: - PROPERTIES
    var country: String?
    var state: String?
    var city: String?
    
    // MARK: - OUTLETS
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var stateNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    
    // MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city,
            let state = state,
            let country = country
            else { return }
        
        DVMCityAirQualityController.fetchData(forCity: city, state: state, country: country) { (cityDetails) in
            if let details = cityDetails {
                self.updateViews(with: details)
            }
        }
    }
    
    // MARK: - FUNCTIONS
        func updateViews(with details: DVMCityAirQuality) {
            DispatchQueue.main.async {
                self.cityNameLabel.text = details.city
                self.stateNameLabel.text = details.state
                self.countryNameLabel.text = details.country
                self.aqiLabel.text = "\(details.pollution.airQualityIndex)"
                self.windSpeedLabel.text = "\(details.weather.windSpeed)"
                self.temperatureLabel.text = "\(details.weather.temperature)"
                self.humidityLabel.text = "\(details.weather.humidity)"
            }
        }
    }
