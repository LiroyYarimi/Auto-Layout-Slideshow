//
//  ViewController.swift
//  Auto-Layout-Slideshow
//
//  Created by liroy yarimi on 29.8.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //create a property with closure because we need to do more when we initialize
    let bearImageView : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first")) //create bear image
        //this enables autolayout for our bearImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }() // this () is mean that we want to call the closure
    
    
    let descriptionTextView : UITextView = {
        let textView = UITextView()
        textView.text = "Join us today in our fun and games!"
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
//Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our store soon.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bearImageView) //present bearImage on view
        view.addSubview(descriptionTextView)
        setupLayout()
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupLayout(){
        //this is the old way to do it.
        //bearImage.frame = CGRect(x: 0, y: 100, width: 500, height: 500)
        
        bearImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true //center vertical
        //        bearImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true //center horizontal
        bearImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true //y=100 pixel from the top of view
        bearImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true //width size 200
        bearImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true //height size 200
        
        
        
        descriptionTextView.topAnchor.constraint(equalTo: bearImageView.bottomAnchor, constant: 120).isActive = true
        //descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }

}

