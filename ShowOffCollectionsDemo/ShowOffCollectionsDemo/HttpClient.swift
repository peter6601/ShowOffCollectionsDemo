//
//  HttpClient.swift
//  ShowOffCollectionsDemo
//
//  Created by DinDin on 2022/2/17.
//

import Foundation
import Alamofire


protocol HttpClientProtocol {
    typealias CompletionDataResult<T: Decodable> = ((Swift.Result<T, Error>)-> Void)
    func request<T: Decodable>(url: String, requstMethod: String, parameters: [String: Any]?, headers: [String: String]?, completion: @escaping CompletionDataResult<T>)
}

class HttpClient: HttpClientProtocol {
    
    enum ErrorType: Error {
        case parsingFail
    }
    func request<T>(url: String, requstMethod: String, parameters: [String : Any]?, headers: [String : String]?, completion: @escaping CompletionDataResult<T>) where T : Decodable {
        let method = HTTPMethod.init(rawValue: requstMethod)
        let _headers: HTTPHeaders? = headers != nil ?  HTTPHeaders.init(headers!) : nil

    AF.request(url,method: method, headers: _headers)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success(let data):
                guard let resultData = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(ErrorType.parsingFail))
                    return
                }
                completion(.success(resultData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
  

}
