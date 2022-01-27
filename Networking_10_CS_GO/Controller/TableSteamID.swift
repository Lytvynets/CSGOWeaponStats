//
//  TableSteamID.swift
//  CS GO Stats
//
//  Created by Vlad Lytvynets on 14.12.2021.
//  Copyright © 2021 Vlad Lytvynets. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class TableSteamID: UITableViewController {
    
    @IBOutlet weak var SteamtableView: UITableView!
    
    var closure: ((String) -> ())?
    var id: String = ""
    let realm = try! Realm()
    var modelSteamID: Results<ModelSteamID>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .darkGray
    }
    
    
    //MARK: - Realm
    func realmDeleteAllClassObjects() {
        do {
            let realm = try Realm()
            
            let objects = realm.objects(ModelSteamID.self)
            
            try! realm.write {
                realm.delete(objects)
            }
        } catch let error as NSError {
            print("error - \(error.localizedDescription)")
        }
    }
    
    
    func realmDelete(code: String) {
        do {
            let realm = try Realm()
            
            let object = realm.objects(ModelSteamID.self).filter("name = %@", code).first
            
            try! realm.write {
                if let obj = object {
                    realm.delete(obj)
                }
            }
        } catch let error as NSError {
            print("error - \(error.localizedDescription)")
        }
    }
    
    func realmResult() -> [ModelSteamID]{
        let models = realm.objects(ModelSteamID.self)
        return Array(models)
    }
    
    
    
    //MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmResult().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SteamIdCell
        let id = realmResult()[indexPath.row]
        cell.iD.text = id.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = realmResult()[indexPath.row]
        testId = id.name
        closure?("\(testId)")
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == UITableViewCell.EditingStyle.delete else { return }
        let id = realmResult()[indexPath.row]
        realmDelete(code: id.name)
        tableView.reloadData()
    }
}
