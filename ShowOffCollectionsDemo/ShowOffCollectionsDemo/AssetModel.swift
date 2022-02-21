//
//  AssetModel.swift
//  ShowOffCollectionsDemo
//
//  Created by DinDin on 2022/2/14.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct AssetsRoot: Codable {
    let assets: [AssetElement]
}

// MARK: - AssetElement
struct AssetElement: Codable {
    let imageURL: String
    let name, assetDescription: String
    let permalink: String
    let collection: Collection
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case assetDescription = "description"
        case name, permalink, collection
    }
}



// MARK: - Collection
struct Collection: Codable {
    let name: String
}

