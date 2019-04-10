//
//  DeviceInfo.swift
//  macOS Utilities
//
//  Created by Keaton Burleson on 4/10/19.
//  Copyright © 2019 Keaton Burleson. All rights reserved.
//

import Foundation
import AppKit
import SwiftyJSON

struct DeviceInfo {
    var anonymised: String
    var configurationCode: DeviceConfigurationCode
    var coverageURL: URL?
    var id: String
    var manufacturing: DeviceManufacturingInfo
    var serialType: String
    var uniqueID: DeviceUniqueID

    init(_ jsonData: JSON) {
        self.anonymised = jsonData["anonymised"].stringValue
        self.configurationCode = DeviceConfigurationCode(jsonData["configurationCode"])

        if let coverageURL = jsonData["coverageUrl"].url {
            self.coverageURL = coverageURL
        }

        self.id = jsonData["id"].stringValue
        self.manufacturing = DeviceManufacturingInfo(jsonData["manufacturing"])
        self.serialType = jsonData["serialType"].stringValue
        self.uniqueID = DeviceUniqueID(jsonData["uniqueId"])
    }
}
