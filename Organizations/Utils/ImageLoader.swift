////
////  ImageLoader.swift
////  Organizations
////
////  Created by Manjusha Sabu on 8/8/21.
////  Copyright © 2021 Manjusha Sabu. All rights reserved.
////
//
//import Foundation
//import Combine
//import UIKit
//
//final class ImageLoader: ObservableObject {
//    @Published var image: UIImage?
//    
//    private(set) var isLoading = false
//    
//    var url: URL?
//    var imageCache = ImageCache.getImageCache()
//
//    init(urlString: String?) {
//        self.url = urlString
//        loadImage()
//    }
//
//    func loadImage() {
//        if loadImageFromCache() {  return }
//
//        print("Cache miss, loading from url")
//        loadImageFromUrl()
//    }
//
//    func loadImageFromCache() -> Bool {
//        guard let urlString = urlString else {
//            return false
//        }
//
//        guard let cacheImage = imageCache.get(forKey: urlString) else {
//            return false
//        }
//
//        image = cacheImage
//        return true
//    }
//
//    func loadImageFromUrl() {
//        guard let urlString = urlString else {
//            return
//        }
//
//        let url = URL(string: urlString)!
//        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
//        task.resume()
//    }
//
//
//    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
//        guard error == nil else {
//            print("Error: \(error!)")
//            return
//        }
//        guard let data = data else {
//            print("No data found")
//            return
//        }
//
//        DispatchQueue.main.async {
//            guard let loadedImage = UIImage(data: data) else {
//                return
//            }
//
//            self.imageCache.set(forKey: self.urlString!, image: loadedImage)
//            self.image = loadedImage
//        }
//    }
//}
//
