//
//  Model.swift
//  Fast27
//
//  Created by Ignacio Arias on 2024-10-25.
//

import Foundation

//https://api.themoviedb.org/3/movie/popular?api_key=bf718d4dd8b23985d9c3edbcfd440a27&language=en-US&page=1

struct Model: Codable {
    let results: [Results]
}

struct Results: Codable, Equatable, Identifiable {
    var id = UUID()
    let original_title: String
    let frontPost: String
    let backPost: String
    
    enum CodingKeys: String, CodingKey {
        case original_title
        case frontPost = "poster_path"
        case backPost = "backdrop_path"
    }
    
    var fpictureUrl: URL? {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/") else { return nil }
        return url.appending(path: frontPost)
    }
    
    var bpictureUrl: URL? {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/") else { return nil }
        return url.appending(path: backPost)
    }
}
