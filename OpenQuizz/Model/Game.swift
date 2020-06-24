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

///Quand l'utilisateur appuie sur le bouton New Game
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
    
///Quand l'utilisateur répond à une question
    func answerCurrentQuestion(with answer: Bool) {
        if (currentQuestion.isCorrect && answer) || (!currentQuestion.isCorrect && !answer) {
            score += 1
        }
        goToNextQuestion()
    }

///Pour passer à la question suivante
    private func goToNextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
        } else {
            finishGame()
        }
    }

///Affiche quand la partie est fini
    private func finishGame() {
        state = .over
    }
}
