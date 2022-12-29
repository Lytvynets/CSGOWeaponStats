//
//  NetworkManager.swift
//  CS GO Stats
//
//  Created by Vlad Lytvynets on 08.11.2021.
//  Copyright © 2021 Vlad Lytvynets. All rights reserved.
//

import Foundation

class NetworkManager {
    func getRequest(withSteamId steamId: String, forIndex index: Int, complitionHandler:@escaping (StatsCS) -> Void){
        let urlString = "https://public-api.tracker.gg/v2/csgo/standard/profile/steam/\(steamId)/segments/weapon/?TRN-Api-Key=youAPIKey"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            if let data = data{
                if let statsCS = self.parseJson(forIndex: index, withData: data){
                    complitionHandler(statsCS)
                }
            }
        }.resume()
    }
    
    
    func parseJson(forIndex index: Int,  withData data: Data) -> StatsCS? {
        let decoder = JSONDecoder()
        do {
            let statsCSData = try decoder.decode(ModelCS.self, from: data)
            guard let statsCS = StatsCS(CSGOStats: statsCSData, index: index) else { return nil }
            return statsCS
        } catch {
            print(error)
        }
        return nil
    }
}
