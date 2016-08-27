//
//  Question.swift
//  Quiz App
//
//  Created by Jackson Taylor on 27/08/2016.
//  Copyright © 2016 Jackson Taylor. All rights reserved.
//

import UIKit

class Question: NSObject {

    var QuestionText: String = ""
    var answers: [String] = [String]()
    var correctAnswerIndex: Int = 0
    var module: Int = 0
    var lesson: Int = 0
    var feedback: String = ""
    
}
