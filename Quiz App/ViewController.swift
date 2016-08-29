//
//  ViewController.swift
//  Quiz App
//
//  Created by Jackson Taylor on 27/08/2016.
//  Copyright © 2016 Jackson Taylor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollViewContentView: UIView!
    
    @IBOutlet weak var moduleLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    let model: QuizModel = QuizModel()
    
    var question: [Question] = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Get the questions from the Quiz Model - retrieve the array of Question objects and assign them to our question variable
        self.question = self.model.getQuestions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

