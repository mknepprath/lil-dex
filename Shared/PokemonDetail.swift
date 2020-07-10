//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Michael Knepprath on 7/2/20.
//

import SwiftUI

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

struct PokemonDetails: Codable {
    var name: String
    var weight: Double
}

let testDetails = PokemonDetails(
    name: "bulbasaur",
    weight: 40
)

struct PokemonDetail: View {
    let pokemon: Entry
    @State var details: PokemonDetails
    @State private var loading = true
    @State private var zoomed = false
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            
//            Image(pokemon.url)
//                .resizable()
//                .aspectRatio(contentMode: zoomed ? .fill : .fit)
//                .onTapGesture {
//                    withAnimation {
//                        zoomed.toggle()
//                    }
//                }
            
            if details.weight != 0 {
                Text("\(Double(round(details.weight * 0.22)).removeZerosFromEnd())lbs")
            }
            
            Spacer(minLength: 0)
            
            if pokemon.url != "" && !zoomed {
                HStack {
                    Spacer()
                    Label("URL", systemImage: "flame.fill")
                    Spacer()
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .font(Font.headline.smallCaps())
                .font(.headline)
                .background(Color.red)
                .foregroundColor(.yellow)
                .transition(.move(edge: .bottom))
            }
        }
        .navigationTitle(pokemon.name.capitalized)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform:
            loadPokemon
        )
    }
    
    func loadPokemon() {
        // create the API url
        let request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon.name)")!)
        
        // initiate the API request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                // decode the response into our Pokemon struct
                if let decodedResponse = try? JSONDecoder().decode(PokemonDetails.self, from: data) {
                        DispatchQueue.main.async {
                            // set the Pokemon based on the API response
                            self.details = PokemonDetails(
                                name: decodedResponse.name,
                                weight: decodedResponse.weight
                            )
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

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                PokemonDetail(pokemon: testEntries[0], details: testDetails)
            }
            NavigationView {
                PokemonDetail(pokemon: testEntries[1], details: testDetails)
            }
        }
    }
}

