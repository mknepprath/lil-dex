//
//  ContentView.swift
//  Shared
//
//  Created by Michael Knepprath on 7/2/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: PokemonStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.pokemon) { mon in
                    PokemonCell(pokemon: mon)
                }
                .onMove(perform: movePokemon)
                .onDelete(perform: deletePokemon)
                
                HStack {
                    Spacer()
                    Text("\(store.pokemon.count) Pokémon")
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .navigationTitle("Pokémon")
            .toolbar {
                #if os(iOS)
                EditButton()
                #endif
                Button("Add", action: makePokemon)
            }
            
            
            Text("Select a Pokémon")
                .font(.largeTitle)
        }
    }
    
    func makePokemon() {
        withAnimation {
            store.pokemon.append(Monster(name: "Alolan Exeggutor", pokedexNo: 103))
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(store: testStore)
            ContentView(store: testStore)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
            ContentView(store: testStore)
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            ContentView(store: testStore)
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}

struct PokemonCell: View {
    var pokemon: Monster
    var body: some View {
        NavigationLink(destination: PokemonDetail(pokemon: pokemon)) {
            Image(pokemon.thumbnailName).resizable().scaledToFit()
                .frame(width: 48.0, height: 48.0)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(pokemon.name)
                Text("#\(pokemon.pokedexNo)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
