//
//  ContentView.swift
//  Fast27
//
//  Created by Ignacio Arias on 2024-10-25.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel(api: API())
    
    var body: some View {
        NavigationStack {
            Group {
                List {
                    ForEach(viewModel.listItems) { items in
                        NavigationLink {
                            DetailView(title: items.original_title, url: items.bpictureUrl)
                        } label: {
                            VStack {
                                Text(items.original_title)
                                KFImage(items.fpictureUrl)
                                    .placeholder {
                                        Color.gray.opacity(0.3)
                                    }
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(.rect(cornerRadius: 10))
                                    .transition(.opacity)
                            }
                            
                        }
                        .onAppear {
                            Task {
                                try await viewModel.didDisplayedLastItem(item: items)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Movies")
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel(api: API()))
}
