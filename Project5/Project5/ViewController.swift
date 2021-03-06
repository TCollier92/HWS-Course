//
//  ViewController.swift
//  Project5
//
//  Created by Tom Collier on 03/03/2020.
//  Copyright © 2020 Tom Collier. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let startWordsPath = Bundle.main.url(forResource: "start", withExtension: "txt")
        {
            if let startWords = try? String.init(contentsOf: startWordsPath)
            {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if (allWords.isEmpty)
        {
            allWords = ["silkworm"]
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        startGame()
    }

    @objc func addTapped(action: UIBarButtonItem)
    {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(_ answer: String)
    {
        let lowerAnswer = answer.lowercased()
        
        //let errorTitle : String
        //let errorMessage : String
        
        if(isReal(lowerAnswer))
        {
            if(isPossible(lowerAnswer))
            {
                if(isOriginal(lowerAnswer))
                {
                    usedWords.insert(lowerAnswer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                }
                else
                {
                    //errorTitle = "Word already used!"
                    //errorMessage = "You've already used that word"
                    showErrorMessage("You've already used that word", title: "Word already used!")
                }
            }
            else
            {
                //errorTitle = "Word not possible!"
                //errorMessage = "You can't make that word"
                showErrorMessage("You can't make that word", title: "Word not possible!")
            }
        }
        else
        {
            //errorTitle = "Word not real!"
            //errorMessage = "That's not a real word!"
            showErrorMessage("That's not a real word!", title: "Word not real")
        }
        
        
    }
    
    func isPossible(_ input: String) -> Bool
    {
        guard var tempWord = title?.lowercased() else { return false }

        for letter in input {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }

        return true
    }
    func isOriginal(_ input: String) -> Bool
    {
        return !usedWords.contains(input)
    }
    func isReal(_ input: String) -> Bool
    {
        if(input.count < 3)
        {
            return false;
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: input.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: input, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func showErrorMessage(_ message: String,title: String)
    {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func startGame(_ action: UIBarButtonItem? = nil)
    {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
}

