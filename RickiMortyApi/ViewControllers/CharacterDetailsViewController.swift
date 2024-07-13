//
//  ViewController.swift
//  RickiMortyApi
//
//  Created by Egor Ukolov on 12.07.2024.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeLabel.numberOfLines = 2
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        uploadUI()
    }

    func uploadUI() {
        
        idLabel.text = "ID: \(String(character!.id))"
        nameLabel.text = "Name: \(character?.name ?? "nill")"
        statusLabel.text = "Status: \(character?.status ?? "nill")"
        speciesLabel.text = "Species: \(character?.species ?? "nill")"
        typeLabel.text = "Type: \(character?.type ?? "nill")"
        genderLabel.text = "Gender: \(character?.gender ?? "nill")"
        
        NetworkManager.shared.fetchImage(urlString: character?.image ?? "nill") { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: image)
                    self.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                break
            }
        }
    }
}

