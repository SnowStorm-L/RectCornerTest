//
//  CornerTableViewController.swift
//  RectCornerTest
//
//  Created by L on 2017/7/31.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

class CornerTableViewController: UITableViewController {
    
    struct Identifier {
        static let cornerImageCell = "cornerImageTableViewCell"
        static let cornerViewCell = "cornerViewTableViewCell"
        static let cornerLabelCell = "cornerLabelTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 999
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let imageCell = tableView.dequeueReusableCell(withIdentifier: Identifier.cornerImageCell) as? CornerImageTableViewCell else { fatalError() }
        imageCell.makeCorner()
        return imageCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? CornerImageTableViewCell {
        
        }
    }
    
    deinit {
        print((#file.components(separatedBy: "/").last ?? "nil") + " " + #function)
    }
    
}
