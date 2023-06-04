//
//  DogViewModel.swift
//  DogPictures
//
//  Created by Lori Rothermel on 6/3/23.
//

import Foundation


@MainActor
class DogViewModel: ObservableObject {
    @Published var imageURL = ""
    
    var urlString = "https://dog.ceo/api/breeds/image/random"
    
    struct Result: Codable {
        var message: String
    }
    
    func getData() async {
        print("🕸️ We are accessing the url \(urlString)")
        
        // Convert the urlString to the special URL type
        guard let url = URL(string: urlString) else {
            print("❗️ERROR: Could not create a URL from \(urlString)")
            return
        }  // guard let
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let result = try? JSONDecoder().decode(Result.self, from: data) else {
                print("❗️JSON ERROR: Could not decode returned JSON data from \(urlString).")
                return
            }
            imageURL = result.message
            print("The imageURL is: \(imageURL)")
        } catch {
            print("❗️ERROR: Could not use URL at \(urlString) to get data & response.")
        }  // do...catch
        
    }
    
    
    
    
}
