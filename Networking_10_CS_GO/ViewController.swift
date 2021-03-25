//
//  ViewController.swift
//  Networking_10_CS_GO
//
//  Created by ThePsih13 on 15.01.2021.
//  Copyright © 2021 Vlad Lytvynets. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var idSteam: String?
    var textId: String?
    
    @IBOutlet weak var pickWeaponButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var kilsLabel: UILabel!
    @IBOutlet weak var imageWeapon: UIImageView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var shotFired: UILabel!
    @IBOutlet weak var shotHit: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.idTextField.delegate = self
        self.pickWeaponButton.layer.cornerRadius = 10
        self.okButton.layer.cornerRadius = 10
        saveTextField()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func saveTextField(){
        guard let text = UserDefaults.standard.string(forKey: "Text") else { return }
        idTextField.text = text
    }
    
    func getRequst(withSteamId steamId: String, forIndex index: Int, complitionHandler:@escaping (StatsCS) -> Void){
        let urlString = "https://public-api.tracker.gg/v2/csgo/standard/profile/steam/\(steamId)/segments/weapon/?TRN-Api-Key=a216fc00-32ca-4827-ad36-2725ca0831da"
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
    
    
    @IBAction func steamIDTextField(_ sender: UITextField) {
        guard sender.text != nil else { return }
        UserDefaults.standard.set(sender.text!, forKey: "Text")
    }
    
    
    @IBAction func Button(_ sender: UIButton) {
        idSteam = idTextField.text
        getRequst(withSteamId: idSteam ?? "", forIndex: indexRow ){StatsCS in
            let image = StatsCS.imageURL
            guard let imageUrl = URL(string: image) else { return }
            let urrlSession = URLSession.shared
            urrlSession.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data, let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.imageWeapon.image = image
                    }
                }
            }.resume()
            
            DispatchQueue.main.async {
                self.nameLabel.text = StatsCS.name
                self.kilsLabel.text = String(StatsCS.value)
                self.imageWeapon.image = UIImage(contentsOfFile: image)
                self.shotFired.text = String(StatsCS.shotsFired)
                self.shotHit.text = String(StatsCS.shotsHit)
            }
        }
    }
}
