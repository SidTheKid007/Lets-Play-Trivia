//
//  Question.swift
//  History Trivia
//
//  Created by Siddhesvar Kannan on 10/1/20.
//  Copyright © 2020 Siddhesvar Kannan. All rights reserved.
//

import Foundation

struct Questions: Codable {
    var results: [Question]
}

struct Question: Codable {
    var difficulty: String
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
}
