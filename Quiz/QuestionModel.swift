//
//  QuestionModel.swift
//  Quiz
//
//  Created by Eric Dockery on 1/3/17.
//  Copyright © 2017 Eric Dockery. All rights reserved.
//

import Foundation

class Questions {
    let questions: Array<String>
    let answers: Array<String>
    
    init(questions: Array<String>, answers: Array<String>){
        self.questions = questions
        self.answers = answers
    }
}
