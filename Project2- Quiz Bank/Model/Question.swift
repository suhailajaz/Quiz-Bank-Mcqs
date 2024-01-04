//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by suhail on 07/09/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

class Question{
    
    
    var text: String
    var answer: [String]
    var correctAnswer: String
    
    init(q: String, a: [String],ca:String) {
        self.text = q
        self.answer = a
        self.correctAnswer = ca
    }
}
