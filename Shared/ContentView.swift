//
//  ContentView.swift
//  Shared
//
//  Created by Michael Knepprath on 7/2/20.
//

// TODO:
// - Add search
// - Swipe to mark as caught
// - Swipe to unmark
// - Display store Pokémon, API response for search only
// - Scrape Pokémon Go data to cross-reference

import SwiftUI

// PokéAPI
let apiURL = "https://pokeapi.co/api/v2/pokemon?limit=1200"

struct Entry: Codable {
    var name: String
    var url: String
    
//    var imageName: String { return name }
//    var thumbnailName: String { return name + "Thumb" }
}
extension Entry: Identifiable {
    var id: Int { return Int(url.dropLast().replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: ""))! }
}

struct EntryList: Codable {
    var results: [Entry]
}

let testEntries = [
    Entry(name: "Greninja", url: "658/"),
    Entry(name: "Lucario", url: "448/"),
    Entry(name: "Mimikyu", url: "778/"),
]
let testPokedex = Pokedex(pokemon: testEntries)

class Pokedex: ObservableObject {
    @Published var pokemon: [Entry]
    
    init(pokemon: [Entry] = []) {
        self.pokemon = pokemon
    }
}

struct ContentView: View {
    @ObservedObject var store: PokemonStore
    @ObservedObject var pokedex = Pokedex()
    @State var loading = true
        
    var body: some View {
        NavigationView {
            List {
                ForEach(pokedex.pokemon) { mon in
                    PokemonCell(pokemon: mon)
                }
                .onMove(perform: movePokemon)
                .onDelete(perform: deletePokemon)
                
                HStack {
                    Spacer()
                    Text("\(pokedex.pokemon.count) Pokémon")
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .navigationTitle("Pokémon")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    #if os(iOS)
                    EditButton()
                    #endif
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Add", action: makePokemon)
                }
            }
            
            
            Text("Select a Pokémon")
                .font(.largeTitle)
        }
        .onAppear(perform:
            loadPokemon
        )
    }
    
    func makePokemon() {
        withAnimation {
            pokedex.pokemon.append(Entry(name: "Chikorita", url: "152/"))
        }
    }
    
    func movePokemon(from: IndexSet, to: Int) {
        withAnimation {
            store.pokemon.move(fromOffsets: from, toOffset: to)
        }
    }
    
    func deletePokemon(offsets: IndexSet) {
        withAnimation {
            store.pokemon.remove(atOffsets: offsets)
        }
    }
    
    func loadPokemon() {
        // create the API url
        let request = URLRequest(url: URL(string: apiURL)!)
        
        // initiate the API request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                // decode the response into our Pokemon struct
                if let decodedResponse = try? JSONDecoder().decode(EntryList.self, from: data) {
                        DispatchQueue.main.async {
                            // set the Pokemon based on the API response
                            self.pokedex.pokemon = decodedResponse.results
                            // we're no longer "loading"
                            self.loading = false
                        }
                    
                        return
                } else {
                    print("No decodedResponse")
                }
            } else {
                print("No data")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(store: testStore, pokedex: testPokedex)
//            ContentView(store: testStore)
//                .environment(\.sizeCategory, .extraExtraExtraLarge)
//            ContentView(store: testStore)
//                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
//            ContentView(store: testStore)
//                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
//                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}

struct PokemonCell: View {
    var pokemon: Entry
    var body: some View {
        NavigationLink(destination: PokemonDetail(pokemon: pokemon, details: testDetails)) {
//            Image(pokemon.thumbnailName).resizable().scaledToFit()
//                .frame(width: 48.0, height: 48.0)
//                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(pokemon.name.capitalized)
                Text("#\(pokemon.id)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
