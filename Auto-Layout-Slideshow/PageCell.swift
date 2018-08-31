//
//  PageCell.swift
//  Auto-Layout-Slideshow
//
//  Created by liroy yarimi on 30.8.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    //create a property with closure because we need to do more when we initialize
    let bearImageView : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first")) //create bear image
        //this enables autolayout for our bearImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }() // this () is mean that we want to call the closure
    
    let descriptionTextView : UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games!", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSMutableAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our store soon.", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor : UIColor.gray]))
        
        textView.attributedText = attributedText
        
        //textView.text = "Join us today in our fun and games!"
        //textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let previousButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    private let NextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        //let pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        button.setTitleColor(.mainPink, for: .normal)
        return button
    }()
    
    private let pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = .lightPink
        return pc
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        //backgroundColor = .yellow
        setupButtonControls()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false //enable auto-layout
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        //topImageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //topImageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //this two lines is equal to leftAnchor & rightAnchor
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        //let's add the bear image view into topImageContainerView
        topImageContainerView.addSubview(bearImageView)
        bearImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        //descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor,constant:24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true// rightAnchor need to be negative
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    fileprivate func setupButtonControls() {
        
        
        //view.addSubview(previousButton)
        
        
        //        let yellowView = UIView()
        //        yellowView.backgroundColor = .yellow
        //        let blueView = UIView()
        //        blueView.backgroundColor = .blue
        //        let greenView = UIView()
        //        greenView.backgroundColor = .green
        
        let buttonControlStackView = UIStackView(arrangedSubviews: [previousButton,pageControl,NextButton])
        buttonControlStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonControlStackView.distribution = .fillEqually
        
        //        buttonControlStackView.axis = .vertical
        addSubview(buttonControlStackView)
        
        //previousButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        NSLayoutConstraint.activate([//with this way we dont need to write ".isActive = true" for every line
            //            previousButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),//for the nutch
            buttonControlStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            buttonControlStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),//left side
            buttonControlStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),//right side
            buttonControlStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        
    }
}