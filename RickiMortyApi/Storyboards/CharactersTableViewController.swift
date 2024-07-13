//
//  CharactersTableViewController.swift
//  RickiMortyApi
//
//  Created by Egor Ukolov on 12.07.2024.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Rick and Morty Characters"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        loadCharacters()
        
    }
    
    private func loadCharacters() {
        NetworkManager.shared.fetchCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                DispatchQueue.main.async {
                    self?.characters = characters
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                self?.showError(error)
            }
        }
    }
    
    private func showError(_ error: Error) {
        AlertManager.showAlert(on: self, title: "Error", message: error.localizedDescription)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return characters.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let character = characters[indexPath.row]
        cell.textLabel?.text = character.name
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPatch = tableView.indexPathForSelectedRow {
            guard let destinationVC = segue.destination as? CharacterDetailsViewController else { return }
            destinationVC.character = characters[indexPatch.row]
        }
    }
    
    
}
