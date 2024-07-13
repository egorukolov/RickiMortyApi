//
//  ViewController.swift
//  RickiMortyApi
//
//  Created by Egor Ukolov on 12.07.2024.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    
    // MARK: -  Public Properties
    
    var character: Character?
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeLabel.numberOfLines = 2
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        uploadUI()
    }
    
    // MARK: - Private Methods

    private func uploadUI() {
        
        guard let character = character else {
            showError(NSError(domain: "Invalid character data", code: 0, userInfo: nil))
            return
        }
        
        idLabel.text = "ID: \(String(character.id))"
        nameLabel.text = "Name: \(character.name)"
        statusLabel.text = "Status: \(character.status)"
        speciesLabel.text = "Species: \(character.species)"
        typeLabel.text = "Type: \(character.type.isEmpty ? "Unknown" : character.type)"
        genderLabel.text = "Gender: \(character.gender )"
        
        NetworkManager.shared.fetchImage(urlString: character.image) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: image)
                        self.activityIndicator.stopAnimating()
                    }
                case .failure(let error):
                    self.showError(error)
                }
            }
        }
    }
    
    private func showError(_ error: Error) {
        AlertManager.showAlert(on: self, title: "Error", message: error.localizedDescription)
    }
}
