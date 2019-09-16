//
//  FavoritesTableViewController.swift
//  ItunesApp827
//
//  Created by Lo Howard on 9/15/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import AVFoundation

class FavoritesTableViewController: UITableViewController {
    
    var coreTracks = [TracksCD]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var audioPlayer: AVAudioPlayer!
    var previousSelected: Int?
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreTracks = CoreDataService.shared.load()
        print(coreTracks.count)
    }

    @objc func playPreviewButton(sender: UIButton) {
        
        let track = coreTracks[sender.tag]
        
//        check if its the fist time we tapped the play button - check if same button is tapped twice
        if previousSelected != nil && sender.tag != previousSelected {
            tableView.reloadRows(at: [IndexPath(row: previousSelected!, section: 1)], with: .top)
        }
        
        switch sender.currentImage == #imageLiteral(resourceName: "play") {
        case true:
            guard let endpoint = track.url, let url = URL(string: endpoint) else { return }
            //API Requests
            URLSession.shared.dataTask(with: url) { [weak self] (dat, _, _) in
                if let data = dat {
                    do {
                        DispatchQueue.main.async {
                            sender.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                            self?.previousSelected = sender.tag
                        }
                        //Set AVPlayer with Data from API Request
                        self?.audioPlayer = try AVAudioPlayer(data: data)
                        //AudioPlayer to play
                        self?.audioPlayer.play()
                    } catch {
                        print("Couldn't Play Data: \(error.localizedDescription)")
                        return
                    }
                }
                }.resume()
            
        case false:
            previousSelected = nil
            sender.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            audioPlayer.pause()
        }
        
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coreTracks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        let track = coreTracks[indexPath.row]
        
        cell.trackNameLabel.text = track.name
        cell.trackDurationLabel.text = "\(Int(track.duration).toMinutes!)"
        cell.trackPriceLabel.text = "$\(track.price)"
        cell.previewButton.tag = indexPath.row
        cell.previewButton.addTarget(self, action: #selector(playPreviewButton(sender:)), for: .touchUpInside)
        
        print("Cell's \(track.url)")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let track = coreTracks[indexPath.row]
            CoreDataService.shared.delete(track)
            coreTracks.remove(at: indexPath.row)
        }
    }
}
