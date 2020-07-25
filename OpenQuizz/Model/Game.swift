//
//  Game.swift
//  OpenQuizz
//
//  Created by Neko on 19/06/2020.
//  Copyright © 2020 Neko. All rights reserved.
//

import Foundation

class Game {
    var score = 0

    private var questions = [Question]()
    private var currentIndex = 0

    var state: State = .ongoing

    enum State {
        case ongoing, over
    }

    var currentQuestion: Question {
        return questions[currentIndex]
    }

///When the user presses the New Game button
    func refresh() {
        score = 0
        currentIndex = 0
        state = .over
        
        QuestionManager.shared.get { (questions) in
            self.questions = questions
            self.state = .ongoing
            
            let name = Notification.Name(rawValue: "QuestionLoaded")
            let notification = Notification(name: name)
            NotificationCenter.default.post(notification)
        }
    }
    
///When the user answers a question
    func answerCurrentQuestion(with answer: Bool) {
        if (currentQuestion.isCorrect && answer) || (!currentQuestion.isCorrect && !answer) {
            score += 1
        }
        goToNextQuestion()
    }

///To move on to the next question
    private func goToNextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
        } else {
            finishGame()
        }
    }

///Shows when the game is over
    private func finishGame() {
        state = .over
    }
}
