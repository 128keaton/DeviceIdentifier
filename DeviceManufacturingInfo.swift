//
//  DeviceManufacturingInfo.swift
//  macOS Utilities
//
//  Created by Keaton Burleson on 4/10/19.
//  Copyright © 2019 Keaton Burleson. All rights reserved.
//

import Foundation
import AppKit
import SwiftyJSON

struct DeviceManufacturingInfo {
    var city: String
    var company: String
    var country: String
    var date: Date?
    var flag: String
    var id: String

    init(city: String, company: String, country: String, date: String, flag: String, id: String) {
        self.city = city
        self.company = company
        self.country = country
        self.date = DateFormatter().date(from: date)
        self.flag = flag
        self.id = id
    }

    init(_ jsonData: JSON) {
        self.city = jsonData["city"].stringValue
        self.company = jsonData["company"].stringValue
        self.country = jsonData["country"].stringValue
        self.date = DateFormatter().date(from: jsonData["date"].stringValue)
        self.flag = jsonData["flag"].stringValue
        self.id = jsonData["id"].stringValue
    }
}
