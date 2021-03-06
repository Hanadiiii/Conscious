//
//  UserResultsViewController.swift
//  Conscious
//
//  Created by Hanadi AlOthman on 22/01/2019.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class UserResultsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var foodScoreLabel: UILabel!
    @IBOutlet weak var foodGraph: UIView!
    @IBOutlet weak var houseScoreLabel: UILabel!
    @IBOutlet weak var houseGraph: UIView!
    @IBOutlet weak var travelScoreLabel: UILabel!
    @IBOutlet weak var travelGraph: UIView!
    @IBOutlet weak var treesLabel: UILabel!
    @IBOutlet weak var treesImageView: UIImageView!
    @IBOutlet weak var trashLabel: UILabel!
    @IBOutlet weak var trashImageView: UIImageView!
    @IBOutlet weak var gasLabel: UILabel!
    @IBOutlet weak var gasImageView: UIImageView!
    @IBOutlet weak var foodWidthGraph: NSLayoutConstraint!
    @IBOutlet weak var houseWidthGraph: NSLayoutConstraint!
    @IBOutlet weak var travelWidthGraph: NSLayoutConstraint!
    @IBOutlet weak var staticFoodLabel: UILabel!
    @IBOutlet weak var staticHomeLabel: UILabel!
    @IBOutlet weak var staticTravelLabel: UILabel!
    @IBOutlet weak var takeActionButton: UIButton!
    
    var seguedFromFootPrintVC: Bool = false
    
    // Raw scores
    var totalScore: Double = 1.0
    var foodScore: Double = 1.0
    var houseScore: Double = 1.0
    var travelScore: Double = 1.0
    
    // Green Scores
    var foodPercentage: CGFloat = 0.0
    var housePercentage: CGFloat = 0.0
    var travelPercentage: CGFloat = 0.0
    
    // Local storage
    var savedData: [SavedData] = []
    var isNewQuiz: Bool = false
    var question: Question?
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if seguedFromFootPrintVC {
            takeActionButton.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if LocalStorageController.shared.isNewQuiz == true {
            print("💊💊💊💊💊💊New Quiz💊💊💊💊💊💊")
            getNewResults()
            updateViews()
            setScoreImage()
        } else {
            print("Saved Data")
            getSavedData()
            updateViews()
            setScoreImage()
        }
    }
    
    func getNewResults () {
        totalScore = GreenCalculatorController.shared.totalScoreCard()
        
        if totalScore == 0 {
            totalScore = 1.0
        }
        
        foodScore = GreenCalculatorController.shared.calculateFoodScore() ?? 1.0
        
        houseScore = GreenCalculatorController.shared.calculateHouseScore() ?? 1.0
        
        travelScore = GreenCalculatorController.shared.calculateTravelScore() ?? 1.0
        
        setFoodGraph(foodScore, totalScore)
        setHouseGraph(houseScore, totalScore)
        setTravelGraph(travelScore, totalScore)
        
        ActionPlanController.shared.addNewResults(overallScore: totalScore, foodScore: foodScore, houseScore: houseScore, travelScore: travelScore)
        
        LocalStorageController.shared.isNewQuiz = false
    }
    
    @IBAction func takeACTIONTAPPED(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func getSavedData () {
        let savedData: [SavedData] = ActionPlanController.shared.loadFromPersistenceStore(path: "data")
        print("👑👑👑👑👑👑👑👑\(savedData)👑👑👑👑👑👑👑👑👑")
        guard let savedDataLast = savedData.last else {
            print("⛑⛑⛑⛑⛑⛑⛑⛑Problem getting saved data⛑⛑⛑⛑⛑⛑⛑⛑⛑⛑")
            return
        }
        print("↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️\(savedDataLast)↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️↗️")
        totalScore = savedDataLast.overallScore == 0 ? 1.0 : savedDataLast.overallScore
        foodScore = savedDataLast.foodScore == 0 ? 1.0 : savedDataLast.foodScore
        houseScore = savedDataLast.houseScore == 0 ? 1.0 : savedDataLast.houseScore
        travelScore = savedDataLast.travelScore == 0 ? 1.0 : savedDataLast.travelScore
        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥savedData Count: \(savedData.count)🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
        print("\(totalScore)")
        print("\(foodScore)")
        print("\(houseScore)")
        print("\(travelScore)")
        
        setFoodGraph(foodScore, totalScore)
        setHouseGraph(houseScore, totalScore)
        setTravelGraph(travelScore, totalScore)
    }
    
    // MARK: - Graphs
    // FOOD
    func setFoodGraph(_ foodScore: Double, _ totalScore: Double){
        
        UIView.animate(withDuration: 2.5) {
            self.foodPercentage = CGFloat((foodScore/totalScore)*100)
            print(self.foodPercentage)
            self.foodWidthGraph.constant = self.foodPercentage * 3
            self.view.layoutIfNeeded()
        }
    }
    
    // HOUSE
    func setHouseGraph(_ houseScore: Double, _ totalScore: Double){
        UIView.animate(withDuration: 2.5) {
            self.housePercentage = CGFloat((houseScore/totalScore)*100)
            print(self.housePercentage)
            self.houseWidthGraph.constant =  self.housePercentage * 3
            self.view.layoutIfNeeded()
        }
    }
    
    // TRAVEL
    func setTravelGraph(_ travelScore: Double, _ totalScore: Double){
        UIView.animate(withDuration: 2.5) {
            self.travelPercentage = CGFloat((travelScore/totalScore)*100)
            print(self.travelPercentage)
            self.travelWidthGraph.constant =  self.travelPercentage * 3
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Images
    // Trees
    func setScoreImage() {
        let monthScore = round(totalScore / 12)
        let treeScore = round(totalScore / 13)
        let trashScore = round(totalScore / 2.29)
        let gasScore = round(totalScore / 8.88)
        if monthScore > 5000 {
            treesImageView.image = #imageLiteral(resourceName: "alltrees")
            trashImageView.image = #imageLiteral(resourceName: "Trash-US")
            gasImageView.image = #imageLiteral(resourceName: "Gas-US")
            treesLabel.text = "\(treeScore) trees will need to be planted to offset your carbon emissions "
            trashLabel.text = "Your score is equal to \(trashScore) bags of trash thrown into a landfill"
            gasLabel.text = "Or \(gasScore) gallons of gas burned"
        } else if monthScore > 4000 {
            treesImageView.image = #imageLiteral(resourceName: "4trees")
            trashImageView.image = #imageLiteral(resourceName: "5 bags")
            gasImageView.image = #imageLiteral(resourceName: "4 gaspumps")
            treesLabel.text = "\(treeScore) trees will need to be planted to offset your carbon emissions "
            trashLabel.text = "Your score is equal to \(trashScore) bags of trash thrown into a landfill"
            gasLabel.text = "Or \(gasScore) gallons of gas burned"
        } else if monthScore > 3000 {
            treesImageView.image = #imageLiteral(resourceName: "3 trees")
            trashImageView.image = #imageLiteral(resourceName: "4 bags")
            gasImageView.image = #imageLiteral(resourceName: "3 gaspumps")
            treesLabel.text = "\(treeScore) trees will need to be planted to offset your carbon emissions "
            trashLabel.text = "Your score is equal to \(trashScore) bags of trash thrown into a landfill"
            gasLabel.text = "Or \(gasScore) gallons of gas burned"
        } else if monthScore > 2000 {
            treesImageView.image = #imageLiteral(resourceName: "2 trees")
            trashImageView.image = #imageLiteral(resourceName: "3 bags")
            gasImageView.image = #imageLiteral(resourceName: "2 gaspumps")
            treesLabel.text = "\(treeScore) trees will need to be planted to offset your carbon emissions "
            trashLabel.text = "Your score is equal to \(trashScore) bags of trash thrown into a landfill"
            gasLabel.text = "Or \(gasScore) gallons of gas burned"
            
        } else {
            treesImageView.image = #imageLiteral(resourceName: "Tree")
            trashImageView.image = #imageLiteral(resourceName: "2 bags")
            gasImageView.image = #imageLiteral(resourceName: "1 gaspumps")
            treesLabel.text = "\(treeScore) trees will need to be planted to offset your carbon emissions "
            trashLabel.text = "Your score is equal to \(trashScore) bags of trash thrown into a landfill"
            gasLabel.text = "Or \(gasScore) gallons of gas burned"
        }
    }
    
    // MARK: - Setup
    func updateViews() {
        scoreLabel.text = String(format: "%.2f", totalScore/12)
        foodScoreLabel.text = String(format: "%.2f%%", foodPercentage)
        houseScoreLabel.text = String(format: "%.2f%%", housePercentage)
        travelScoreLabel.text = String(format: "%.2f%%", travelPercentage)
        setScoreImage()
    }
    
    // MARK: - Actions
    @IBAction func retakeQuizButtonTapped(_ sender: Any) {
        question?.selectedAnswers = []
    }
}
