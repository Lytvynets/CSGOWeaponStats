//
//  ModelCS.swift
//  Networking_10_CS_GO
//
//  Created by ThePsih13 on 16.01.2021.
//  Copyright © 2021 Vlad Lytvynets. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let modelCS = try? newJSONDecoder().decode(ModelCS.self, from: jsonData)

import Foundation

// MARK: - ModelCS
struct ModelCS: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let type: TypeEnum
    let attributes: Attributes
    let metadata: DatumMetadata
   // let expiryDate: ExpiryDate
    let stats: Stats
}

// MARK: - Attributes
struct Attributes: Codable {
    let key: String
}

//enum ExpiryDate: String, Codable {
//    case the20210116T01221783576790000 = "2021-01-16T01:22:17.8357679+00:00"
//}

// MARK: - DatumMetadata
struct DatumMetadata: Codable {
    let name: String
    let imageURL: String
    let category: CategoryClass

    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "imageUrl"
        case category
    }
}

// MARK: - CategoryClass
struct CategoryClass: Codable {
    let value: Value
    let displayValue: DisplayValue
}

enum DisplayValue: String, Codable {
    case gear = "Gear"
    case heavy = "Heavy"
    case pistol = "Pistol"
    case rifle = "Rifle"
    case smg = "SMG"
}

enum Value: String, Codable {
    case gear = "gear"
    case heavy = "heavy"
    case pistol = "pistol"
    case rifle = "rifle"
    case smg = "smg"
}

// MARK: - Stats
struct Stats: Codable {
    let kills, shotsFired, shotsHit, shotsAccuracy: Kills
}

// MARK: - Kills
struct Kills: Codable {
    let rank, percentile: JSONNull?
    let displayName: DisplayName
    let displayCategory: DisplayCategory
    let category: CategoryEnum
    let metadata: KillsMetadata
    let value: Double
    let displayValue: String
    let displayType: DisplayType
}

enum CategoryEnum: String, Codable {
    case combat = "combat"
}

enum DisplayCategory: String, Codable {
    case combat = "Combat"
}

enum DisplayName: String, Codable {
    case kills = "Kills"
    case shotsAccuracy = "Shots Accuracy"
    case shotsFired = "Shots Fired"
    case shotsHit = "Shots Hit"
}

enum DisplayType: String, Codable {
    case number = "Number"
    case numberPrecision2 = "NumberPrecision2"
}

// MARK: - KillsMetadata
struct KillsMetadata: Codable {
}

enum TypeEnum: String, Codable {
    case weapon = "weapon"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
