//
//  SearchViewController.swift
//  CodingTest
//
//  Created by Prakash on 17/09/18.
//  Copyright © 2018 Prakash. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    var viewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchResultsTableView.delegate = viewModel
        self.searchResultsTableView.dataSource = viewModel
        self.searchBar.delegate = viewModel
        self.viewModel.tableView = searchResultsTableView

        searchResultsTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        self.searchBar.showsCancelButton = true
        // Do any additional setup after loading the view.
    }

  
    
}
