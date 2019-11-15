//
//  TableViewController.swift
//  Quiz
//
//  Created by MacStudent on 2019-11-12.
//  Copyright © 2019 Jaspreet. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /*
    Create a native application for iPhone or iPad (or Universal) that tests the user knowledge of a certain topic. 
Your application should have at least 10 questions hard-coded and each time the user starts the application, 5 of these questions are selected randomly. 
For every question, user should select one option out of four options presented. UITableView and customized UITableViewCell should be used to show the questions and answers.
When the user answers the fifth question, the application should display the user’s score and one of the 
following messages depending on their score.
1. Score 0/5, 1/5 and 2/5 Message => “Please try again!”
2. Score 3/5 Message => “Good job!”
3. Score 4/5 Message => “Excellent work!”
4. Score 5/5 Message => “You are a genius!”
The topic for the questions should be chosen carefully and all the questions should be meaningful. All the questions should be based on the topic you have chosen.
If the score of the test is Option 1 (see above) user should be given an option to retake the quiz.
*/
    var quesarr:[QuestionsData] = []
    var quesarrrandom:[QuestionsData] = []
    var index = 0
    var correctanswer = 0
    var checked = false
    
    @IBOutlet weak var questionlabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextquesButton: UIButton!
    
    @IBOutlet weak var jsview: UIView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quesarr[0].arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        // ethe random lagu
        var indexAlreadySelected = [Int]()
        
        for _ in 0..<5{
            
            repeat{
                let number = Int.random(in: 0 ..< quesarr.count)
                
                if !indexAlreadySelected.contains(number){
                    indexAlreadySelected.append(number)
                    quesarrrandom.append(quesarr[number])
                    break
                }
                
            }while(true)
            
        }
        
        questionlabel.text = "Q\(index + 1). " + quesarrrandom[index].question
               
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
               cell.textLabel!.text = quesarrrandom[index].arr[indexPath.row]
               cell.accessoryView = .none
        // cell.accessoryType = .none
               cell.backgroundColor = UIColor(displayP3Red: 229/255.0, green: 228/255.0, blue: 255/255.0, alpha: 1)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(displayP3Red: 35/255.0, green: 159/255.0, blue: 95/255.0, alpha: 1)
        cell.selectedBackgroundView = backgroundView
               return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imgView.image = UIImage(named: "circle-cropped")!
        tableView.cellForRow(at: indexPath)?.accessoryView = imgView
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        let currentCell = tableView.cellForRow(at: indexPath)!

        if(quesarrrandom[index].answer == currentCell.textLabel!.text){
            correctanswer = correctanswer + 1
        }
        checked = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryView = .none
        // tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
 
    @IBAction func nextques(_ sender: Any) {
    
        if(!checked){
            let alert = UIAlertController(title: "Error...", message: "Check answer to proceed.", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }else{
            checked = false
        }
        
        if(index == 4){
            
            var result:String! = "Please try again!"
            
            if(correctanswer < 3){
                result = "Please try again!"
            }else if(correctanswer == 3){
                result = "Good job!"
            }else if(correctanswer == 4){
                result = "Excellent work!"
            }else if(correctanswer == 5){
                result = "You are a genius!"
            }
            
            let alert = UIAlertController(title: "Result...", message: "Score \(correctanswer)/5\n\(result!)", preferredStyle: .alert)

            if(correctanswer < 3){
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                    
                    self.quesarrrandom = []
                    self.index = 0
                    self.correctanswer = 0
                    self.checked = false
                    self.nextquesButton.setTitle("Next Question",for: .normal)
                    self.tableView.reloadData()
                    
                }))
            }
            
            
            alert.addAction(UIAlertAction(title: "Quit", style: .default, handler: { action in
                exit(0)
            }))

            self.present(alert, animated: true)
            
        }
        
        if(index < 4){
            index += 1
            tableView.reloadData()
        }
        
        if (index == 4){
            nextquesButton.setTitle("Show Results",for: .normal)
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        nextquesButton.layer.cornerRadius = 10
        jsview.layer.cornerRadius = 10
        tableView.layer.cornerRadius = 10
        
        var ques: String = Constant.ques1
        var ans: String = Constant.ans1
        var opt: [String] = []
        opt = Constant.arr1
        
        var q = QuestionsData(ques: ques, ans: ans, opt: opt)
        quesarr.append(q)

        ques = Constant.ques2
        ans = Constant.ans2
        opt = Constant.arr2
        
        q = QuestionsData(ques: ques, ans: ans, opt: opt)
        quesarr.append(q)
        
        ques = Constant.ques3
        ans = Constant.ans3
        opt = Constant.arr3
        
        q = QuestionsData(ques: ques, ans: ans, opt: opt)
        quesarr.append(q)
        
        ques = Constant.ques4
        ans = Constant.ans4
        opt = Constant.arr4
        
        q = QuestionsData(ques: ques, ans: ans, opt: opt)
        quesarr.append(q)
        
        ques = Constant.ques5
        ans = Constant.ans5
        opt = Constant.arr5
        
        q = QuestionsData(ques: ques, ans: ans, opt: opt)
        quesarr.append(q)
        
        ques = Constant.ques6
        ans = Constant.ans6
        opt = Constant.arr6
        
        q = QuestionsData(ques: ques, ans: ans, opt: opt)
        quesarr.append(q)
        
        ques = Constant.ques7
        ans = Constant.ans7
        opt = Constant.arr7
        
        q = QuestionsData(ques: ques, ans: ans, opt: opt)
        quesarr.append(q)
        
        ques = Constant.ques8
        ans = Constant.ans8
        opt = Constant.arr8
        
        q = QuestionsData(ques: ques, ans: ans, opt: opt)
        quesarr.append(q)
        
        ques = Constant.ques9
        ans = Constant.ans9
        opt = Constant.arr9
        
        q = QuestionsData(ques: ques, ans: ans, opt: opt)
        quesarr.append(q)
        
        ques = Constant.ques10
        ans = Constant.ans10
        opt = Constant.arr10
        
        q = QuestionsData(ques: ques, ans: ans, opt: opt)
        quesarr.append(q)
        
        
        quesarrrandom = []
        index = 0
        correctanswer = 0
        checked = false

        
    }

}
