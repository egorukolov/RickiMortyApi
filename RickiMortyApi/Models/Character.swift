//
//  Character.swift
//  RickiMortyApi
//
//  Created by Egor Ukolov on 12.07.2024.
//

import Foundation

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
}

struct CharacterResponse: Decodable {
    let results: [Character]
}
