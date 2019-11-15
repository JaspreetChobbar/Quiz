//
//  QuestionsData.swift
//  Quiz
//
//  Created by MacStudent on 2019-11-12.
//  Copyright © 2019 Jaspreet. All rights reserved.
//

import UIKit

class QuestionsData {
    
    var question:String!
    var answer:String!
    var arr = [String]()
    
    init(ques: String, ans: String, opt: [String]) {
        self.question = ques
        self.answer = ans
        self.arr = opt
    }

}
