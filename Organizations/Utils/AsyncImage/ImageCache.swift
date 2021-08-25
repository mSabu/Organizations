//
//  ImageCache.swift
//  Organizations


import Foundation
import UIKit

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TempImageCache: ImageCache {
    
    private let cache : NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100
    cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()

    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set {
            if newValue == nil {
                cache.removeObject(forKey: key as NSURL)
            } else {
                cache.setObject(newValue!, forKey: key as NSURL)
            }
        }
    }
        
}

