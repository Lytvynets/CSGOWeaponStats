//
//  WeaponTableViewController.swift
//  CS GO Stats
//
//  Created by ThePsih13 on 24.03.2021.
//  Copyright © 2021 Vlad Lytvynets. All rights reserved.
//

import UIKit
var indexRow = 0
class WeaponTableViewController: UITableViewController {
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexRow = indexPath.row
        print(indexRow)
        dismiss(animated: true, completion: nil)
    }    
}
