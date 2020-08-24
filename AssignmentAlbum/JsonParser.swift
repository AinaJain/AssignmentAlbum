//
//  JsonParser.swift
//  AssignmentAlbum
//
//  Created by Aina Jain on 24/08/20.
//  Copyright © 2020 Aina Jain. All rights reserved.
//

import UIKit

class JsonParser: NSObject {

    static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    static func parse(jsonData: Data) -> [AlbumModel]? {
        do {
            let decodedData = try DataModel(data: jsonData)
            return decodedData.results
        } catch {
            print("decode error")
        }
        return nil
    }
    
}
