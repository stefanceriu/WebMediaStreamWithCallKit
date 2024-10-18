//
//  CallKitController.swift
//  WebMediaStreamWithCallKit
//
//  Created by Stefan Ceriu on 18/10/2024.
//

import AVFoundation
import Foundation
import CallKit

class CallKitController: NSObject, CXProviderDelegate {
    private let callController = CXCallController()
    private let callProvider: CXProvider = {
        let configuration = CXProviderConfiguration()
        configuration.supportsVideo = true
        
        return CXProvider(configuration: configuration)
    }()
    
    override init() {
        super.init()
        
        callProvider.setDelegate(self, queue: nil)
    }
    
    func setupCallKitSession() async {
        let handle = CXHandle(type: .generic, value: "RandomCall")
        let startCallAction = CXStartCallAction(call: UUID(), handle: handle)
        startCallAction.isVideo = true
        
        do {
            try await callController.request(CXTransaction(action: startCallAction))
        } catch {
            print("Failed requesting start call action with error: \(error)")
        }
    }
    
    // MARK: CXProviderDelegate
    
    func providerDidReset(_ provider: CXProvider) { }
    
    func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        // We need this so we can:
        do {
            try audioSession.setCategory(.playAndRecord, mode: .videoChat, options: [.defaultToSpeaker])
        } catch {
            print("Failed setting up audio session with error: \(error)")
        }
    }
    
    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        #warning("The WebView's video stream breaks (i.e. shows gray) as soon as the call start action is fulfilled.")
        #warning("Remove this or don't set the CXProvider delegate to see it working again")
        #warning("Without it we don't get the audio session activation callback from above and can't redirect the audio to the speakers, making CallKit end the call when trying to lock the screen.")
        action.fulfill()
    }
}
