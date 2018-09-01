//
//  SwipingController.swift
//  Auto-Layout-Slideshow
//
//  Created by liroy yarimi on 30.8.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit


class SwipingController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    

    
    let pages = [
        Page(imageName: "bear_first", headerString: "Join us today in our fun and games!", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our store soon."),
        Page(imageName: "heart_second", headerString: "Subscribe and get coupons on our daily events", bodyText: "Get notified of the saving immediately when we announce them on our website. Make sure to also give us any feedback you have."),
        Page(imageName: "leaf_third", headerString: "VIP members special services", bodyText: "Join the private club of elite customers will get you into select drawing and giveaways.")
    ]
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        setupButtonControls()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")//decide cell as PageCell with identifier "cellId"
        collectionView?.isPagingEnabled = true
    }
    
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
    
    fileprivate func setupButtonControls() {
        
        //create stack view with three buttons
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

    

    
    //MARK: - Collection View Functions

    //minimumLineSpacingForSectionAt - minimun space from each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //numberOfItemsInSection - number of item (tableview is row and collectionView is item)
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    //cellForItemAt - create cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let newPage = pages[indexPath.item]
        cell.page = newPage //here we create a new page in PageCell class
        return cell
    }
    
    //size of items (full screen)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    //what happen when user end scrolling - let's fix pageControl.currentPage. (velocity variable tell us how fast user scroll)
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x //x is equal to the end of the target cell (after user scrolling)
        pageControl.currentPage = (Int)(x / view.frame.width)
        
    }
    
    //this func call when the size of the view change (rotate left/right)
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            //this code will run when we rotate
            
            if self.pageControl.currentPage == 0{
                self.collectionView?.contentOffset = .zero //fix the bug on the first page
            }else{
                self.collectionViewLayout.invalidateLayout()//like refresh
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)//current page
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)//put current page on the middle of the screen
            }
        })
    }
    
}
