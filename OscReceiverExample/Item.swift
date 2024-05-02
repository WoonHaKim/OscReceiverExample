//
//  Item.swift
//  OscReceiverExample
//
//  Created by WooonHaKim on 5/2/24.
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
