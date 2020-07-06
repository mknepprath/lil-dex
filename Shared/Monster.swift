//
//  Monster.swift
//  Monsters
//
//  Created by Barry Martin on 6/23/20.
//

import Foundation

struct Monster: Codable, Identifiable {
    var id = UUID()
    var name: String
    var pokedexNo: Int
    var isSpicy: Bool = false
    
    var imageName: String { return name }
    var thumbnailName: String { return name + "Thumb" }
}

let testData = [
    Monster(name: "Greninja", pokedexNo: 658, isSpicy: true),
    Monster(name: "Lucario", pokedexNo: 448, isSpicy: false),
    Monster(name: "Mimikyu", pokedexNo: 778, isSpicy: true),
    Monster(name: "Charizard", pokedexNo: 006, isSpicy: false),
    Monster(name: "Umbreon", pokedexNo: 197, isSpicy: false),
    Monster(name: "Sylveon", pokedexNo: 700, isSpicy: false),
    Monster(name: "Garchomp", pokedexNo: 445, isSpicy: false),
    Monster(name: "Rayquaza", pokedexNo: 384, isSpicy: false),
    Monster(name: "Gardevoir", pokedexNo: 282, isSpicy: false),
    Monster(name: "Gengar", pokedexNo: 094, isSpicy: true),
]
