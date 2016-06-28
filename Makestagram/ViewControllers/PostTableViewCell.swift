//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Vyacheslav Horbach on 28/06/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Bond

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    
    var post: Post? {
        didSet {
            if let post = post {
                post.img.bindTo(postImageView.bnd_image)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
