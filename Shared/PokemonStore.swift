//  PokemonStore.swift

import Foundation

class PokemonStore: ObservableObject {
    @Published var pokemon: [Monster]
    
    init(pokemon: [Monster] = []) {
        self.pokemon = pokemon
    }
}

let testStore = PokemonStore(pokemon: testData)
