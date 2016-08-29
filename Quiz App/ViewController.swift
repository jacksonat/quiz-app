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
    
    var questions: [Question] = [Question]()
    
    var currentQuestion: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Get the questions from the Quiz Model - retrieve the array of Question objects and assign them to our question variable
        self.questions = self.model.getQuestions()
        
        // Check if there's at least 1 question
        if self.questions.count > 0 {
        
            // Set the current question to first question
            self.currentQuestion = self.questions[0]
            
            
            // Call the display question method
            self.displayCurrentQuestion()
            
        }
        
    }
    
    func displayCurrentQuestion() {
    
        // Check that there is a current question
        if let actualCurrentQuestion = self.currentQuestion {
            
            // Update the question text
            self.questionLabel.text = actualCurrentQuestion.questionText
            
            // Update the module and lesson label
            self.moduleLabel.text = String(format: "Module: %i Lesson: %i", actualCurrentQuestion.module, actualCurrentQuestion.lesson)
            
            // Create and display the answer button views
            self.createAnswerButtons()
            
        }
    
    }
    
    func createAnswerButtons() {
    
        
    
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

