//
//  ViewController.swift
//  Networking_10_CS_GO
//
//  Created by ThePsih13 on 15.01.2021.
//  Copyright © 2021 Vlad Lytvynets. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    //MARK: - Outlets
    @IBOutlet weak var pickWeaponButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var kilsLabel: UILabel!
    @IBOutlet weak var imageWeapon: UIImageView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var shotFired: UILabel!
    @IBOutlet weak var shotHit: UILabel!
    
    var networkManager = NetworkManager()
    
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
    
    //MARK: - TextField UserDefaults
    func saveTextField(){
        guard let text = UserDefaults.standard.string(forKey: textFieldKey) else { return }
        idTextField.text = text
    }
    
    
    //MARK:- Steam id TextField
    @IBAction func steamIDTextField(_ sender: UITextField) {
        guard sender.text != nil else { return }
        UserDefaults.standard.set(sender.text!, forKey: textFieldKey)
    }
    
    //MARK: - OK Button
    @IBAction func okButton(_ sender: UIButton) {
        idSteam = idTextField.text
        networkManager.getRequest(withSteamId: idSteam ?? "", forIndex: indexRow ){StatsCS in
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
