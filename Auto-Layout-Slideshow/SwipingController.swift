//
//  SwipingController.swift
//  Auto-Layout-Slideshow
//
//  Created by liroy yarimi on 30.8.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit


class SwipingController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
//    let imageName = ["bear_first","heart_second","leaf_third"]
//    let headerString = ["Join us today in our fun and games!","Subscribe and get coupons on our daily events","VIP members special services"]
    let pages = [
        Page(imageName: "bear_first", headerString: "Join us today in our fun and games!", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our store soon."),
        Page(imageName: "heart_second", headerString: "Subscribe and get coupons on our daily events", bodyText: "Get notified of the saving immediately when we announce them on our website. Make sure to also give us any feedback you have."),
        Page(imageName: "leaf_third", headerString: "VIP members special services", bodyText: "Join the private club of elite customers will get you into select drawing and giveaways.")
    ]
    
    private let previousButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlePrevious(){
        let prevPage = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevPage, section: 0)
        pageControl.currentPage = prevPage
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private let NextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        //let pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)//add action to next button
        return button
    }()
    
    @objc private func handleNext(){//this function call when next button is pressed
        
        let nextPage = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextPage, section: 0)
        pageControl.currentPage = nextPage
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var pageControl : UIPageControl = {//we use lazy var for use pages.count
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = .lightPink
        return pc
    }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        setupButtonControls()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")//decide cell as PageCell with identifier "cellId"
        collectionView?.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
//        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
//        cell.bearImageView.image = UIImage(named: imageName[indexPath.item])//it's override the bear image
//        cell.descriptionTextView.text = headerString[indexPath.item]
//        cell.bearImageView.image = UIImage(named: pages[indexPath.item].imageName)
//        cell.descriptionTextView.text = pages[indexPath.item].headerString
        let newPage = pages[indexPath.item]
        cell.page = newPage //here we create a new page in PageCell class
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    fileprivate func setupButtonControls() {
        
        let buttonControlStackView = UIStackView(arrangedSubviews: [previousButton,pageControl,NextButton])
        buttonControlStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonControlStackView.distribution = .fillEqually
        
        view.addSubview(buttonControlStackView)
        
        NSLayoutConstraint.activate([//with this way we dont need to write ".isActive = true" for every line
            buttonControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),//left side
            buttonControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),//right side
            buttonControlStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        
    }
}
