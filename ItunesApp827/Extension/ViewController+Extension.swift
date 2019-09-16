//
//  ViewController+Extension.swift
//  ItunesApp827
//
//  Created by mac on 9/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import AVFoundation

extension UIViewController {
    
    func goToDetail(with vm: ViewModel) {
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.viewModel = vm
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
    func playAudio(from endpoint: String, completion: @escaping (AVAudioPlayer?) -> Void) {
        
        guard let url = URL(string: endpoint) else { return }
        
        URLSession.shared.dataTask(with: url) { (dat, _, _) in
            if let data = dat {
                do {
                    let audioPlayer = try AVAudioPlayer(data: data)
                    completion(audioPlayer)
                } catch {
                    completion(nil)
                    print("Couldn't Play Data: \(error.localizedDescription)")
                    return
                }
            }
        }
        
        
    }
    
    
}
