//
//  APIService.swift
//  ShowOffCollectionsDemo
//
//  Created by DinDin on 2022/2/17.
//

import Foundation


class APIService {
    
    static let shared: APIService = APIService()
    
    typealias CompletionDataResult<T: Decodable> = ((Swift.Result<T, Error>)-> Void)
    
    private(set) var httpClient: HttpClientProtocol
    init(httpClient: HttpClientProtocol = HttpClient()) {
        self.httpClient = httpClient
    }
    func request<T>(target: APiRequestType, completion: @escaping CompletionDataResult<T>) where T : Decodable {
        self.httpClient.request(url: target.url, requstMethod: target.method.rawValue, parameters: target.parameters, headers: target.header, completion: completion)
    }
}
