//
//  ViewController.swift
//  Networking_10_CS_GO
//
//  Created by ThePsih13 on 15.01.2021.
//  Copyright © 2021 Vlad Lytvynets. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate{
    
    //MARK: - Outlets
    @IBOutlet weak var pickWeaponButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var kilsLabel: UILabel!
    @IBOutlet weak var imageWeapon: UIImageView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var shotFired: UILabel!
    @IBOutlet weak var shotHit: UILabel!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var settingsButton: UIButton!
    
    
    weak var tableID: TableSteamID?
    var networkManager = NetworkManager()
    var player = ModelSteamID(name: "")
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.idTextField.delegate = self
        self.pickWeaponButton.layer.cornerRadius = 10
        self.okButton.layer.cornerRadius = 10
        self.settingsView.isHidden = true
        saveTextField()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TableSteamID else { return }
        destination.closure = { [weak self] textID in
            self?.idTextField.text = textID
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    //MARK: - Save steam ID through realm
    func saveId(id: AnyObject){
        let realm = try! Realm()
        try! realm.write{
            realm.add(id as! Object)
        }
    }
    
    func obs() -> [ModelSteamID]{
        let models = realm.objects(ModelSteamID.self)
        return Array(models)
    }
    
    //MARK: - Add steam ID button
    @IBAction func addSteamIDButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Steam ID", message: nil, preferredStyle: .alert)
        let addSteamID = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let textField = alert.textFields?.first else { return }
            self.player.name = "\(textField.text ?? "")"
            self.tableID?.modelSteamID = self.realm.objects(ModelSteamID.self)
            self.saveId(id: self.player)
            print("Text field: \(textField.text ?? "")")
        }
        alert.addAction(addSteamID)
        alert.addTextField(configurationHandler: nil)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Settings Buttons
    @IBAction func closeSettings(_ sender: UIButton) {
        self.settingsView.isHidden = true
        self.settingsButton.isHidden = false
    }
    
    @IBAction func settingsButtonAction(_ sender: UIButton) {
        self.settingsView.isHidden = false
        self.settingsButton.isHidden = true
    }
    
    @IBAction func pickSteamID(_ sender: UIButton) {
    }
    
    //MARK: - TextField UserDefaults DONT WORKING!
    func saveTextField(){
        guard let text = UserDefaults.standard.string(forKey: textFieldKey) else { return }
        idTextField.text = text
    }
    
    //MARK: - Steam id TextField
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
