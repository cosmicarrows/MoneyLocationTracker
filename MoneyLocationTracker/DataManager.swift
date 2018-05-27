//
//  DataManager.swift
//  MoneyLocationTracker
//
//  Created by Laurence Wingo on 5/27/18.
//  Copyright © 2018 Cosmic Arrows, LLC. All rights reserved.
//

import Foundation
import CoreLocation

//imagine this is what NSUserDefaults or UIApplicatino objects look like
class DataManager {
    static let sharedInstance = DataManager()
    var locations : [CLLocation]
    private init() {
        locations = [CLLocation]()
    }
}
