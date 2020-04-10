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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
