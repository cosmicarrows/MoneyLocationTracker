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
        
        //every time a new location is added, we need to reload the tableView to reflect the changes to the array
        tableView.reloadData()
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
        super.viewDidAppear(true)
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
    
    //MARK: - tableView Implementation
    
    //for a one dimensional array the answer to this function will always be 1.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedInstance.locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        cell.tag = indexPath.row
        //tpull the nth entry from the dataSource in order to setup the look or configuration of the cell
        let entry: CLLocation = DataManager.sharedInstance.locations[indexPath.row]
        
        //configure the cell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss, MM-dd-yyyy"
        
        cell.textLabel?.text = "\(entry.coordinate.latitude), \(entry.coordinate.longitude) "
        
        cell.detailTextLabel?.text = dateFormatter.string(from: entry.timestamp)
        
        return cell
        
    }
    
    


}

