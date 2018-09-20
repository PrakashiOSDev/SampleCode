//
//  SearchViewModel.swift
//  CodingTest
//
//  Created by Prakash on 17/09/18.
//  Copyright © 2018 Prakash. All rights reserved.
//

import Foundation
import UIKit

class SearchViewModel:NSObject {
    var tableView : UITableView?
    var data:SearchResults?
    var titleArray = [String]()
    var imageUrlArray = [String]()
    var searchString = ""
    var descriptionArray = [String]()
     func searchResults(searchString:String){
        self.searchString = searchString
        self.clearData()
        ActivityIndicator.startLoader("")
        APIClient.search(name:searchString){ (result) in
            ActivityIndicator.stopLoader()
           switch result {
            case .success(let succ):
                if succ.query != nil{
                    self.data = succ
                    let pages = self.data?.query?.pages
                    for item in pages! {
                        let title = item.title ?? ""
                        self.titleArray.append(title)
                        let descriptions = item.terms?.description ?? [""]
                        self.descriptionArray.append(contentsOf: descriptions)
                        let imageUrl = item.thumbnail?.source ?? ""
                        self.imageUrlArray.append(imageUrl)
                    }
                }
                self.tableView?.reloadData()
            case .failure(let error):
                ActivityIndicator.stopLoader()
               print(error)
            }
            }
        }
    
    func clearData(){
        self.titleArray.removeAll()
        self.descriptionArray.removeAll()
        self.imageUrlArray.removeAll()
    }
}


extension SearchViewModel: UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data != nil ? (data?.query?.pages?.count)! : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as!
        SearchTableViewCell
        let url = URL(string: imageUrlArray[indexPath.row])
        if let urlData = url{
            let data = try? Data(contentsOf: urlData)
            let image = UIImage(data: data!)
            cell.userImage.image = image
        }else{
            cell.userImage.image = UIImage(named: "imagePlaceholder")
        }
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.descriptionLabel.text  = descriptionArray[indexPath.row]
        return cell
    }
}

extension SearchViewModel:UISearchBarDelegate,UISearchDisplayDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchResults(searchString: searchBar.text!)
        searchBar.resignFirstResponder()
    }
    
    
}
