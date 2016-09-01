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
    
    // Create outlet for the top margin constraint so to animate it
    @IBOutlet weak var resultViewTopMargin: NSLayoutConstraint!
    
    
    
    
    
    // Score keeping
    var numberCorrect: Int = 0
    
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
            
            // Load state to load the previously saved question if different
            self.loadState()
            
            // Call the display question method
            self.displayCurrentQuestion()
            
        }
        
    }
    
    func displayCurrentQuestion() {
    
        // Check that there is a current question
        if let actualCurrentQuestion = self.currentQuestion {
            
            // Add animations
            // Set question to be invisible
            self.questionLabel.alpha = 0
            self.moduleLabel.alpha = 0
            
            // Update the question text
            self.questionLabel.text = actualCurrentQuestion.questionText
            
            // Update the module and lesson label
            self.moduleLabel.text = String(format: "Module: %i Lesson: %i", actualCurrentQuestion.module, actualCurrentQuestion.lesson)
            
            // Reveal the question
            UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.questionLabel.alpha = 1
                self.moduleLabel.alpha = 1
                
                }, completion: nil)
            
            // Create and display the answer button views
            self.createAnswerButtons()
            
            // Save state each time question is displayed
            self.saveState()
            
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
            
            // Set off screen constraints (see constant) to animate
            let leftMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 400)
            
            let rightMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 400)

            let topMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: CGFloat(101 * index))
            
            self.scrollViewContentView.addConstraints([leftMarginConstraint, rightMarginConstraint, topMarginConstraint])
            
            
            // Set the answer text for it
            let answerText = self.currentQuestion!.answers[index]
            answer.setAnswerText(answerText)
            
            // Add it to the button array
            self.answerButtonArray.append(answer)
            
            // Animate the button constraints so they slide in
            // Manually call update layout
            self.view.layoutIfNeeded()
            
            // Create an incrementer for the delay so buttons slide-in will be staggered
            let slideInDelay: Double = Double(index) * 0.1
            
            UIView.animateWithDuration(0.5, delay: slideInDelay, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                    leftMarginConstraint.constant = 0
                
                    rightMarginConstraint.constant = 0
                
                    self.view.layoutIfNeeded()
                
                }, completion: nil)
            
            
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
                    self.resultTitleLabel.text = "Correct!"
                    
                    // Change background color of result view and button
                    self.resultView.backgroundColor = UIColor(red: 43/255, green: 85/255, blue: 51/255, alpha: 0.8)
                    
                    self.nextButton.backgroundColor = UIColor(red: 28/255, green: 85/255, blue: 40/255, alpha: 1)
                    
                    // Increment user score
                    self.numberCorrect += 1
                
                } else {
                
                    // Change background color of result view and button
                    self.resultView.backgroundColor = UIColor(red: 85/255, green: 19/255, blue: 12/255, alpha: 0.8)
                    
                    self.nextButton.backgroundColor = UIColor(red: 58/255, green: 0/255, blue: 16/255, alpha: 1)
                    
                    // User got it wrong
                    self.resultTitleLabel.text = "Incorrect"
                
                }
                
                // Set result view top margin constraint to very high value
                self.resultViewTopMargin.constant = 900
                
                self.view.layoutIfNeeded()
                
                // Display the dim view and the result view
                // Add animation to ease the display
                UIView.animateWithDuration(0.5, animations: {
                
                    
                    // Animate display of result view
                    self.resultViewTopMargin.constant = 30
                    
                    self.view.layoutIfNeeded()
                    
                    // Fade in to view
                    self.dimView.alpha = 1
                
                    self.resultView.alpha = 1
                
                })
                
                // Save state every time answer is selected
                self.saveState()
                    
                // Set the feedback text
                self.feedbackLabel.text = self.currentQuestion!.feedback
                
                // Set the button text to next
                self.nextButton.setTitle("Next", forState: UIControlState.Normal)
            
            }
        
        }
    
    }

    @IBAction func changeQuestion(sender: UIButton) {
    
        // Check if button title is "restart", if so restart quiz
        // Otherwise try to advance to the next question
        if self.nextButton.titleLabel?.text == "Restart" && self.questions.count > 0 {
        
            // Reset the question to the first question
            self.currentQuestion = self.questions[0]
            self.displayCurrentQuestion()
            
            // Remove the dim view and the result view
            self.dimView.alpha = 0
            self.resultView.alpha = 0
            
            // Reset the score
            self.numberCorrect = 0
            
            return // exit this method
        
        }
        
        // Dismiss dimmed view and result view
        self.dimView.alpha = 0
        self.resultView.alpha = 0
        
        // Erase the question and module labels - only necessary for the clear screen on the final score view, overkill to do it each question perhaps
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
            
                // Erase any saved state so user resumes at question 0 rather than end
                self.eraseState()
                
                // No more questions to display. End the quiz
                self.resultView.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 0.8)
                self.nextButton.backgroundColor = UIColor.darkGrayColor()
                
                self.resultTitleLabel.text = "Quiz finished"
                
                self.feedbackLabel.text = String(format: "Your score is %i / %i", self.numberCorrect, self.questions.count)
                
                self.nextButton.setTitle("Restart", forState: UIControlState.Normal)
                
                // Display the views again
                self.dimView.alpha = 1
                self.resultView.alpha = 1
            
            }
        }
    
    }
    
    func eraseState() {
    
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setInteger(0, forKey: "nuberCorrect")
        
        userDefaults.setInteger(0, forKey: "questionIndex")
        
        userDefaults.setBool(false, forKey: "resultViewAlpha")
        
        userDefaults.setObject("", forKey: "resultViewTitle")
        
        userDefaults.synchronize()
    
    }
    
    func saveState() {
    
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        // Save the current score, current question and whether or not the result view is visible
        userDefaults.setInteger(self.numberCorrect, forKey: "numberCorrect")
        
        // Find the current question index
        let indexOfCurrentQuestion: Int? = self.questions.indexOf(self.currentQuestion!)
        
        if let actualIndex = indexOfCurrentQuestion {
        
            userDefaults.setInteger(actualIndex, forKey: "questionIndex")
        
        }
        
        // Set true if result view is visible else set false
        userDefaults.setBool(self.resultView.alpha == 1, forKey: "resultViewAlpha")
        
        // Save the title of the result view
        userDefaults.setObject(self.resultTitleLabel.text, forKey: "resultViewTitle")
    
        // Write the changes to disk
        userDefaults.synchronize()
        
    }
    
    func loadState() {
    
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        // Load the saved question into the current question
        let currentQuestionIndex = userDefaults.integerForKey("questionIndex")
        
        // Check that the saved index is not beyond the number of questions
        if currentQuestionIndex < self.questions.count {
            
            self.currentQuestion = self.questions[currentQuestionIndex]
        
        }
        
        // Load the score
        let score: Int = userDefaults.integerForKey("numberCorrect")
        
        self.numberCorrect = score
        
        // Load the result view visibility
        let isResultViewVisible = userDefaults.boolForKey("resultViewAlpha")
        
        if isResultViewVisible == true {
        
            // We should display the result view
            self.feedbackLabel.text = self.currentQuestion?.feedback
            
            // Retreive the title text
            let title: String? = userDefaults.objectForKey("resultViewTitle") as! String?
            
            if let actualTitle = title {
            
                resultTitleLabel.text = actualTitle
                
                if actualTitle == "Correct" {
                
                    // Change background and button colour
                    self.resultView.backgroundColor = UIColor(red: 43/255, green: 85/255, blue: 51/255, alpha: 0.8)
                    
                    self.nextButton.backgroundColor = UIColor(red: 28/255, green: 85/255, blue: 40/255, alpha: 1)
                
                } else if actualTitle == "Incorrect" {
                
                    // Change background and button colour
                    self.resultView.backgroundColor = UIColor(red: 85/255, green: 19/255, blue: 12/255, alpha: 0.8)
                    
                    self.nextButton.backgroundColor = UIColor(red: 58/255, green: 0/255, blue: 16/255, alpha: 1)
                
                }
            
            }
            
            dimView.alpha = 1
            
            resultView.alpha = 1
        
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}














