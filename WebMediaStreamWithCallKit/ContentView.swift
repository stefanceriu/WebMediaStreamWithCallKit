//
//  ContentView.swift
//  WebMediaStreamWithCallKit
//
//  Created by Stefan Ceriu on 18/10/2024.
//

import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        WebView(url: Bundle.main.url(forResource: "index", withExtension: "html")! )
    }
}

private struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        context.coordinator.webView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(url: url)
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) { }
    
    @MainActor
    class Coordinator: NSObject {
        let webView: WKWebView
        
        init(url: URL) {
            let configuration = WKWebViewConfiguration()
            
            configuration.allowsInlineMediaPlayback = true
            configuration.allowsPictureInPictureMediaPlayback = true
            
            webView = WKWebView(frame: .zero, configuration: configuration)
            webView.isInspectable = true
            
            webView.load(URLRequest(url: url))
        }
    }
}

#Preview {
    ContentView()
}
