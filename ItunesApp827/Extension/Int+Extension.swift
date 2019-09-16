//
//  Int+Extension.swift
//  ItunesApp827
//
//  Created by mac on 9/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


extension Int {
    
    
    var toMinutes: String? {
        
        let totalSeconds = self / 1000
        
        var minutes: Double
        var seconds: Int
        
        minutes = Double(totalSeconds / 60)
        minutes.round(.down)
        
        seconds = Int(totalSeconds) % 60
        
        return "\(Int(minutes)) min \(seconds) sec"
        
    }
    
}
