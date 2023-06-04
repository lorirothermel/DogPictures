//
//  DogPicturesApp.swift
//  DogPictures
//
//  Created by Lori Rothermel on 6/3/23.
//

import SwiftUI

@main
struct DogPicturesApp: App {
    @StateObject var dogVM = DogViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dogVM)
        }
    }
}
