//
//  AlbumViewModel.swift
//  AssignmentAlbum
//
//  Created by Aina Jain on 24/08/20.
//  Copyright © 2020 Aina Jain. All rights reserved.
//

import UIKit

enum SortingTypes: String, CaseIterable {
    case releaseDate = "Release Date",
    collectionName = "Collection Name",
    trackName = "Track Name",
    artistName = "Artist Name",
    collectionPrice = "Collection Price(Descending)"
    
}

class AlbumViewModel: NSObject {
    var albums: [AlbumModel]?
    var filteredAlbums: [AlbumModel] = []
    
    func getData(completion: (() -> Void)) {
        if let localData = JsonParser.readLocalFile(forName: "album") {
            var array = JsonParser.parse(jsonData: localData)
            //Remove Duplicate data by Trackname
            array?.removeDuplicates()
            albums = sortBy(albums: array, sorter: .releaseDate)
            completion()
        }
    }
    
    func filterContentForSearchText(_ searchText: String, completion: (() -> Void)) {
        guard let filteredAlbumsByArtists = albums?.filter({ $0.artistName.lowercased().contains(searchText.lowercased()) }),
            let filteredAlbumsByTrackName = albums?.filter({ $0.trackName.lowercased().contains(searchText.lowercased()) }),
            let filteredAlbumsByCollectionName = albums?.filter({ ($0.collectionName?.lowercased().contains(searchText.lowercased()) ?? false) }) else { return }
        let filteredArray = filteredAlbumsByArtists + filteredAlbumsByTrackName + filteredAlbumsByCollectionName
        filteredAlbums = filteredArray
        completion()
    }
    
    func getDatasourceArray(isFilterOn: Bool) -> [AlbumModel]? {
        let array = isFilterOn ? filteredAlbums : albums
        return array
    }
    
    func updateTableOrder(with sorter: SortingTypes) {
        albums = sortBy(albums: albums, sorter: sorter)
    }
    
    func sortBy(albums: [AlbumModel]?, sorter: SortingTypes) -> [AlbumModel]? {
        guard let array = albums else { return albums }
        switch sorter {
        case .collectionPrice:
            return array.sorted(by: { (album1, album2) -> Bool in
                album1.collectionPrice > album2.collectionPrice
            })
            
        case .collectionName:
            return array.sorted(by: { (album1, album2) -> Bool in
                album1.collectionName?.lowercased() ?? "" < album2.collectionName?.lowercased() ?? ""
            })
            
        case .trackName:
            return array.sorted(by: { (album1, album2) -> Bool in
                album1.trackName.lowercased() < album2.trackName.lowercased()
            })
        case .artistName:
            return array.sorted(by: { (album1, album2) -> Bool in
                album1.artistName.lowercased() < album2.artistName.lowercased()
            })
            
        default:
            return array.sorted(by: { (album1, album2) -> Bool in
                dateWithDefaultFormatter(from: album1.releaseDate ?? "") < dateWithDefaultFormatter(from: album2.releaseDate ?? "")
            })
            
        }
    }
    
    func dateWithDefaultFormatter(from string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter.date(from: string) ?? Date()
    }
}


