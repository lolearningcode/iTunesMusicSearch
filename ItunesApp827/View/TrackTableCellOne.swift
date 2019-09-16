//
//  TrackTableCellOne.swift
//  ItunesApp827
//
//  Created by mac on 9/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class TrackTableCellOne: UITableViewCell {
    //implicit/explicit unwrap should only be done when you are one of two things: 1. 100% sure that the value is there, 2. You WANT the application to crash if it's not there
    
    @IBOutlet weak var trackAlbumImage: UIImageView!
    @IBOutlet weak var trackAlbumPrice: UIButton!
    @IBOutlet weak var trackCountLabel: UILabel!
    @IBOutlet weak var trackAlbumArtist: UILabel!
    @IBOutlet weak var trackAlbumName: UILabel!
    
    static let identifier = "TrackTableCellOne"
    
    /*
    var optional: Int?
    let value = optional! //explicit unwrap
    */
    
    var album: Album! {
        didSet {
            let price = album.price ?? 0.00
            trackAlbumPrice.setTitle("$\(price)", for: .normal)
            trackCountLabel.text = "\(album.trackCount) tracks"
            trackAlbumArtist.text = album.artist
            trackAlbumName.text = album.title
            album.getImage { [weak self] img in
                self?.trackAlbumImage.image = img
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        trackAlbumPrice.layer.cornerRadius = 5
        trackAlbumPrice.layer.borderWidth = 2
        trackAlbumPrice.layer.borderColor = trackAlbumPrice.tintColor.cgColor
    }
    
}
