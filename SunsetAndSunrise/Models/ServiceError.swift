//
//  ServiceError.swift
//  SunsetAndSunrise
//
//  Created by Dima Paliychuk on 4/18/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//


import Foundation


class ServiceError: Error, Codable {
    
    fileprivate var status: String?
    
    // compiler generated
    private enum CodingKeys: String, CodingKey {
        case status = "status"
    }
    
    var isSuccess: Bool {
        let statusToCheck = status?.lowercased()
        return statusToCheck == "success"
            ||
            statusToCheck == "ok"
    }
}


