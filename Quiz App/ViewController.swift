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
    
    var answerButtonArray: [AnswerButtonView] = [AnswerButtonView]()
    
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
        
        var index: Int
    
        // This for loop needs to be rewritten but doing a for in loop is creating problems
        for index = 0; index < self.currentQuestion?.answers.count; index += 1 {
        
        // Create an answer button view
            
            let answer: AnswerButtonView = AnswerButtonView()
            
            answer.translatesAutoresizingMaskIntoConstraints = false
            
            // Place it into the content view
            self.scrollViewContentView.addSubview(answer)
            
            // Add constraints depending on what number button it is
            let heightConstraint: NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100)
            
            answer.addConstraint(heightConstraint)
            
            let leftMarginConstraint: NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
            
            let rightMarginConstraint: NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
            
            // Setting top margin as 100 * index, ie the button count in your for loop. Beware if you rewrite the for loop
            
            let topMarginConstraint: NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: CGFloat(101 * index))
            
            self.scrollViewContentView.addConstraints([leftMarginConstraint, rightMarginConstraint, topMarginConstraint])
            
            
            // Set the answer text for it
            
            
            
            // Add it to the button array
        
        }
            
        
        
        // Adjust the height of the content view so that it can scroll if need be
    
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

