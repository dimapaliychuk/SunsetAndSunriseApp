//
//  API.swift
//  SunsetAndSunrise
//
//  Created by Dima Paliychuk on 4/18/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//


import Foundation
import Alamofire
import CoreLocation


class API: BaseService {
    
    static let shared = API()
    
    func getDescriptionFor(coordinate: CLLocationCoordinate2D,
                        completion: @escaping (_ result: Result<InfoResponseModel>)->Void) {
        executeRequest(
            method: .get,
            encoding: URLEncoding.default,
            parameters: [
                JSONKeys.lat : Double(coordinate.latitude),
                JSONKeys.lng : Double(coordinate.longitude)
            ],
            completionHandler: completion
        )
    }
}
