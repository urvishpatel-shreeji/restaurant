//
//  RSLoader.swift
//  Restaurant
//
//  Created by Urvish Patel on 13/03/17.
//  Copyright © 2017 Urvish Patel. All rights reserved.
//

import UIKit

class RSLoader: NSObject
{
    
    static let sharedInstance:RSLoader = RSLoader()
  
    var config : SwiftLoader.Config = SwiftLoader.Config()
    
    override init()
    {
        self.config.size = 150
        self.config.spinnerColor = .red
        self.config.foregroundColor = .black
        self.config.foregroundAlpha = 0.5
        SwiftLoader.setConfig(config: self.config);
    }
    
    func showLoader() -> Void
    {
        SwiftLoader.show(title: "Loading", animated: true)
    }
    func dismissLoader() -> Void
    {
        DispatchQueue.main.async
            {
                 SwiftLoader.hide()
        }
        
       
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
