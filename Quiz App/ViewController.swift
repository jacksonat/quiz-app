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
    
    // Result View IBOutlet properties
    
    @IBOutlet weak var resultTitleLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var dimView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Hide the dim and result views
        self.dimView.alpha = 0
        
        self.resultView.alpha = 0
        
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
        
        for index in 0..<self.currentQuestion!.answers.count {
        
        // Create an answer button view
            
            let answer: AnswerButtonView = AnswerButtonView()
            
            answer.translatesAutoresizingMaskIntoConstraints = false
            
            // Place it into the content view
            self.scrollViewContentView.addSubview(answer)
            
            // Add a tap gesture recognizer
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.answerTapped(_:)))
            
            answer.addGestureRecognizer(tapGesture)
            
            // Add constraints depending on what number button it is
            let heightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100)
            
            answer.addConstraint(heightConstraint)
            
            let leftMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
            
            let rightMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)

            let topMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: CGFloat(101 * index))
            
            self.scrollViewContentView.addConstraints([leftMarginConstraint, rightMarginConstraint, topMarginConstraint])
            
            
            // Set the answer text for it
            let answerText = self.currentQuestion!.answers[index]
            answer.setAnswerText(answerText)
            
            // Add it to the button array
            self.answerButtonArray.append(answer)
        }
        
        // Adjust the height of the content view so that it can scroll if need be
        let contentViewHeight:NSLayoutConstraint = NSLayoutConstraint(item: self.scrollViewContentView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.answerButtonArray[0], attribute: NSLayoutAttribute.Height, multiplier: CGFloat(self.answerButtonArray.count-1), constant: 101)
        
        // Add constraint to content view
        self.scrollViewContentView.addConstraint(contentViewHeight)
    }
    
    func answerTapped(gesture: UITapGestureRecognizer) {
    
        // Get access to the answer button that was tapped
        let answerButtonThatWasTapped: AnswerButtonView? = gesture.view as? AnswerButtonView
        
        if let actualButton = answerButtonThatWasTapped {
        
            // Find out which index it was
            let answerTappedIndex: Int? = self.answerButtonArray.indexOf(actualButton)
            
            if let foundAnswerIndex = answerTappedIndex {
            
                // If we found the index, compare the answer index that was tapped versus the correct index from the question
                
                if foundAnswerIndex == self.currentQuestion!.correctAnswerIndex {
                
                    // User got it correct
                    print("correct")
                    self.resultTitleLabel.text = "Correct!"
                
                } else {
                
                    // User got it wrong
                    print("incorrect")
                    self.resultTitleLabel.text = "Incorrect"
                
                }
                
                // Display the dim view and the result view
                self.dimView.alpha = 1
                self.resultView.alpha = 1
                self.feedbackLabel.text = self.currentQuestion!.feedback
                
            
            }
        
        }
    
    }

    @IBAction func changeQuestion(sender: UIButton) {
    
        // Dismiss dimmed view and result view
        self.dimView.alpha = 0
        self.resultView.alpha = 0
        
        // Erase the question and module labels
        self.questionLabel.text = ""
        self.moduleLabel.text = ""
        
        // Remove all the buttons views
        
        for button in self.answerButtonArray {
        
            button.removeFromSuperview()
        
        }
        
        // Empty the button array
        self.answerButtonArray.removeAll(keepCapacity: false) // takes it back to a zero capacity array
        
        // Finding current index of question
        let indexOfCurrentQuestion: Int? = self.questions.indexOf(currentQuestion!)
        
        // Check if it found the current index
        if let actualCurrentIndex = indexOfCurrentQuestion {
        
            // Found the index ... Advance the index
            
            let nextQuestionIndex = actualCurrentIndex + 1
        
            // Check if nextQuestionIndex is beyond the size of our questions array
            
            if nextQuestionIndex < self.questions.count {
            
                // Display another questions
                self.currentQuestion = self.questions[nextQuestionIndex]
                
                self.displayCurrentQuestion()
                
            } else {
            
                // No more questions to display. End the quiz
            
            }
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

