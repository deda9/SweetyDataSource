//
//  ViewController.swift
//  SweetyDataSource
//
//  Created by Bassem Qoulta on 11/14/18.
//  Copyright © 2018 Bassem Qoulta. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    var title: String = ""
    
}

class Model{
    var title: String = "sd"
}

class ViewController: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delegate = GenericDataSource<Model, Cell>(items: [])
        
        delegate.onConfigureCell = { cell, model, index in
            cell.title = model.title
        }
        
        delegate.onTableViewCellHeight = { _ in
            return 200
        }
        
        tableView.registerDelegate(with: delegate)
    }
}

