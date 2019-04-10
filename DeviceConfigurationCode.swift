//
//  DeviceConfigurationCode.swift
//  macOS Utilities
//
//  Created by Keaton Burleson on 4/10/19.
//  Copyright © 2019 Keaton Burleson. All rights reserved.
//

import Foundation
import AppKit
import SwiftyJSON

struct DeviceConfigurationCode {
    var code: String
    var image: NSImage?
    var skuHint: String

    init(code: String, imageURL: URL, skuHint: String) {
        self.code = code
        self.image = NSImage(contentsOf: imageURL)
        self.skuHint = skuHint
    }

    init(_ jsonData: JSON) {
        self.code = jsonData["code"].stringValue

        if let imageURL = jsonData["image"]["url"].url {
            self.image = NSImage(contentsOf: imageURL)!
        }

        self.skuHint = jsonData["skuHint"].stringValue
    }
}
