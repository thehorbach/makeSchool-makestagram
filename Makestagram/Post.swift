//
//  Post.swift
//  Makestagram
//
//  Created by Vyacheslav Horbach on 27/06/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import Parse
import Bond

class Post: PFObject, PFSubclassing {
    
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    var img: Observable<UIImage?> = Observable(nil)
    
 
    func uploadPost() {
        if let img = img.value {
            
            guard let imageData = UIImageJPEGRepresentation(img, 0.8) else {return}
            guard let imageFile = PFFile(name: "image.jpg", data: imageData) else {return}
            
            self.user = PFUser.currentUser()
            self.imageFile = imageFile
            
            photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            
            }
            
            saveInBackgroundWithBlock() { (success: Bool, err: NSError?) -> Void in
                
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
                
            }
        }
    }
    
    func downloadImage() {
        if (img.value == nil) {
            imageFile?.getDataInBackgroundWithBlock({ (data: NSData?, err: NSError?) -> Void in
                if let data = data {
                    let image = UIImage(data: data, scale: 0.8)
                    self.img.value = image
                }
            })
        }
    }

    
    
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    override init() {
         super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
}