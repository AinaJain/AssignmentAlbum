//
//  AlbumListCell.swift
//  AssignmentAlbum
//
//  Created by Aina Jain on 24/08/20.
//  Copyright © 2020 Aina Jain. All rights reserved.
//

import UIKit

class AlbumListCell: UITableViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var collectionPrice: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
