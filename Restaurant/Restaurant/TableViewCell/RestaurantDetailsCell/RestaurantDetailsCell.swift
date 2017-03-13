//
//  RestaurantDetailsCell.swift
//  Restaurant
//
//  Created by Urvish Patel on 13/03/17.
//  Copyright © 2017 Urvish Patel. All rights reserved.
//

import UIKit

class RestaurantDetailsCell: BaseTableViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var imgRestaurant:UIImageView!
    @IBOutlet var imgRatingView:UIImageView!
    @IBOutlet var lblPhoneNumber:RSLabel!
    @IBOutlet var lblDetails:RSLabel!
    

}
