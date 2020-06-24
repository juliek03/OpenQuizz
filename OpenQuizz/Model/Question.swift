//
//  Question.swift
//  OpenQuizz
//
//  Created by Neko on 19/06/2020.
//  Copyright © 2020 Neko. All rights reserved.
//

import Foundation

class Question {
    var title = ""
    var isCorrect = false
    
    init(title: String, isCorrect: Bool) {
        self.title = title
        self.isCorrect = isCorrect
    }
}
