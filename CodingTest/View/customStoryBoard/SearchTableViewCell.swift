//
//  SearchTableViewCell.swift
//  CodingTest
//
//  Created by Prakash on 17/09/18.
//  Copyright © 2018 Prakash. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImage.layer.cornerRadius = self.userImage.frame.height/2.0
        self.userImage.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

