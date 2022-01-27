//
//  ModelSteamID.swift
//  CS GO Stats
//
//  Created by Vlad Lytvynets on 15.12.2021.
//  Copyright © 2021 Vlad Lytvynets. All rights reserved.
//

import Foundation
import RealmSwift

class ModelSteamID: Object {
   @objc dynamic var name = ""
    
    convenience init(name: String){
        self.init()
        self.name = name
    }
}
