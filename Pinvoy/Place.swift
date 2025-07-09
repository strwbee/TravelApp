//
//  Place.swift
//  Pinvoy
//
//  Created by Abbey Noble on 7/9/25.
//

import Foundation
import SwiftData
import CoreLocation

@Model // tells SwiftData to persist object
final class Place {
    @Attribute(.unique)
    var id: UUID = UUID()
    
    @Attribute
    var name = String()
    
    @Attribute
    var latitude: Double = 0
    
    @Attribute
    var longitude: Double = 0
    
    @Attribute
    var notes: String? = nil
    
    // back link to parent trip (many places to one trip)
    @Relationship(deleteRule: .nullify) // nullify allows to move place to another trip later
    var Trip: Trip?
    
    
    // compute helpers
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
    
    
    // initialiser
    init(
        name: String,
        coordinate: CLLocationCoordinate2D,
        trip: Trip? = nil,
        notes: String? = nil
    ) {
        self.name = name
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.Trip = trip
        self.notes = notes
    }
}
