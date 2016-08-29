//
//  QuizModel.swift
//  Quiz App
//
//  Created by Jackson Taylor on 27/08/2016.
//  Copyright © 2016 Jackson Taylor. All rights reserved.
//

import UIKit

class QuizModel: NSObject {
    
    func getQuestions() -> [Question] {
    
        // Array of Question objects
        var questions: [Question] = [Question]()
        
        // Get JSON array of dictionaries
        let jsonObjects: [NSDictionary] = self.getLocalJsonFile()
        
        // Loop through each dictionary and assign values to our question objects
        var index: Int
       
        //  FIXIT: Replace this with a for in loop. Make "item" what you assign to the jsonDictionary
        for index = 0; index < jsonObjects.count; index += 1 {
        
            // Current JSON dictionary
            let jsonDictionary: NSDictionary = jsonObjects[index]
            
            // Create a question object
            let q: Question = Question()
            
            // Assign the values of each key value pair to the question object
            q.questionText = jsonDictionary["question"] as! String // when you pull the value out of dictionary it doesn't know what type it is. You need to type cast into the type that your object property type is (ie: q.questionText is a String)
            q.answers = jsonDictionary["answers"] as! [String]
            q.correctAnswerIndex = jsonDictionary["correctIndex"] as! Int
            q.module = jsonDictionary["module"] as! Int
            q.lesson = jsonDictionary["lesson"] as! Int
            q.feedback = jsonDictionary["feedback"] as! String
            
            // Add the question to the question array
            questions.append(q)
            
        }
        
        // Return list of question objects
        return questions
    
    }
    
    func getLocalJsonFile() -> [NSDictionary] {
    
        // Get an NSURL object pointing to the json file in our app bundle
        let appBundlePath: String? = NSBundle.mainBundle().pathForResource("QuestionData", ofType: "json")
    
        // Use optional binding to check if path exists
        if let actualBundlePath = appBundlePath {
        
            // Path exists. Create an NSURL
            let urlPath: NSURL = NSURL(fileURLWithPath: actualBundlePath)
            
            // Creata NSData object for json
            let jsonData: NSData? = NSData(contentsOfURL: urlPath)
            
            if let actualJsonData = jsonData {
            
                do {
                    
                    // NSData exists; use the NSJSON serialization classes to parse the data and create the array of dictionaries
                    let arrayOfDictionaries: [NSDictionary] = try NSJSONSerialization.JSONObjectWithData(actualJsonData, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
                    
                    return arrayOfDictionaries
                
                } catch {
                
                    // There was an error parsing the JSON file
                
                }
            
            } else {
            
                //NSData does not exist
            
            }
        
        } else {
        
            // Path to json file in the bundle does not exist
        
        }
        
        // Return an empty array for the error cases (ie, function hasn't already returned the arrayOfDictionaries successfully above
        return [NSDictionary]() // the return type expected by the function
        
    }

}





























































