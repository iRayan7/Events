//
//  DataManager.swift
//  Events
//
//  Created by Rayan Aldafas on 27/05/2018.
//  Copyright © 2018 RayanAldafas. All rights reserved.
//

import Foundation

// to reload tableView from any class
class Singleton {
    static let shared = Singleton()
    var tableViewScreen = ViewController()
}
