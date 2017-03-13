//
//  APIClient.swift
//  Restaurant
//
//  Created by Urvish Patel on 06/03/17.
//  Copyright © 2017 Urvish Patel. All rights reserved.
//

import UIKit
import YelpAPI
///This class to use the call the YelpAPI and get the data to pass the ViewCotroller in our model
///In this class we can convert the object to our model
typealias SearchResultBlock = ([RestaurantData]) -> Void
typealias DetailsResultBlock = (RestaurantData) -> Void

class APIClient: NSObject
{
    static let sharedInstance = APIClient()
    var searchBlock:SearchResultBlock?
    var detailsBlock:DetailsResultBlock?
    
    var yelpClient:YLPClient
    
    override init()
    {
        
        self.yelpClient = YLPClient.init(consumerKey: Constant.App.YelpConsumerKey, consumerSecret: Constant.App.YelpConsumerSecret, token: Constant.App.YelpToken, tokenSecret: Constant.App.YelpTokenSecret);
        
        
    }
    init(withConsumerKey consumerKey:String, withConsumerSecret consumerSecret:String, withToken token:String, withTokenSecret tokenSecret:String )
    {
        self.yelpClient = YLPClient.init(consumerKey: consumerKey, consumerSecret: consumerSecret, token: token, tokenSecret: tokenSecret);
        
    }
    //================================================//
    //This method is get the restaurant data realated to near by location
    //=================================================
    
    
    func getSearchResult(fromCoordinate coordinate:YLPGeoCoordinate, withSearchBlock search:@escaping SearchResultBlock) -> Void
    {
        if search != nil
        {
            searchBlock = search
        }
        
        self.yelpClient.search(with: coordinate, currentLatLong: nil, term: "restaurant", limit: 10, offset: 1, sort: YLPSortType.bestMatched) { (result, error) in
            if error == nil
            {
                var aryRestaurant:[RestaurantData] = [];
                for value:YLPBusiness in (result?.businesses)!
                {
                    let restaurantObject:RestaurantData = RestaurantData.init(withModel: value)
                    aryRestaurant.append(restaurantObject);
                }
                self.searchBlock!(aryRestaurant);
            }
        }
        
        
    }
    //================================================//
    //This method is get the details of the perticular restaurant data
    //=================================================
    
    
    func getDetailsOfRestaurant(fromBusinessId id:String, withSearchBlock search:@escaping DetailsResultBlock) -> Void
    {
        if search != nil
        {
            detailsBlock = search
        }
        
        self.yelpClient.business(withId: id) { (result, error) in
            
            if error == nil
            {
                let restaurant:RestaurantData = RestaurantData.init(withDetailContaint: result!)
                
                self.detailsBlock!(restaurant)
            }

            
        }
    }
}
