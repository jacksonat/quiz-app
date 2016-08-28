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
    
        // Array of question objects
        var questions: [Question] = [Question]()
        
        // Get JSON array of dictionaries
        
        // Loop through each dictionary and assign values to our question objects
        
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
            
                // NSData exists; use the NSJSON serialization classes to parse the data and create the array of dictionaries
                // let arrayOfDictionaries: [NSDictionary] =
            
            
            } else {
            
                // Handle error for NSData does not exist
            
            }
        
        } else {
        
            // Path to json file in the bundle does not exist
        
        }
        
    }

}
