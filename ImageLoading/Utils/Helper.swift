//
//  Helper.swift
//  ImageLoading
//
//  Created by Raj Joshi on 20/04/24.
//

import Foundation
import UIKit

class Helper {
    
    // MARK: Image Loading
    static let cache = NSCache<NSString, UIImage>() // Memory cache
    static func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let imageToReturn = UIImage(named: "placeHolder")
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(cachedImage)
        } else {
            guard let url = URL(string: urlString) else {
                completion(imageToReturn)
                return
            }
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: urlString as NSString)
                    completion(image)
                } else {
                    completion(imageToReturn)
                }
            }.resume()
        }
    }
    
    //MARK: Returm complete image url
    static func imageURLString(imageModel: ImagesModel?) -> String {
        let domain = imageModel?.thumbnail?.domain ?? ""
        let basePath = imageModel?.thumbnail?.basePath ?? ""
        let key = imageModel?.thumbnail?.key ?? ""
        let imageURL = domain + "/" + basePath + "/0/" + key
        return imageURL
    }
}
