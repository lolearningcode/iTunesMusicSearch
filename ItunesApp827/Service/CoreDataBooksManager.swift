//
//  CoreDataBooksManager.swift
//  ItunesApp827
//
//  Created by Lo Howard on 9/15/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataService {
    
    static let shared = CoreDataService()
    
    private init() {}
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //lazy - late init - doesn't actually initialize the object until it is called
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TracksCD")
        
        container.loadPersistentStores(completionHandler: { (storeDescrip, err) in
            if let error = err {
                fatalError(error.localizedDescription)
            }
        })
        
        return container
    }()
    
    func save(_ track: Track) {
        
        checkTracks(track)
        
        let entity = NSEntityDescription.entity(forEntityName: "TracksCD", in: context)!
        let coreTracks = TracksCD(entity: entity, insertInto: context)
        
        coreTracks.setValue(track.name, forKey: "name")
        coreTracks.setValue(track.duration, forKey: "duration")
        coreTracks.setValue(track.price, forKey: "price")
        coreTracks.setValue(track.url, forKey: "url")
//        print("Saved track url \(track.url)")
        
        saveContext()
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func load() -> [TracksCD] {
        let fetchRequest = NSFetchRequest<TracksCD>(entityName: "TracksCD")
        
        var tracks = [TracksCD]()
        
        do {
            tracks = try context.fetch(fetchRequest)
        } catch {
            print("Couldn't Fetch Books: \(error.localizedDescription)")
        }
        
        print("Loaded \(tracks.count)")
        
        return tracks
    }
    
    func delete(_ tracks: TracksCD) {
        context.delete(tracks)
        print("Deleted tracks \(String(describing: tracks.name))")
        saveContext()
    }
    
    func checkTracks(_ track: Track) {
        let coreTracks = load()
        
        for tracks in coreTracks {
            if track.name == tracks.name {
                delete(tracks)
                return
            }
        }
    }
}
