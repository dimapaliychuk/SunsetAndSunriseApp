//
//  BaseService.swift
//  Imago
//
//  Created by Dima Paliychuk on 8/23/17.
//  Copyright © 2017 StarGo. All rights reserved.
//

import Alamofire


class BaseService {
    
    fileprivate static var manager: Alamofire.SessionManager = {
        return Alamofire.SessionManager.default
    }()
    
    fileprivate func url(path: String) -> String {
        return Constants.API.baseURL + path
    }
    
    var token: String? {
        return User.restoreAuthToken()
    }
    
    var headers: HTTPHeaders {
        if let token = self.token {
            return [
                JSONKeys.authorization : token
            ]
        }
        return [:]
    }
    
    func executeRequest<T: Codable>(
        path: String = "",
        method: HTTPMethod = .get,
        encoding: ParameterEncoding = JSONEncoding.default,
        parameters: Parameters?,
        headers: HTTPHeaders? = nil,
        completionHandler: @escaping (_ result: Result<T>) -> Void
        ) {
        
        let urlString = url(path: path)
        
        let httpHeaders: HTTPHeaders = {
            if let h = headers {
                return self.headers.dictionary(with: h)
            }
            return self.headers
        }()
        
        executeRequest(
            urlString: urlString,
            method: method,
            encoding: encoding,
            parameters: parameters,
            headers: httpHeaders,
            completionHandler: completionHandler
        )
    }
    
    func executeRequest<T: Codable>(
        urlString: String,
        method: HTTPMethod = .get,
        encoding: ParameterEncoding = JSONEncoding.default,
        parameters: Parameters?,
        headers: HTTPHeaders? = nil,
        completionHandler: @escaping (_ result: Result<T>) -> Void
        ) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        var jsonDataResponse: DataResponse<Any>?
        
        _ = BaseService.manager.request(
            urlString,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
            ).responseJSON(completionHandler: { dataResponse in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                jsonDataResponse = dataResponse
            }).responseCodable { (result: Result<T>) in
                
                self.logRequest(
                    urlString: urlString,
                    method: method,
                    headers: headers,
                    parameters: parameters,
                    error: result.error,
                    dataResponse: jsonDataResponse
                )
                
            completionHandler(result)
        }
    }
    
    func executeMultipartRequest<T: Codable>(
        path: String,
        multipartFormData: @escaping (MultipartFormData)->Void,
        uploadHandler: ((_ progress: Double)->Void)?,
        completionHandler: @escaping (_ result: Result<T>) -> Void) {
        
        let urlString = url(path: path)
        guard let url = URL(string: urlString),
            let token = User.restoreAuthToken() else {
                completionHandler(Result.failure(ServiceError.badRequest()))
                return
        }
        
        var request = URLRequest(url: url)
        let method = HTTPMethod.patch
        request.httpMethod = method.rawValue
        request.addValue(token, forHTTPHeaderField: JSONKeys.authorization)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        var jsonDataResponse: DataResponse<Any>?
        
        BaseService.manager.upload(
            multipartFormData: multipartFormData,
            with: request) { result in
                switch result {
                case let .success(upload, _, _):
                    _ = upload.uploadProgress(
                        closure: { (progress) in
                            print("multipart progress: \(progress.fractionCompleted)")
                            uploadHandler?(progress.fractionCompleted)
                    }).responseJSON(
                        completionHandler: { dataResponse in
                            
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            
                            jsonDataResponse = dataResponse
                    }).responseCodable { (result: Result<T>) in
                        
                        self.logRequest(
                            urlString: urlString,
                            method: method,
                            headers: request.allHTTPHeaderFields,
                            parameters: [:],
                            error: result.error,
                            dataResponse: jsonDataResponse
                        )
                        
                        completionHandler(result)
                }
            case let .failure(error):
                completionHandler(Result.failure(error))
            }
        }
    }
    
    private func logRequest(urlString: String, method: HTTPMethod, headers: HTTPHeaders?, parameters: Parameters?, error: Error?, dataResponse: DataResponse<Any>?) {
        
        print(
            "\n====================================" +
                "\nrequest: url: \(urlString)" +
                "\nmethod: \(method)" +
                "\nheaders: \(String(describing: headers))" +
                "\nparameters: \(String(describing: parameters))" +
                "\n---------------------------------" +
                "\ncode: \(String(describing: dataResponse?.response?.statusCode))" +
                "\nerror: \(String(describing: error))" +
                //                "\nerrorDescription: \(error ?? "")" +
                "\nresponse: \(String(describing: dataResponse?.result.value))" +
            "\n====================================\n"
        )
    }
}

