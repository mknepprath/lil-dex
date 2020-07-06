//  PokemonStore.swift

import Foundation

// PokéAPI
let apiURL = "https://pokeapi.co/api/v2/pokemon"

class PokemonStore: ObservableObject {
    @Published var pokemon: [Monster]
    
    init(pokemon: [Monster] = []) {
        self.pokemon = pokemon
    }
}

let testStore = PokemonStore(pokemon: testData)
