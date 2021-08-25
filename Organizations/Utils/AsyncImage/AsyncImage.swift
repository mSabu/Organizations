//
//  AsyncImage.swift
//  Organizations
//
//  Created by Manjusha Sabu on 8/25/21.
//  Copyright © 2021 Manjusha Sabu. All rights reserved.
//

import SwiftUI

struct AsyncImage<PlaceholderView: View>: View {
    
    @StateObject private var loader: ImageLoader
    
    private let placeholder: PlaceholderView
    private let image: (UIImage) -> Image
    
    init(url: URL, @ViewBuilder placeholder: () -> PlaceholderView, @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
    
    private var content: some View {
        Group {
            if let loaderImage = loader.image {
                image(loaderImage)
            } else {
                placeholder
            }
        }
    }
    
    var body: some View {
        content.onAppear(perform: loader.load)
    }
}

