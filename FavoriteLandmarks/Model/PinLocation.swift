//
//  PinLocation.swift
//  FavoriteLandmarks
//
//  Created by Parthiv Ganguly on 3/18/26.
//

import Foundation
import CoreLocation

// MARK: - Pin Location Model

struct PinLocation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D?
}
