//
//  ContentView.swift
//  OscReceiverExample
//
//  Created by WooonHaKim on 5/2/24.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @StateObject private var serverManager = OSCServerManager()

    var body: some View {
        NavigationView {
            List(serverManager.receivedMessages, id: \.self) { message in
                Text(message)
            }
            .navigationTitle("OSC Messages")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Start") {
                        serverManager.startServer()
                    }
                    Button("Stop") {
                        serverManager.stopServer()
                    }
                    Button("Save to CSV") {
                        serverManager.saveMessagesToCSV()
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
