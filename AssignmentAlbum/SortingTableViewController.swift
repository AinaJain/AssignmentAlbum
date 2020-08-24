//
//  SortingTableViewController.swift
//  AssignmentAlbum
//
//  Created by Aina Jain on 24/08/20.
//  Copyright © 2020 Aina Jain. All rights reserved.
//

import UIKit

class SortingTableViewController: UITableViewController {
    
    let sortingArray = SortingTypes.allCases.map({"\($0)"})
    let cellReuseIdentifier = "SortCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortingArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) ?? UITableViewCell()
        cell.textLabel?.text = sortingArray[indexPath.row]
        return cell
    }

}
