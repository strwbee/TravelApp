//
//  AddTripSheet.swift
//  Pinvoy
//
//  Created by Abbey Noble on 7/10/25.
//

import SwiftUI
import SwiftData 

struct AddTripSheet: View {
    // handle SwiftData database session
    @Environment(\.modelContext) private var modelContext
    
    // helper to easily close the sheet
    @Environment(\.dismiss) private var dismiss
    
    // form fields (local UI state)
    @State private var name = ""
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var wantsStart = false
    @State private var wantsEnd = false
    
    private var dateRangeIsValid: Bool {
        guard
            let startDate = startDate,
            let endDate = endDate,
            wantsStart,
            wantsEnd
        else { return true }
        
        return startDate <= endDate
    }
    
    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && dateRangeIsValid
    }
    
    // view body
    var body: some View {
        NavigationStack {
            Form {
                TextField("Trip name", text: $name)
                    .textInputAutocapitalization(.words)
                Toggle("Add start date", isOn: $wantsStart.animation())
                if wantsStart {
                    DatePicker("Start",
                               selection: Binding(
                                    get: { startDate ?? Date() },
                                    set: { startDate = $0 }
                               ),
                               displayedComponents: .date)
                }
                
                Toggle("Add end date", isOn: $wantsEnd.animation())
                if wantsEnd {
                    DatePicker("End",
                               selection: Binding(
                                    get: { endDate ?? Date() },
                                    set: { endDate = $0 }
                               ),
                               displayedComponents: .date)
                        .foregroundColor(dateRangeIsValid ? .primary : .red)
                }
            }
            .navigationTitle("New Trip")
            .toolbar {
                // cancel (LHS)
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
                
                // save (RHS)
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        guard canSave else { return }
                        let trip = Trip(name: name, startDate: wantsStart ? startDate: nil, endDate: wantsEnd ? endDate : nil)
                        modelContext.insert(trip)
                        dismiss() // close sheet
                    }) {
                        Text("Save")
                    }
                    .disabled(!canSave) // greyed out save button until valid
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    AddTripSheet()
        .modelContainer(for: [Trip.self, Place.self], inMemory: true)
}
