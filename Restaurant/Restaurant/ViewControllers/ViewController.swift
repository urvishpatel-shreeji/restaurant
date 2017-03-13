//
//  ViewController.swift
//  Restaurant
//
//  Created by Urvish Patel on 06/03/17.
//  Copyright © 2017 Urvish Patel. All rights reserved.
//

import UIKit
import  YelpAPI
import SDWebImage
////Following model to use for save the current class objects

class VCModel:NSObject
{
    var locationManager:CLLocationManager
    var selectedMarker:PlaceMarker?
    var isSelectedMarker:Bool = false
    
    
    override init() {
        
        locationManager = CLLocationManager()
    }
    
}
class ViewController: BaseViewController {

    ////Iboutlet object declare here
    @IBOutlet var mapView:GMSMapView!
    
    ///This object to use for manage the whole screen data
    var objVCModel:VCModel = VCModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ////This method to initialise the content of the view controller
        self.setupLocationContent()
        
        
    }
    
    
    //MARK:- Other Methods
    
    func setupLocationContent() -> Void
    {
        self.title = "Near By Restaurant"
        
        mapView.delegate = self;
        mapView.isMyLocationEnabled = true;
        mapView.settings.myLocationButton = false
        
        
        objVCModel.locationManager.delegate = self
        objVCModel.locationManager.requestWhenInUseAuthorization()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //================================================//
    //This method is set the marker on Google Map
    //=================================================
    
    func addMarkerInGoogleMap(withSearchResult searchData:[RestaurantData]) -> Void
    {
        DispatchQueue.main.async
            {
                self.mapView.clear();
                for value:RestaurantData in searchData
                {
                    let marker:PlaceMarker = PlaceMarker.init(coordinate: value.coordinate!, withTitle:value.name,withImageUrl: value.restaturantImageUrl)
                    marker.data = value;
                    marker.title = value.name;
                    if marker.title == self.objVCModel.selectedMarker?.title
                    {
                        self.mapView.selectedMarker = self.objVCModel.selectedMarker
                    }
                    marker.icon = #imageLiteral(resourceName: "ic_place");
                    marker.map = self.mapView;
                }
                //self.mapView.animate(toZoom: 11);
        }
    }
    
    
    //MARK:- Navigation Methods
    
    func pushToRestaurantDetailsScreen(withObject object:RestaurantData) -> Void
    {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let detailVC:RestaurantDetails = storyBoard.instantiateViewController(withIdentifier: "RestaurantDetails") as! RestaurantDetails;
        detailVC.vcModel.objData = object;
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .authorizedWhenInUse
        {
            objVCModel.locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil
        {
            objVCModel.locationManager.stopUpdatingLocation()
        }
        
    }
}

// MARK: - GMSMapViewDelegate

extension ViewController: GMSMapViewDelegate {
    //================================================//
    //This method is get the user coordinate from google api
    //=================================================
    
    
    func mapView(_ mapView: GMSMapView!, idleAt position: GMSCameraPosition!)
    {
       
        let yelpCoordinate:YLPGeoCoordinate = YLPGeoCoordinate.init(latitude: position.target.latitude, longitude: position.target.longitude, accuracy: Double(position.zoom), altitude: position.viewingAngle, altitudeAccuracy: 10.0)
        if self.objVCModel.isSelectedMarker == false
        {
            self.mapView.clear();
            RSLoader.sharedInstance.showLoader();
            APIClient.sharedInstance.getSearchResult(fromCoordinate: yelpCoordinate)
            {
                (searchData) in
                self.addMarkerInGoogleMap(withSearchResult: searchData);
                RSLoader.sharedInstance.dismissLoader()
            }
        }
        else
        {
           self.objVCModel.isSelectedMarker = false
        }
       
       
    }
    
    func mapView(_ mapView: GMSMapView!, willMove gesture: Bool) {
        if (gesture)
        {
        }
    }
    
    func mapView(_ mapView: GMSMapView!, markerInfoContents marker: GMSMarker!) -> UIView!
    {
        self.objVCModel.isSelectedMarker = true
        
        let placeMarker = marker as! PlaceMarker
        self.objVCModel.selectedMarker = placeMarker;
        
        if let infoView = Bundle.main.loadNibNamed("MarkerInfoView", owner: self, options: nil)?[0] as? MarkerInfoView
        {
            infoView.configureLabels(withName: placeMarker.title, withRatingValue: (placeMarker.data?.ratingValue)!, withAddress: (placeMarker.data?.address)!);
            
            return infoView
        } else
        {
            return nil
        }
    }
    
    func mapView(_ mapView: GMSMapView!, didTapInfoWindowOf marker: GMSMarker!)
    {
        ////Push to next View Controller
        let annotationMarker:PlaceMarker = marker as! PlaceMarker
        self.pushToRestaurantDetailsScreen(withObject: annotationMarker.data!);
        
        
        
    }
    func didTapMyLocationButtonForMapView(mapView: GMSMapView!) -> Bool {
       // mapCenterPinImage.fadeIn(0.25)
        mapView.selectedMarker = nil
        return false
    }
}
