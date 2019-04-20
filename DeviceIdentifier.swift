//
//  DeviceIdentifier.swift
//  macOS Utilities
//
//  Created by Keaton Burleson on 4/10/19.
//  Copyright © 2019 Keaton Burleson. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON

class DeviceIdentifier {
    static let shared = DeviceIdentifier()
    static let didSetupNotification: Notification.Name = Notification.Name(rawValue: "DeviceIdentifierReady")

    private class Config {
        var authenticationToken: String?
    }

    private static let config = Config()
    private var cachedDeviceInformation = [String: JSON]()

    static func setup(authenticationToken: String) {
        DeviceIdentifier.config.authenticationToken = authenticationToken
        NotificationCenter.default.post(name: didSetupNotification, object: nil)
    }
    
    static var isConfigured: Bool {
        return self.config.authenticationToken != nil
    }

    private init() {
        if DeviceIdentifier.config.authenticationToken == nil {
            fatalError("Error - you must call setup before accessing DeviceIdentifier.shared")
        }

    }
    
    public func getCachedDeviceFor(serialNumber: String) -> DeviceInfo? {
        if(cachedDeviceInformation.keys.contains(serialNumber)){
            return DeviceInfo(cachedDeviceInformation[serialNumber]!)
        }
        return nil
    }

    private func getHeaders() -> HTTPHeaders {
        if let authenticationToken = DeviceIdentifier.config.authenticationToken {
            return ["Authorization": "Token \(authenticationToken)"]
        }

        return [:]
    }

    public func lookupAppleSerial(_ serialNumber: String, completion: @escaping (DeviceInfo) -> ()) {
        if(cachedDeviceInformation.keys.contains(serialNumber)) {
            completion(DeviceInfo(cachedDeviceInformation[serialNumber]!))
            return
        }

        let url = "https://di-api.reincubate.com/v1/\(QueryIdentifier.appleSerialNumber.rawValue)/\(serialNumber)/" as URLConvertible

        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: getHeaders()).responseSwiftyJSON { (dataResponse) in
            if let jsonData = dataResponse.value {
                let newDeviceInfo = DeviceInfo(jsonData)

                self.cachedDeviceInformation[serialNumber] = jsonData
                completion(newDeviceInfo)
            }
        }
    }

    enum QueryIdentifier: String {
        case appleSerialNumber = "apple-serials"
    }
}

/*
 TYPE_APPLE_ANUMBER = 'apple-anumbers'
 TYPE_APPLE_IDENTIFIER = 'apple-identifiers'
 TYPE_APPLE_IDFA = 'apple-idfas'
 TYPE_APPLE_INTERNAL_NAME = 'apple-internal-names'
 TYPE_APPLE_MODEL = 'apple-models'
 TYPE_APPLE_SERIAL = 'apple-serials'
 TYPE_APPLE_UDID = 'apple-udids'
 TYPE_CDMA_MEID = 'cdma-meids'
 TYPE_GSMA_ICCID = 'gsma-iccids'
 TYPE_GSMA_IMEI = 'gsma-imeis'
 TYPE_GSMA_TAC = 'gsma-tacs'
 */

