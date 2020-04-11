//
//  MemeDetailViewController.swift
//  Meme
//
//  Created by LALIT JAGTAP on 4/9/20.
//  Copyright © 2020 LALIT JAGTAP. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    var meme: Meme!
    
    @IBOutlet weak var memedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.memedImageView!.image = meme.memedImage
    }
}
