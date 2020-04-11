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
    
    // Update cell using the passed meme object
    func update(with meme: Meme) {
        memedImageView.image = meme.memedImage
        topbotLabel.text = meme.topText + " " + meme.bottomText
    }
}
