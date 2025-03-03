//
//  API.swift
//  Fast27
//
//  Created by Ignacio Arias on 2024-10-25.
//

// https://api.themoviedb.org/3/movie/popular?api_key=bf718d4dd8b23985d9c3edbcfd440a27&language=en-US&page=1

import Foundation

protocol APIProtocol {
    func buildUrl(page: Int) throws -> URL
    func decodeFromAPI(page: Int) async throws -> Model
}

enum APIError: Error {
    case invalidUrl
    case invalidDecoding
}

struct API: APIProtocol {
    func buildUrl(page: Int) throws -> URL {
        guard let rootUrl = URL(string: "https://api.themoviedb.org") else { throw APIError.invalidUrl }
        
        var urlComponents = URLComponents(url: rootUrl.appending(path: "/3/movie/popular"), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "api_key", value: "bf718d4dd8b23985d9c3edbcfd440a27"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: page.description)
        ]
        guard let finalUrlComponents = urlComponents?.url else { throw APIError.invalidUrl }
        print("finalUrl: \(finalUrlComponents)")
        return finalUrlComponents
    }
    
    func decodeFromAPI(page: Int) async throws -> Model {
        do {
            let (data, _) = try await URLSession.shared.data(from: buildUrl(page: page))
            return try JSONDecoder().decode(Model.self, from: data)
        } catch {
            print("error: \(error)")
            throw APIError.invalidDecoding
        }
    }
}
