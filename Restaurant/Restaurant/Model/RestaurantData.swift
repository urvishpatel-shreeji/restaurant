//
//  RestaurantData.swift
//  Restaurant
//
//  Created by Urvish Patel on 07/03/17.
//  Copyright © 2017 Urvish Patel. All rights reserved.
//

import UIKit
import YelpAPI
///In this model we can create the restaurant data save and edit in that class
class RestaurantData: NSObject
{
    var name:String = ""
    var ratingValue:Double = 0.0
    var businessId:String = ""
    var ratingUrl:URL?
    var address:String = ""
    var restaturantImageUrl:URL?
    var phoneNumber:String = ""
    var categories:[String] = []
    var reviews:[RSReviewData] = []
    var coordinate:CLLocationCoordinate2D?
    var restaurantDetails:String = ""
    
    //================================================//
    //This method is use to initialize the marker details of the restaurant
    //=================================================
    
    init(withModel object:YLPBusiness)
    {
        self.businessId = object.identifier
       
        self.name = object.name;
        self.ratingUrl = object.ratingImgURL
        if object.location.address.count > 0
        {
            self.address  =  object.location.address[0]
        }
        self.restaturantImageUrl = object.imageURL
        
        self.coordinate = CLLocationCoordinate2D.init(latitude: (object.location.coordinate?.latitude)!, longitude: (object.location.coordinate?.longitude)!);
        self.ratingValue = object.rating;
        
        for value in object.categories
        {
            self.categories.append(",\(value.name)")
        }
        if object.phone != nil
        {
             self.phoneNumber = object.phone!;
        }
       
        
    }
    //================================================//
    //This method is use to initialize the details of the restaurant
    //=================================================
    
    
    init(withDetailContaint object:YLPBusiness)
    {
        self.name = object.name;
        self.businessId = object.identifier
        if object.snippetText != nil
        {
            self.restaurantDetails = object.snippetText!;
        }
        
        if object.imageURL != nil
        {
            self.restaturantImageUrl = object.imageURL
        }
        else if object.snippetImageURL != nil
        {
             self.restaturantImageUrl = object.snippetImageURL
        }
        if object.ratingImgURLLarge != nil {
            self.ratingUrl = object.ratingImgURLLarge;
        }
        
        if  object.displayPhone != nil {
            self.phoneNumber = object.displayPhone!
        }
        else if object.phone != nil
        {
            self.phoneNumber = object.phone!;
        }
        
        for value in object.categories
        {
             self.categories.append(value.name)
        }
        for value in object.reviews!
        {
            let reviewObject:RSReviewData = RSReviewData.init(withReview: value);
            self.reviews.append(reviewObject);
            
        }
        
    }

}
