//
//  LocationViewModel.swift
//  MapAppSwiftUI
//
//  Created by Ali Mert Güleç on 4.01.2023.
//

import Foundation
import MapKit

class LocationsViewModel: ObservableObject {
//    all loadded locations
    @Published var locations: [Location]
//    current location on map
    @Published var mapLocation : Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    //Current region on map
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    // Show list of locations
    @Published var showLocationsList : Bool = false
    
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location){
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        
    }
     func toggleLocationsList(){
       
            showLocationsList.toggle()
        
       
    }
    
    func showNextlocation (location: Location) {
        
        mapLocation = location
        showLocationsList = false
        
    }
    
    func nextButtonPressed(){
        //Get the current index
        
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            
            return
        }
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            
            guard let firstLocation = locations.first else {return}
            showNextlocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        showNextlocation(location: nextLocation)
        
        
    }
    
}
