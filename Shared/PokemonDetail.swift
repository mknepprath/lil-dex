//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Michael Knepprath on 7/2/20.
//

import SwiftUI

struct PokemonDetail: View {
    let pokemon: Monster
    @State private var zoomed = false
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            
            Image(pokemon.imageName)
                .resizable()
                .aspectRatio(contentMode: zoomed ? .fill : .fit)
                .onTapGesture {
                    withAnimation {
                        zoomed.toggle()
                    }
                }
            
            Spacer(minLength: 0)
            
            if pokemon.isSpicy && !zoomed {
                HStack {
                    Spacer()
                    Label("Spicy", systemImage: "flame.fill")
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
        .navigationTitle(pokemon.name)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                PokemonDetail(pokemon: testData[0])
            }
            NavigationView {
                PokemonDetail(pokemon: testData[1])
            }
        }
    }
}

