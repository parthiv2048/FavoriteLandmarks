//
//  LandmarksView.swift
//  FavoriteLandmarks
//
//  Created by Parthiv Ganguly on 3/18/26.
//

import SwiftUI
import MapKit
import CoreLocation

struct LandmarksView: View {
    private let initialCameraPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.61, longitude: 77.21),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    ))
    
    @State private var centerCoordinate: CLLocationCoordinate2D?
    
    @State private var pinLocations: [PinLocation] = []
    
    var body: some View {
        Map(initialPosition: initialCameraPosition) {
            ForEach(pinLocations) { pinLocation in
                if let coordinate = pinLocation.coordinate {
                    Marker("", coordinate: coordinate)
                }
            }
        }
        .onMapCameraChange(frequency: .continuous) { context in
            centerCoordinate = context.region.center
        }
        .frame(height: 400)
        
        Button {
            pinLocations.append(PinLocation(coordinate: centerCoordinate))
        } label: {
            Text("Pin Center Location")
                .frame(maxWidth: .infinity)
                
        }
        .padding(.horizontal)
        .buttonStyle(.borderedProminent)
        
        List {
            ForEach(pinLocations.indices, id: \.self) { pinLocationIndex in
                if let coordinate = pinLocations[pinLocationIndex].coordinate {
                    Text("Pin \(pinLocationIndex + 1): \(coordinate.latitude), \(coordinate.longitude)")
                }
            }
        }
    }
}

struct PinLocation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D?
}
