import SwiftUI
import OSCKit

class OSCServerManager: ObservableObject {
    @Published var receivedMessages: [String] = []
    
    private var oscServer: OSCServer
    
    init(port: UInt16 = 8979) {
        oscServer = OSCServer(port: port, receiveQueue: .main, dispatchQueue: .main)
        oscServer.setHandler({ message, timeTag in
            // 메시지를 받았을 때 실행될 클로저
            DispatchQueue.main.async {
                let valueDescriptions = message.values.map { "\($0)" }.joined(separator: ", ")
                let displayMessage = "Received: \(message.addressPattern.stringValue) with values: \(valueDescriptions)"
                self.receivedMessages.append(displayMessage)
                print(displayMessage)
            }
        })
    }
    
    func startServer() {
        do {
            try oscServer.start()
            print("OSC Server started on port \(oscServer.localPort)")
        } catch {
            print("Error starting OSC Server: \(error)")
        }
    }
    
    func stopServer() {
        oscServer.stop()
        print("OSC Server stopped.")
    }
    
    func saveMessagesToCSV() {
        let csvString = receivedMessages.joined(separator: "\n")
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsPath.appendingPathComponent("OSCData.csv")
        do {
            try csvString.write(to: filePath, atomically: true, encoding: .utf8)
            print("Messages saved to CSV at \(filePath)")
        } catch {
            print("Error saving messages to CSV: \(error)")
        }
    }
}
