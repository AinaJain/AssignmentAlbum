//
//  ViewController.swift
//  AssignmentAlbum
//
//  Created by Aina Jain on 24/08/20.
//  Copyright © 2020 Aina Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var albumTableView: UITableView!
    var viewModel = AlbumViewModel()
    var searchController: UISearchController?
    
    var isSearchBarEmpty: Bool {
      return searchController?.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
        return searchController?.isActive ?? false && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(didTapSortButton))
        addSearchController()
        albumTableView.estimatedRowHeight = UITableView.automaticDimension
        viewModel.getData {
            albumTableView.reloadData()
        }
    }
    
    @objc func didTapSortButton() {
        let sortingVC = SortingTableViewController()
        sortingVC.onUpdateCompletion = { [weak self] sorter in
            self?.viewModel.updateTableOrder(with: sorter)
            self?.albumTableView.reloadData()
        }
        sortingVC.modalPresentationStyle = .formSheet
        self.present(sortingVC, animated: true, completion: nil)
    }
    
    func addSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

extension ViewController {
        
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.filterContentForSearchText(text, completion: {
            albumTableView.reloadData()
        })
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering == true {
            return viewModel.filteredAlbums.count
        }
        return viewModel.albums?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? AlbumListCell,
            let album = viewModel.getDatasourceArray(isFilterOn: isFiltering)?[indexPath.row] {
            cell.artistName.text = album.artistName
            cell.collectionName.text = album.collectionName
            cell.trackName.text = album.trackName
            cell.releaseDate.text = album.releaseDate
            cell.collectionPrice.text = "$ \(album.collectionPrice)"
            if let url = URL(string: album.artworkUrl100) {
                URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                    if let data = data {
                        DispatchQueue.main.async { [weak cell] in
                            cell?.albumImageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
            return cell
        }
        return UITableViewCell()
    }

}
//
//extension Date
//{
//    func toString( dateFormat format  : String ) -> String
//    {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        return dateFormatter.string(from: self)
//    }
//}
