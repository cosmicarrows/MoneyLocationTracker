//
//  FirstViewController.swift
//  MoneyLocationTracker
//
//  Created by Laurence Wingo on 5/27/18.
//  Copyright © 2018 Cosmic Arrows, LLC. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UITableViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    
    @IBAction func addLocation(_ sender: UIBarButtonItem) {
        var location: CLLocation
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            location = CLLocation.init(latitude: 32.830579, longitude: -117.153839)
        } else {
            location = locationManager.location!
        }
        DataManager.sharedInstance.locations.insert(location, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        //the determining factor of this swtich statement returns an enum so we were able to use each possible enum as a case
        switch (CLLocationManager.authorizationStatus()) {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied:
            let alert = UIAlertController.init(title: "Permissions error", message: "This app needs location permission to work accurately", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        case .notDetermined:
            fallthrough
        default:
            locationManager.requestWhenInUseAuthorization()
        }
        
    }


}

