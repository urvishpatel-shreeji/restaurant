//
//  RestaurantDetails.swift
//  Restaurant
//
//  Created by Urvish Patel on 07/03/17.
//  Copyright © 2017 Urvish Patel. All rights reserved.
//

import UIKit
import SDWebImage

class RDetailModel:NSObject
{
    var objData:RestaurantData?
    override init() {
        
        
    }
}
enum DetailCell {
    case Details
    case Categories
    case CategorieDummy
    case Reviews
    case ReviewDummy
    
}
class RestaurantDetails: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var tblRestaurantDetails:UITableView!
    
    var vcModel:RDetailModel = RDetailModel()
    var aryTableSectionCell:[[DetailCell]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadVCContent();

        // Do any additional setup after loading the view.
    }
    func loadVCContent() -> Void
    {
        self.callRestaurantDetailsAPI();
        let arySection1:[DetailCell]  = [.Details];
        tblRestaurantDetails.dataSource = self;
        self.title = "Details";
        aryTableSectionCell = [ arySection1];
        
    }
    //MARK:- API Call
    //================================================//
    //This method is get the details of perticular restaurant
    //=================================================

    func callRestaurantDetailsAPI() -> Void
    {
        RSLoader.sharedInstance.showLoader();
        APIClient.sharedInstance.getDetailsOfRestaurant(fromBusinessId: (vcModel.objData?.businessId)!) { (businessObject) in
            
            self.vcModel.objData = businessObject
            var count:Int = (self.vcModel.objData?.categories.count)!
            var aryCategories:[DetailCell] = []
            if (self.vcModel.objData?.categories.count)! > 0
            {
                
                for _ in 1...count
                {
                    aryCategories.append(.Categories);
                    
                }
                self.aryTableSectionCell.insert(aryCategories, at: 1)
                
            }
            else
            {
                aryCategories.append(.CategorieDummy);
                self.aryTableSectionCell.insert(aryCategories, at: 1)
            }
            var aryReviews:[DetailCell] = []
            if (self.vcModel.objData?.reviews.count)! > 0
            {
                count = (self.vcModel.objData?.reviews.count)!
                
                for _ in 1...count
                {
                    aryReviews.append(.Reviews);
                    
                }
                self.aryTableSectionCell.insert(aryReviews, at: 2)
            }
            else
            {
                aryReviews.append(.ReviewDummy);
                self.aryTableSectionCell.insert(aryReviews, at: 2)
            }
            
            DispatchQueue.main.async
                {
                    RSLoader.sharedInstance.dismissLoader();
                    self.tblRestaurantDetails.estimatedRowHeight = 44.0
                    self.tblRestaurantDetails.delegate = self;
                    self.tblRestaurantDetails.reloadData();
            }
            
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return aryTableSectionCell.count;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryTableSectionCell[section].count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let cellType:[DetailCell] = aryTableSectionCell[section];
        switch cellType[0] {
        case .Details:
            return self.vcModel.objData?.name
        case .Reviews:
            return "Reviews";
        case .Categories:
            return "Categories"
        case .CategorieDummy:
            return "Categories"
        case .ReviewDummy:
            return "Reviews"
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType:DetailCell = aryTableSectionCell[indexPath.section][indexPath.row];
        
        switch cellType {
        case .Details:
            tableView.estimatedRowHeight = 100.0;
            return UITableViewAutomaticDimension;
            
        case .Reviews:
            tableView.estimatedRowHeight = 50.0
            return UITableViewAutomaticDimension;
        case .Categories:
            tableView.estimatedRowHeight = 80.0
            return UITableViewAutomaticDimension;
        case .CategorieDummy:
            return 44.0;
        case .ReviewDummy:
            return 44.0;
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cellType:DetailCell = aryTableSectionCell[indexPath.section][indexPath.row]
        switch cellType
        {
        case .Details:
            let cell:RestaurantDetailsCell = tableView.dequeueReusableCell(withIdentifier: "RestaurantDetailsCellIdentifier") as! RestaurantDetailsCell
            if self.vcModel.objData?.ratingUrl != nil
            {
                cell.imgRatingView?.sd_setImage(with: self.vcModel.objData?.ratingUrl, placeholderImage: #imageLiteral(resourceName: "DummyRatingImage"), options: SDWebImageOptions.continueInBackground, completed: { (image, error, type, url) in
                    if error == nil
                    {
                        cell.imgRatingView?.image = image
                        cell.imgRatingView.contentMode = .scaleAspectFit
                    }
                })
            }
            if self.vcModel.objData?.restaturantImageUrl != nil
            {
                cell.imgRestaurant?.sd_setImage(with: self.vcModel.objData?.restaturantImageUrl, placeholderImage: #imageLiteral(resourceName: "userprofile"), options: SDWebImageOptions.continueInBackground, completed: { (image, error, type, url) in
                    if error == nil
                    {
                        cell.imgRestaurant?.image = image
                    }
                })
            }
            else
            {
                 cell.imgRestaurant?.image = #imageLiteral(resourceName: "userprofile")
            }
            cell.lblDetails.text = self.vcModel.objData?.restaurantDetails;
            cell.lblPhoneNumber?.text = self.vcModel.objData?.phoneNumber;
            return cell
            
        case .Categories:
            let cell:ReviewCategoryCell = tableView.dequeueReusableCell(withIdentifier: "ReviewCategoryCellIdentifier") as! ReviewCategoryCell
            
            cell.lblDetails.text = self.vcModel.objData?.categories[indexPath.row]
            return cell
        case .Reviews:
            let cell:ReviewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewCellIdentifier") as! ReviewCell
            
            cell.lblReview.text =  self.vcModel.objData?.reviews[indexPath.row].review
            cell.lblName.text =  self.vcModel.objData?.reviews[indexPath.row].userName
            if self.vcModel.objData?.reviews[indexPath.row].userImageUrl != nil
            {
                cell.imgUserPhoto?.sd_setImage(with: self.vcModel.objData?.reviews[indexPath.row].userImageUrl, placeholderImage: #imageLiteral(resourceName: "userprofile"), options: SDWebImageOptions.continueInBackground, completed: { (image, error, type, url) in
                    if error == nil
                    {
                        cell.imgUserPhoto?.image = image
                    }
                })
            }
            else
            {
                cell.imgUserPhoto?.image = #imageLiteral(resourceName: "userprofile")
            }
           
            return cell
        case .CategorieDummy:
            let cell:DummyCell = tableView.dequeueReusableCell(withIdentifier: "DummyCellIdentifier") as! DummyCell
            cell.lblInfoText.text = "Category is not available"
            return cell;
        case .ReviewDummy :
            let cell:DummyCell = tableView.dequeueReusableCell(withIdentifier: "DummyCellIdentifier") as! DummyCell
            cell.lblInfoText.text = "Review is not available"
            
            return cell;
            
        }
        
    }
    
    
}
