//
//  RSReviewData.swift
//  Restaurant
//
//  Created by Urvish Patel on 13/03/17.
//  Copyright © 2017 Urvish Patel. All rights reserved.
//

import UIKit
import YelpAPI

//================================================//
//This class store the content of the review data,(like user name,date,review info,etc)
//=================================================


class RSReviewData: NSObject {
    var userName:String = ""
    var userImageUrl:URL?
    var review:String = ""
    var date:String = ""
    init(withReview object:YLPReview)
    {
        self.review = object.excerpt;
        self.userName = object.user.name;
        self.userImageUrl = object.user.imageURL
        self.date = object.timeCreated.getStringFromDate()
    }



}
