//
//  ContentView.swift
//  DogPictures
//
//  Created by Lori Rothermel on 6/3/23.
//

import SwiftUI
import AVFAudio


struct ContentView: View {
    @StateObject var dogVM = DogViewModel()
    
    @State private var selectedBreed: Breed = .collie
    @State private var audioPlayer: AVAudioPlayer!
    
    
    enum Breed: String, CaseIterable {
        case boxer
        case bulldog
        case chihuahua
        case collie
        case corgi
        case labradoodle
        case poodle
        case pug
        case retriever
    }
        
    
    var body: some View {
        VStack {
            Text("🐶 Dog Pics")
                .font(Font.custom("Avenir Next Condensed", size: 60))
                .bold()
                .foregroundColor(.brown)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Spacer()
            
            AsyncImage(url: URL(string: dogVM.imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .shadow(radius: 15)
                    .animation(.default, value: image)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            }
            
            Spacer()
                     
            Button("Any Random Dog") {
                dogVM.urlString = "https://dog.ceo/api/breeds/image/random"
                Task {
                    await dogVM.getData()
                }  // Task
            }  // Button
            .buttonStyle(.borderedProminent)
            .bold()
            .tint(.brown)
            .padding(.bottom)
            
            HStack {
                Button("Show Breed") {
                    dogVM.urlString = "https://dog.ceo/api/breed/\(selectedBreed.rawValue)/images/random"
                    Task {
                        await dogVM.getData()
                    }  // Task
                }  // Button
                .buttonStyle(.borderedProminent)
                .bold()
                .tint(.brown)
                .foregroundColor(.white)
                
                Picker("", selection: $selectedBreed) {
                    ForEach(Breed.allCases, id: \.self) { breed in
                        Text(breed.rawValue.capitalized)
                            .bold()
                            .tint(.brown)
                    }  // ForEach
                }  // Picker
                .pickerStyle(.menu)
            }  // HStack
            .bold()
            .tint(.brown)
        }  // VStack
        .onAppear {
            playSound(soundName: "bark")
        }
        .padding()
    }  // some View
    
    
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("❗️ERROR: Could not read file named \(soundName).")
            return
        }  // guard let
        
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("❗️ERROR: \(error.localizedDescription) creating audioPlayer")
        }  // do..catch
        
    }
    
    
}  // ContentView


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DogViewModel())
    }
}
