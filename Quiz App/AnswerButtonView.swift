//
//  AnswerButtonView.swift
//  Quiz App
//
//  Created by Jackson Taylor on 29/08/2016.
//  Copyright © 2016 Jackson Taylor. All rights reserved.
//

import UIKit

class AnswerButtonView: UIView {

    let answerLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
       
        super.init(frame: frame)
        
        // Add the label to the view
        self.addSubview(self.answerLabel)
        
        self.answerLabel.translatesAutoresizingMaskIntoConstraints = false
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    
    }
    
    func setAnswerText(text:String) {
    
        self.answerLabel.text = text
        
        // Set properties for the label and constraints
        self.answerLabel.numberOfLines = 0
        self.answerLabel.textColor = UIColor.whiteColor()
        self.answerLabel.textAlignment = NSTextAlignment.Center
        self.answerLabel.adjustsFontSizeToFitWidth = true
        
        // Set constraints
        let leftMarginConstraint = NSLayoutConstraint(item: self.answerLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 20)
        
        let rightMarginConstraint = NSLayoutConstraint(item: self.answerLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: -20)
        
        let topMarginConstraint = NSLayoutConstraint(item: self.answerLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 5)
        
        let bottomMarginConstraint = NSLayoutConstraint(item: self.answerLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -5)
        
        self.addConstraints([leftMarginConstraint, rightMarginConstraint, topMarginConstraint, bottomMarginConstraint])
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
