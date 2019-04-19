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

class DeviceConfigurationCode {
    var code: String
    var image: NSImage?
    var imageURL: URL?
    var skuHint: String

    init(code: String, imageURL: URL, skuHint: String) {
        self.imageURL = imageURL
        self.code = code
        self.skuHint = skuHint
        self.getImage()
    }

    func getImage() {
        if let imageURL = self.imageURL {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                guard let data = data, error == nil else { return }
                if let newImage = NSImage(data: data){
                    self.image = newImage
                }
            }.resume()
        }
    }

    init(_ jsonData: JSON) {
        self.code = jsonData["code"].stringValue

        if let imageURL = jsonData["image"]["url"].url {
            self.imageURL = imageURL
        }

        self.skuHint = jsonData["skuHint"].stringValue
        self.getImage()
    }
}
