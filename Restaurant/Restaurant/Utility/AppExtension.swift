//
//  AppExtension.swift
//  Baton
//
//  Created by Malav Soni on 17/07/16.
//  Copyright © 2016 Malav Soni. All rights reserved.
//

import UIKit
public extension UIColor
{
    public class func appDefaultTextLabelColour() -> UIColor
    {
        return UIColor.black;
    }
}
public extension UIFont
{
    public class func appFont(withSize size:CGFloat) -> UIFont
    {
        return UIFont.systemFont(ofSize: size);
    }
    public class func appFontBoldStyle(withSize size:CGFloat) -> UIFont
    {
        return UIFont.boldSystemFont(ofSize: size);
    }
    
}
public extension String
{
    func getDateFromTimeStamp() -> Date
    {
        return Date(timeIntervalSince1970: Double(self)!)
        
    }
}
public extension Date
{
    func getStringFromDate() -> String
    {
        
        let dateFormater:DateFormatter = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd hh:mm:ss";
        let stringDate:String = dateFormater.string(from: self)
        return stringDate;
    }
}
public extension CGFloat
{
//    public class func getPraposnalHeight() -> CGFloat
//    {
//        
//    }
}
public extension UIView {
    public class func fromNib(nibNameOrNil: String? = nil) -> Self {
        return fromNib(nibNameOrNil: nibNameOrNil)
    }
    
    public class func fromNib<T : UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T {
        let v: T? = fromNib(nibNameOrNil: nibNameOrNil) as? T
        return v!
    }
    
    public class func fromNib<T : UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = nibName
        }
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews! {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
    
    public class var nibName: String
    {
        let name = String.init(format: "%@", self as! CVarArg).components(separatedBy: ".").first
        return name!
    }
    public class var nib: UINib? {
        if let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
}
