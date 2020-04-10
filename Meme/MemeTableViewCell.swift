//
//  MemeTableViewCell.swift
//  Meme
//
//  Created by LALIT JAGTAP on 4/9/20.
//  Copyright © 2020 LALIT JAGTAP. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memedImageView: UIImageView!
    @IBOutlet weak var topbotLabel: UILabel!
    
    
    func update(with meme: Meme) {
        memedImageView.image = meme.memedImage
        topbotLabel.text = meme.topText + " " + meme.bottomText
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
