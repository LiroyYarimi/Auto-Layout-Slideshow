//
//  PageCell.swift
//  Auto-Layout-Slideshow
//
//  Created by liroy yarimi on 30.8.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page : Page?{
        didSet{ //page equal to nil until it's set
            
            guard let unwrappedPage = page else { return } //if page is nil, we get out with return
            
            bearImageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attrinutedText = NSMutableAttributedString(string: unwrappedPage.headerString, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)])
            attrinutedText.append(NSMutableAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor : UIColor.gray]))
            descriptionTextView.attributedText = attrinutedText
            //every time we do .attributedText we need to center the text
            descriptionTextView.textAlignment = .center
        }
    }
    
    //create a property with closure because we need to do more when we initialize
    private let bearImageView : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first")) //create bear image
        //this enables autolayout for our bearImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }() // this () is mean that we want to call the closure
    
    private let descriptionTextView : UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games!", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSMutableAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our store soon.", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor : UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)

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
    
    
}
