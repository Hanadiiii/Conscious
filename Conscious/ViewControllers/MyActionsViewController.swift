//
//  MyActionsViewController.swift
//  Conscious
//
//  Created by Thomas Cowern New on 1/18/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class MyActionsViewController: UIViewController {
    
    @IBOutlet weak var myActionsTableview: UITableView!
    @IBOutlet weak var actionsCompleteLabel: UILabel!
    @IBOutlet weak var actionsPledged: UILabel!
    @IBOutlet weak var carbonSavedLabel: UILabel!
    
    var myActions: [ActionPlanDetail]  = []
    var actionsCompleted: [ActionPlanDetail]  = []
    var totalCarbonSavings: Double = 0
    var actionsCompletedCount: Int = 0
    var savedActions: [ActionPlanDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loadedActions: [ActionPlanDetail] = LocalStorageController.shared.loadFromPersistenceStore(path: "action")
        self.savedActions = loadedActions
        print("👠👠👠👠👠👠👠👠\(savedActions[0].completed)👠👠👠👠👠👠👠👠👠👠👠")
        myActions = savedActions
        print("🥼🥼🥼🥼🥼🥼🥼🥼🥼🥼\(myActions)🥼🥼🥼🥼🥼🥼🥼🥼🥼🥼")
        myActionsTableview.dataSource = self
        
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myActions = savedActions
        updateViews()
    }
    
    func updateViews() {
        myActions = savedActions
        actionsCompleteLabel.text = "\(actionsCompletedCount)"
        actionsPledged.text = " of \(myActions.count)"
        let carbonSavingString = String(format: "%.2f", totalCarbonSavings/52)
        carbonSavedLabel.text = "\(carbonSavingString) lbs of CO2e lbs saved!"
        myActionsTableview.reloadData()
    }
}

extension MyActionsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myActions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myActionsCell", for: indexPath) as! ActionTableViewCell
        cell.tag = indexPath.row
        cell.action = myActions[indexPath.row]
        cell.actionViewCellLabel.text = myActions[indexPath.row].action
        let buttonStatus = false
        if myActions[indexPath.row].completed == true {
            
        }
        let buttonStatus =
        cell.buttonStatus = myActions[indexPath.row].completed
        cell.delegate = self
        return cell
    }
}

extension MyActionsViewController: ActionTableViewCellDelegate {
    func actionChecked(for cell: ActionTableViewCell){
        guard let action = cell.action else { return }
        cell.action?.completed = true
        print(cell.tag)
        myActions[cell.tag].completed = true
        LocalStorageController.shared.saveActions(actions: myActions)
        actionsCompletedCount += 1
        let carbonReduction = (action.carbonReduction ?? 0)
        totalCarbonSavings += carbonReduction
        updateViews()
    }
    
    func actionUnchecked(for cell: ActionTableViewCell){
        guard let action = cell.action else { return }
        cell.action?.completed = false
        print(cell.tag)
        myActions[cell.tag].completed = false
        LocalStorageController.shared.saveActions(actions: myActions)
        actionsCompletedCount -= 1
        let carbonReduction = (action.carbonReduction ?? 0)
        totalCarbonSavings -= carbonReduction
        updateViews()
    }
}
