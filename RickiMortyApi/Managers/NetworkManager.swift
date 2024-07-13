//
//  NetworkManager.swift
//  RickiMortyApi
//
//  Created by Egor Ukolov on 12.07.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let characterListUrl = "https://rickandmortyapi.com/api/character"
    
    func fetchCharacters (completion: @escaping (Result<[Character], Error>) -> Void) {
        
        AF.request(characterListUrl)
            .validate()
            .responseData { response in
            
            switch response.result {
            case .success(let data):
                do {
                    let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                    completion(.success(characterResponse.results))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchImage (urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return }
        
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
