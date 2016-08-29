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
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
