//
//  ViewController.swift
//  Project2
//
//  Created by Tom Collier on 27/02/2020.
//  Copyright © 2020 Tom Collier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var teams = [String]()
    var correctAnswer = 0
    var score = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        teams.append("Atlanta_Reign")
        teams.append("Boston_Uprising")
        teams.append("Chengdu_Hunters")
        teams.append("Seoul_Dynasty")
        teams.append("Shanghai_Dragons")
        //teams += ["Atlanta_Reign", ...etc]
        
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor
        
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        
        teams.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        
        title = " \(teams[correctAnswer].replacingOccurrences(of: "_", with: " ")) (\(score))"
        
        button1.setImage(UIImage(named: teams[0]), for: .normal)
        button2.setImage(UIImage(named: teams[1]), for: .normal)
        button3.setImage(UIImage(named: teams[2]), for: .normal)
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String

        questionsAsked += 1
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)"
        } else {
            title = "Wrong"
            score -= 1
            message = "Nope, that's the \(teams[sender.tag].replacingOccurrences(of: "_", with: " "))"
        }
        
        if(questionsAsked == 10)
        {
            message = "Your final score is \(score)"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if(questionsAsked < 10)
        {
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }
        present(ac, animated: true)
    }
}

