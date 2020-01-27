//
//  ViewController.swift
//  JSONFromItunes
//
//  Created by Никита Кузнецов on 17/10/2019.
//  Copyright © 2019 bykuznetsov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let networkService = NetworkService()
    var modelJSON: Model? = nil
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
    }

    @IBOutlet weak var table: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    private func setupSearchBar(){
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupTableView(){
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelJSON?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let track = modelJSON?.results[indexPath.row]
        cell.textLabel?.text = track?.trackName
        return cell
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            let urlString = "https://itunes.apple.com/search?term=\(searchText)&limit=25"
            self.networkService.request(urlString: urlString) { [weak self] (result) in
                switch result{
                case .success(let model):
                    self?.modelJSON = model
                    self?.table.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}
