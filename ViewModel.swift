//
//  ViewModel.swift
//  Fast27
//
//  Created by Ignacio Arias on 2024-10-25.
//

import Foundation

protocol PaginatedFetchable: ObservableObject {
    associatedtype GeneralType
    associatedtype SpecificType
    associatedtype ProtocolType
    
    var listItems: [SpecificType] { get set }
    var currentPage: Int { get set }
    var api: ProtocolType { get }
    
    func fetchData(page: Int) async throws -> GeneralType
    func updateList(page: Int) async throws
    func didDisplayedLastItem(item: SpecificType) async throws
}

class ViewModel: PaginatedFetchable {
    typealias GeneralType = Model
    typealias SpecificType = Results
    typealias ProtocolType = APIProtocol
    
    @Published var listItems: [SpecificType] = []
    var currentPage: Int = 1
    var api: ProtocolType
    
    init(api: ProtocolType) {
        self.api = api
        Task {
            try await updateList()
        }
    }
    
    func fetchData(page: Int) async throws -> Model {
        return try await api.decodeFromAPI(page: page)
    }
    
    @MainActor
    func updateList(page: Int = 1) async throws {
        print("page: \(page)")
        let seq = try await fetchData(page: page)
        return listItems.append(contentsOf: seq.results)
    }
    
    func didDisplayedLastItem(item: SpecificType) async throws {
        if listItems.last == item {
            currentPage += 1
            try await updateList(page: currentPage)
        }
    }
    
}
