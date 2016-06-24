//
//  ProfileCell.swift
//  Instagram
//
//  Created by Dominique Macias on 6/22/16.
//  Copyright © 2016 Dominique Macias. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileCell: UITableViewCell {

    
    @IBOutlet weak var profileImagePost: PFImageView!
   
    @IBOutlet weak var profileCaptionPost: UILabel!
    
    @IBOutlet weak var profileUsernamePost: UILabel!
    
    @IBOutlet weak var profileTimestampPost: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
