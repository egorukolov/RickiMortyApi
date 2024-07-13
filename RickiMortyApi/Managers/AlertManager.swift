//
//  AlertManager.swift
//  RickiMortyApi
//
//  Created by Egor Ukolov on 13.07.2024.
//

import UIKit

class AlertManager {
    
    static func showAlert(on viewController: UIViewController, title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
