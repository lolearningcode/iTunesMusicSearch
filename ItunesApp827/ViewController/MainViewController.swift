//
//  ViewController.swift
//  ItunesApp827
//
//  Created by mac on 9/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var mainListContainer: UIView!
    @IBOutlet weak var mainGridContainer: UIView!
    
    let searchController = UISearchController(searchResultsController: nil)
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupMain()
    }

    @IBAction func switchButtonTapped(_ sender: UIBarButtonItem) {
        mainListContainer.isHidden.toggle()
        mainGridContainer.isHidden.toggle()
    }
    
    private func setupMain() {
        viewModel.get(search: "lil+wayne")
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Itunes Albums.."
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
}

//UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        viewModel.get(search: searchText)
        
        navigationItem.searchController?.isActive = false
        
    }
    
}
