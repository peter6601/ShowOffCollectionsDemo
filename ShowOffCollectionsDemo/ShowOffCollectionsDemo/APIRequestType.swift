//
//  APIRequestType.swift
//  ShowOffCollectionsDemo
//
//  Created by DinDin on 2022/2/17.
//

import Foundation


enum APiRequestType {
    enum MethodType: String {
        case GET
        case POST
    }
    case assets(offet: Int, limit: Int)
}

extension APiRequestType {
    
    var baseURL: String {
        return  "https://api.opensea.io/api"
    }
    var url: String {
        return baseURL + path
    }
    
    var method: MethodType {
        switch self {
        case .assets:
            return .GET
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .assets:
            return nil
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .assets:
            return ["X-API-KEY": "5b294e9193d240e39eefc5e6e551ce83"]
        }
    }
    
    var path: String {
        switch self {
        case .assets(let offet,let limit):
            let urlString: String = QueryURL()
                .add(sub:"/v1/assets")
                .add(key: "offset", value: String(offet))
                .add(key: "limit", value:  String(limit))
                .add(key: "order_direction", value: "desc")
                .add(key: "owner", value: "0x960DE9907A2e2f5363646d48D7FB675Cd2892e91")
                .build()
            return urlString
        }
    }
}


class QueryURL{
    
    var queryList: [String] = []
    var domain: String
    var subDomain: String?
    var queryinfos: String?
    init(domain: String = "", sub: String? = nil) {
        self.domain = domain
        self.subDomain = sub
    }
    
    func add(sub: String) -> QueryURL {
        self.subDomain = sub
        return self
    }
    func add(key: String, value: String) -> QueryURL {
        queryList.append(key + "=" + value)
        return self
    }

    
    func getQueryStinrg() -> String {
      var queryStinrg =  queryList.joined(separator: "&")
        queryStinrg += (queryinfos ?? "" )
        guard !queryStinrg.isEmpty else { return queryStinrg }
        let _subDomain = subDomain ?? ""
        if _subDomain.contains("?") {
            queryStinrg = "&" + queryStinrg
        } else {
            queryStinrg = "?" + queryStinrg
        }
        return queryStinrg
    }
    
    func build() -> String {
        let _subDomain = subDomain ?? ""
        let urlString = domain + _subDomain + self.getQueryStinrg()
        guard let inUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return urlString
        }
        return inUrlString
    }
}
