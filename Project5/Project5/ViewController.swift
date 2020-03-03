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
        
        if(isReal(lowerAnswer))
        {
            if(isPossible(lowerAnswer))
            {
                if(isOriginal(lowerAnswer))
                {
                    usedWords.insert(lowerAnswer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }
                else
                {
                    //not original
                }
            }
            else
            {
                //not possible
            }
        }
        else
        {
            //not real
        }
    }
    
    func isPossible(_ input: String) -> Bool
    {
        return true
    }
    func isOriginal(_ input: String) -> Bool
    {
        if(usedWords.contains(input))
        {
            return false
        }
        return true
    }
    func isReal(_ input: String) -> Bool
    {
        return true
    }
    
    func startGame()
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

