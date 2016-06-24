//
//  PostCell.swift
//  Instagram
//
//  Created by Dominique Macias on 6/21/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {

    
    
    @IBOutlet weak var imagePost: PFImageView!
    
    @IBOutlet weak var captionPost: UILabel!
    
    @IBOutlet weak var usernamePost: UILabel!
    
    @IBOutlet weak var timestampPost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
