//
//  EventCell.swift
//  Events
//
//  Created by Rayan Aldafas on 23/05/2018.
//  Copyright © 2018 RayanAldafas. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(20, 0, 0, 0))
    }
    
    //selected effect
//    override var isSelected: Bool{
//        didSet{
//            if self.isSelected
//            {
//                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//                self.contentView.backgroundColor = UIColor.red
//                self.nameLabel.text = "dkjdkjd"
//            }
//            else
//            {
//                self.transform = CGAffineTransform.identity
//                self.contentView.backgroundColor = UIColor.gray
//            }
//        }
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
