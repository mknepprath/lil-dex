//
//  PokemonApp.swift
//  Shared
//
//  Created by Michael Knepprath on 7/2/20.
//

import SwiftUI

@main
struct PokemonApp: App {
    @StateObject private var store = PokemonStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
