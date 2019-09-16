//
//  GridViewController.swift
//  ItunesApp827
//
//  Created by mac on 9/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {

    @IBOutlet weak var gridCollectionView: UICollectionView!
    
    //implicit unwrap - dependency injection
    var viewModel = ViewModel() {
        didSet {
            DispatchQueue.main.async {
                self.gridCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGrid()

    }
    
    private func setupGrid() {
        NotificationCenter.default.addObserver(forName: Notification.Name.AlbumNotification, object: nil, queue: .main) { note in
            guard let userInfo = note.userInfo as? [String:ViewModel] else { return }
            
            self.viewModel = userInfo["ViewModel"]!
        }
    }


}

extension GridViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionCell.identifier, for: indexPath) as! AlbumCollectionCell
        
        let album = viewModel.albums[indexPath.row]
        cell.album = album
        return cell
    }
    
}


extension GridViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 3
        let height = view.frame.height / 6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = viewModel.albums[indexPath.row]
        viewModel.currentAlbum = album
        goToDetail(with: viewModel)
    }
}
