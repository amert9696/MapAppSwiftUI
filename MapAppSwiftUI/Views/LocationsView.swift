//
//  LocationsView.swift
//  MapAppSwiftUI
//
//  Created by Ali Mert Güleç on 4.01.2023.
//

import SwiftUI
import MapKit


struct LocationsView: View {
  
    @EnvironmentObject private var vm: LocationsViewModel

    var body: some View {
        
        ZStack{
            Map(coordinateRegion: $vm.mapRegion)
                .ignoresSafeArea()
            
            VStack(spacing:0){
                header
                .padding()
                
                Spacer()
                
                ZStack{
                    ForEach(vm.locations) { location in
                        
                        if vm.mapLocation == location {
                            LocationPreviewView(location: location)
                                .shadow(color:Color.black.opacity(0.32),radius: 20)
                                .padding()
                            
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        }
                   
                    }
                }
            }
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView{
    
    private var header: some View{
        
        VStack {
            Button(action: vm.toggleLocationsList) {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .background(Color.red)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }}
                
                if vm.showLocationsList{
                    
                    LocationsListView()
                }
                
            }
            .background(.thickMaterial)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20,x: 0,y: 15)
        }
        
    }

