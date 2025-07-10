//
//  Trip.swift
//  Pinvoy
//
//  Created by Abbey Noble on 7/9/25.
//
import Foundation // core swift types (String, date)
import SwiftData // gives access to @Model and @Attribute, persistence framework
import CoreLocation // for coordinates on maps

// trip class = a single journey the user is planning
// @Model: tells SwiftData to persist the class automatically
@Model
final class Trip {
    // stored properties of Trip class
    @Attribute(.unique) // unique forces unique column in SQLite
    var id: UUID = UUID()
    
    @Attribute
    var name: String
    
    @Attribute
    var startDate: Date? // ?: optional field
    
    @Attribute
    var endDate: Date?
    
    // one to many relationship between trip and places
    @Relationship(deleteRule: .cascade)
    var places: [Place] = []
    
    // initialiser. fill in only data you care about,
    // SwiftData fills in the rest when it saves object
    init(
        name: String,
        startDate: Date? = nil,
        endDate: Date? = nil,
    ) {
        self.name = name // copies parameter (RHS) into stored object property
        self.startDate = startDate
        self.endDate = endDate
    }
    
}

