//
//  ServiceModel.swift
//  Imago
//
//  Created by Dima Paliychuk on 8/23/17.
//  Copyright © 2017 StarGo. All rights reserved.
//

import Foundation


private let statusSuccess = "success"
private let statusError = "error"


class ServiceError: Error, Codable {//, JSONJoy {
    
    fileprivate var status: String?
    var message: String?
    var code: Int?
    
    init(message: String) {
        self.message = message
    }
    
    var isSuccess: Bool {
        let statusToCheck = status?.lowercased()
        return statusToCheck == "success"
            ||
            statusToCheck == "ok"
    }
}


extension ServiceError {
    
    class func responseNoErrorNoData() -> ServiceError {
        let message = "Server could not be reached"
        
        let serviceError = ServiceError(message: message)
        serviceError.status = statusError
        
        return serviceError
    }
    
    class func noMyUserId() -> ServiceError {
        let message = "No user id found"
        
        let serviceError = ServiceError(message: message)
        serviceError.status = statusError
        
        return serviceError
    }
    
    class func badRequest() -> ServiceError {
        let message = "Bad request."
        
        let serviceError = ServiceError(message: message)
        serviceError.status = statusError
        
        return serviceError
    }
}

