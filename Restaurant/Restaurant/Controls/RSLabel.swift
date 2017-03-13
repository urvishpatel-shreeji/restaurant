//
//  RSLabel.swift
//  Restaurant
//
//  Created by Urvish Patel on 07/03/17.
//  Copyright © 2017 Urvish Patel. All rights reserved.
//

import UIKit

class RSLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        // decode clientName and time if you want
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func commonInit() -> Void
    {
        self.font = UIFont.appFont(withSize: 15.0);
        self.textColor = UIColor.appDefaultTextLabelColour();
        
    }
}
