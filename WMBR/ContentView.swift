//
//  ContentView.swift
//  WMBR
//
//  Created by James D Rock on 5/31/24.
//

import SwiftUI
import AudioStreaming

class AudioPlayerViewModel: ObservableObject {
    @Published var isPlaying: Bool = false
    let audioPlayer = AudioPlayer()
    let musicURLString = "https://wmbr.org:8002/hi"

    func togglePlay() {
        if isPlaying {
            audioPlayer.pause()
        } else {
            if let url = URL(string: musicURLString) {
                audioPlayer.play(url: url) // Use audioPlayer from the ObservableObject
            }
        }
        isPlaying.toggle()
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

struct ContentView: View {
        @StateObject var viewModel = AudioPlayerViewModel() // ObservableObject for state management
        
        var body: some View {
            ZStack { // Use a ZStack for full-screen background
                Color(hex: 0x00824A) // Background color
            }
            VStack {
                // ... (Image and Text - unchanged)
                
                Button(action: viewModel.togglePlay) {
                    ZStack {
                        Circle() // White circle background
                            .fill(Color.white)
                            .frame(width: 60, height: 60)
                        
                        if viewModel.isPlaying {
                            HStack(spacing: 10) { // Two vertical bars for pause
                                Rectangle()
                                    .frame(width: 8, height: 30)
                                Rectangle()
                                    .frame(width: 8, height: 30)
                            }
                        } else {
                            Image(systemName: "play.fill") // Play triangle
                                .resizable()
                                .frame(width: 24, height: 30)
                                .foregroundColor(.black) // Contrast with background
                        }
                    }
                }
            }

            .padding()
            .background(Color(hex: 0x00824A))
        }
    }

