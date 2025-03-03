//
//  DetailView.swift
//  Fast27
//
//  Created by Ignacio Arias on 2024-10-25.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    let title: String
    let url: URL?
    
    var body: some View {
        LazyVStack {
            Text(title)
            KFImage(url)
                .resizable()
                .scaledToFill()
                .clipShape(.rect(cornerRadius: 10))
        }
        .padding()
    }
}

#Preview {
    DetailView(title: "title", url: URL(string: "https://image.tmdb.org/t/p/w500//tncbMvfV0V07UZozXdBEq4Wu9HH.jpg"))
}
