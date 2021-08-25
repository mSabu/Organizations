//
//  ImageLoader.swift
//  Organizations


import Foundation
import Combine
import UIKit
import SwiftUI


final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private(set) var isLoading = false
    
    private let url: URL
    private  var cache: ImageCache?
    private var cancellable: AnyCancellable?
    
    private static let imageProcessingQueue = DispatchQueue(label: "com.test.imageProcessing")
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard !isLoading else { return }
        
        if let image = cache?[url] {
            self.image = image
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map {UIImage(data: $0.data)}
        .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() },
                      receiveRequest: { [weak self] _ in self?.onFinish() })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    
    func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }
    
    func onFinish() {
        isLoading = false
    }
    
    func onStart() {
           isLoading = true
       }
    
    func cancel() {
        cancellable?.cancel()
    }
    
}



struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TempImageCache()
}


extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue } 
    }
}
