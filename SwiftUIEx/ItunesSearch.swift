//
//  ItunesSearch.swift
//  SwiftUIEx
//
//  Created by Hector Steven Villasano on 6/21/25.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ItunesSearch: View {
    @State private var results = [Result]()
    
    var body: some View {
        VStack {
            List(results, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                        .font(.caption)
                }
                
            }
            .task {
                await loadData()
            }
        }
        .padding()
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=drake&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ItunesSearch()
}
