//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Timo den Hartog on 16-11-17.
//  Copyright © 2017 Timo den Hartog. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: GenreType
}

enum GenreType: Character {
    case house = "H", techno = "T", EDM = "E", dubstep = "D"

    var definition: String {
        switch self {
        case .house:
            return "You are House, the origin of everything dance. You have conquered the world by being revolutionary in ways of energy and rhythm. Having influenced everything that is Dance today, a father figure is hidden inside yourself."
        case .techno:
            return "You are Techno. As a harder form of House you are to be hated or loved. With an open-minded charater you are ready to develop through time and because of that, will never fail to excite many worldwide."
        case .EDM:
            return "You are EDM... You are relatvely new. Having gained huge popularity by being catchy and mostly formulaic, your fans are either young or uninterested in music."
        case .dubstep:
            return "You are Dubstep. You are a very special case by having evolved from a more minimal character to the more chaotic and commercial version you are now. Somewhere deep inside there's still quality to find, but it gets harder and harder as time elapses."
        }
    }
}





