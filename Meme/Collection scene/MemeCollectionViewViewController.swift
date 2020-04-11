//
//  MemeCollectionViewViewController.swift
//  Meme
//
//  Created by LALIT JAGTAP on 4/9/20.
//  Copyright © 2020 LALIT JAGTAP. All rights reserved.
//

import UIKit

class MemeCollectionViewViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var memeCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: Access to Meme model
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.meme
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Use Flow Layout to configure cell of Collection View
        
        let numberOfCellsPerRow:CGFloat = 2
        
        if let flowLayout = memeCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (view.frame.width - max(0, numberOfCellsPerRow - 1) * horizontalSpacing) / numberOfCellsPerRow
                        
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.memeCollectionView.reloadData()
    }
    
    @IBAction func showMemeEditor(_ sender: Any) {
        let memeEditorVC = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        
        memeEditorVC.modalPresentationStyle = .fullScreen
        
        self.present(memeEditorVC, animated: true, completion: nil)
    }
    
    // MARK: Collection View Delegates

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let memes = self.memes {
            return memes.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let meme = memes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        cell.memedImageView.image = meme.memedImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let memeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        let meme = memes[indexPath.row]
        memeDetailVC.meme = meme
        navigationController?.pushViewController(memeDetailVC, animated: true)
    }

}
