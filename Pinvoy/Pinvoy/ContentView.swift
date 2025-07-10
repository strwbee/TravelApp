//
//  ContentView.swift
//  Pinvoy
//
//  Created by Abbey Noble on 7/9/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // fetch the model objects live with @Query
    /// runs implicit SELECT * FROM Trip ORDER BY name ASC
    /// SwiftUI will update automatically when trip table changes
    @Query(sort: \Trip.name)
    private var trips: [Trip]
    
    // add a trip
    /// @State: local, one view instance. switches to true when + tapped
    @State private var showAddTripSheet = false
    
    /// @Environment: ancestor view
    /// @EnvironmentObject: shared reference type that can be mutated
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            List {
                ForEach(trips) { trip in
                    Text(trip.name)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        modelContext.delete(trips[index])
                    }
                }
            }
            .navigationTitle("Trips")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Trip", systemImage: "plus") {
                        showAddTripSheet = true
                    }
                }
            }
        }
        // present sheet when flag turns to true
        .sheet(isPresented: $showAddTripSheet) {
            AddTripSheet()
        }
    }
}

#Preview {
    ContentView()
        // in memory container so previews dont write to disk
        .modelContainer(for: [Trip.self, Place.self], inMemory: true)
}
