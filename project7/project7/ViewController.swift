//
//  ViewController.swift
//  project7
//
//  Created by Guillermo Alvarez on 13/10/22.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        guard let url = URL(string: urlString) else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        parse(json: data)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        guard let jsonPetitions = try? decoder.decode(Petitions.self, from: json) else { return }
        petitions = jsonPetitions.results
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
    
        return cell
    }
}

