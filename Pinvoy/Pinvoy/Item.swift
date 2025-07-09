//
//  Item.swift
//  Pinvoy
//
//  Created by Sarah Noble on 7/9/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
