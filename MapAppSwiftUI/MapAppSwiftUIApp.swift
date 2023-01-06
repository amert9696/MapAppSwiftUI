//
//  MapAppSwiftUIApp.swift
//  MapAppSwiftUI
//
//  Created by Ali Mert Güleç on 29.12.2022.
//

import SwiftUI

@main
struct MapAppSwiftUIApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {

            LocationsView()
                .environmentObject(vm)
            
            
        }
    }
}
