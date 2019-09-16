//
//  Album.swift
//  ItunesApp827
//
//  Created by mac on 9/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

struct AlbumResponse: Decodable {
    let albums: [Album]
    private enum CodingKeys: String, CodingKey {
        case albums = "results"
    }
}


class Album: Decodable {
    
    let artist: String
    let id: Int
    let image: String
    let title: String
    let price: Double?
    let url: String
    let copyright: String
    let genre: String
    let releaseDate: String
    let trackCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case artist = "artistName"
        case id = "collectionId"
        case image = "artworkUrl100"
        case title = "collectionName"
        case price = "collectionPrice"
        case url = "collectionViewUrl"
        case genre = "primaryGenreName"
        case copyright, releaseDate, trackCount
    }
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        
//        guard let url = URL(string: image) else {
//            completion(nil)
//            return
//        }
//
//        URLSession.shared.dataTask(with: url ) { (dat, _, _) in
//            if let data = dat {
//                DispatchQueue.main.async {
//                    completion(UIImage(data: data))
//                }
//            }
//        }.resume()
        cache.downloadFrom(endpoint: image) { dat in
            if let data = dat {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            }
        }
    }
    
}
