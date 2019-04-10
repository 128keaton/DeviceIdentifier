//
//  DeviceUniqueID.swift
//  macOS Utilities
//
//  Created by Keaton Burleson on 4/10/19.
//  Copyright © 2019 Keaton Burleson. All rights reserved.
//

import Foundation
import AppKit
import SwiftyJSON

struct DeviceUniqueID {
    var productionNumber: Int?
    var value: String

    init(productionNumber: Int, value: String) {
        self.productionNumber = productionNumber
        self.value = value
    }

    init(_ jsonData: JSON) {
        if let productionNumber = jsonData["value"].int {
            self.productionNumber = productionNumber
        }

        self.value = jsonData["value"].stringValue
    }
}
