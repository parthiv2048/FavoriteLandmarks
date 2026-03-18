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
    
    // MARK: - Properties
    
    @State private var mapCameraPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.61, longitude: 77.21),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    ))
    
    @State private var centerCoordinate: CLLocationCoordinate2D?
    
    @State private var pinLocations: [PinLocation] = []
    
    // MARK: - Map View
    
    var mapView: some View {
        Map(position: $mapCameraPosition) {
            ForEach(pinLocations.indices, id: \.self) { pinLocationIndex in
                if let coordinate = pinLocations[pinLocationIndex].coordinate {
                    Marker("Pin \(pinLocationIndex + 1)", coordinate: coordinate)
                }
            }
        }
        .onMapCameraChange(frequency: .continuous) { context in
            centerCoordinate = context.region.center
        }
        .frame(height: 400)
    }
    
    // MARK: - Pinned Locations List View
    
    var pinnedLocationsView: some View {
        List {
            ForEach(pinLocations.indices, id: \.self) { pinLocationIndex in
                if let coordinate = pinLocations[pinLocationIndex].coordinate {
                    Button("Pin \(pinLocationIndex + 1): \(coordinate.latitude), \(coordinate.longitude)") {
                        mapCameraPosition = .region(MKCoordinateRegion(
                            center: coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        ))
                    }
                }
            }
        }
        .listStyle(.plain)
    }
    
    // MARK: - Pin Location Button
    
    var pinLocationButton: some View {
        Button {
            pinLocations.append(PinLocation(coordinate: centerCoordinate))
        } label: {
            Text("Pin Center Location")
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
        .buttonStyle(.borderedProminent)
    }
    
    // MARK: - Body View
    
    var body: some View {
        mapView
        pinnedLocationsView
        pinLocationButton
    }
}
