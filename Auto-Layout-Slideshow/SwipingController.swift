//
//  SwipingController.swift
//  Auto-Layout-Slideshow
//
//  Created by liroy yarimi on 30.8.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    let imageName = ["bear_first","heart_second","leaf_third"]
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageName.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
//        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        cell.bearImageView.image = UIImage(named: imageName[indexPath.item])//it's override the bear image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
