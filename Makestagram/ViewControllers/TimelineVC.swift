//
//  TimelineVC.swift
//  Makestagram
//
//  Created by Vyacheslav Horbach on 24/06/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Parse

class TimelineVC: UIViewController {
    
    var photoTakingHelper: PhotoTakingHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
    }
    
    
    func takePhoto() {
        //intanitate photo taking class, provide callback for when photo is selected
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!, callback: { (image: UIImage?) in
            let post = Post()
            post.img = image
            post.uploadPost()
        })
    }
}

// MARK: Tab Bar Delegate

extension TimelineVC: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoVC) {
            takePhoto()
            return false
            
        } else {
            print("photo was not taken")
            return true
            
        }
    }
}
