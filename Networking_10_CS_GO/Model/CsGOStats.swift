//
//  CsGOStats.swift
//  Networking_10_CS_GO
//
//  Created by ThePsih13 on 16.01.2021.
//  Copyright © 2021 Vlad Lytvynets. All rights reserved.
//

import Foundation

class StatsCS: Codable{
    let name: String
    let key: String
    let imageURL: String
    let value: Int
    let shotsFired: Int
    let shotsHit: Int
    
    var index: Int
    
    init?(CSGOStats: ModelCS, index: Int){
        name = CSGOStats.data[index].metadata.name as String
        key = CSGOStats.data[index].attributes.key
        imageURL = CSGOStats.data[index].metadata.imageURL
        value = Int(CSGOStats.data[index].stats.kills.value)
        shotsFired = Int(CSGOStats.data[index].stats.shotsFired.value)
        shotsHit = Int(CSGOStats.data[index].stats.shotsHit.value)
        self.index = index
    }
}
