//
//  DataRequest+JSONJoy.swift
//  SunsetAndSunrise
//
//  Created by Dima Paliychuk on 4/18/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import Alamofire


extension DataRequest {
    
    func responseCodable<T: Codable>(
        completionHandler: @escaping (Result<T>) -> Void)
        -> Self {
            
            return responseData { dataResponse in
                if let error = dataResponse.error {
                    
                    completionHandler(
                        Result.failure(error)
                    )
                    return
                    
                } else if let data = dataResponse.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let errorModel = try decoder.decode(
                            ServiceError.self,
                            from: data
                        )
                        if !errorModel.isSuccess {
                            completionHandler(
                                Result.failure(errorModel)
                            )
                            return
                        }
                        
                        let t = try decoder.decode(T.self, from: data)
                        
                        completionHandler(
                            Result.success(t)
                        )
                    } catch {
                        print("error trying to convert data to JSON")
                        print(error)
                        completionHandler(
                            Result.failure(error)
                        )
                    }
                } else {
                    completionHandler(
                        Result.failure(
                            ServiceError()
                        )
                    )
                }
            }
    }
}

