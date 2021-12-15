//
//  TableSteamID.swift
//  CS GO Stats
//
//  Created by Vlad Lytvynets on 14.12.2021.
//  Copyright © 2021 Vlad Lytvynets. All rights reserved.
//

import Foundation
import UIKit

class TableSteamID: UITableViewController {
    
    var vc = ViewController()
    
    @IBOutlet weak var SteamtableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SteamIdCell
        //let id = vc.idArray[indexPath.row]
        cell.iD.text = vc.idArray.first
        return cell
    }
    
    
}
