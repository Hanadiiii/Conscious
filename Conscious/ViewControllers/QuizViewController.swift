//
//  QuizViewController.swift
//  Conscious
//
//  Created by Hanadi AlOthman on 17/01/2019.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var quizProgressView: UIProgressView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    // MARK: - Properties
    var food: Food?
    var house: House?
    var travel: Travel?
    var question: Question?
    var questionIndex = 0
    var allQs = GreenCalculatorController.shared.allQuestions
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.reloadData()
        self.question = allQs[questionIndex]
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.question = allQs[questionIndex]
        updateViews()
        tableView.reloadData()
    }
    
    // MARK: - Setup
    func updateViews() {
        let totalProgress = Float(questionIndex) / Float(allQs.count)
        self.question = allQs[questionIndex]
        categoryLabel.text = self.question?.category.rawValue
        questionLabel.text = self.question?.text
        quizProgressView.setProgress(totalProgress, animated: true)
        tableView.reloadData()
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < allQs.count {
            updateViews()
        } else {
            performSegue(withIdentifier: "scoreSegue", sender: nil)
        }
    }
    
    func previousQuestion() {
        questionIndex -= 1
        if questionIndex <= allQs.count {
            updateViews()
        } 
    }
    
    // MARK: - Actions
    @IBAction func nextButtonTapped(_ sender: Any) {
        nextQuestion()
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        previousQuestion()
    }
}

extension QuizViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return question?.possibleAnswers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! QuizTableViewCell
        let answer = question?.possibleAnswers[indexPath.row]
        tableView.delegate = self
        cell.answer = answer
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> UITableViewCell {
//        let selectedAnswer = question?.possibleAnswers[indexPath.row]
//
//        return cell
//    }
}

extension QuizViewController: UITableViewDelegate {
    
}
