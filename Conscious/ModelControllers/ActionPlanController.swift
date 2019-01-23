//
//  ActionPlanController.swift
//  Conscious
//
//  Created by Hanadi AlOthman on 17/01/2019.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation

class ActionPlanController {
    
    static let shared = ActionPlanController()
    
    let foodActions: [String] = Categories.food.actionPlan
    let homeActions: [String] = Categories.home.actionPlan
    let travelActions: [String] = Categories.travel.actionPlan
    
//    func createActionPlan(dictOfResults: [String:Double]) {
//        let plan = []
//        for item in dictOfResults {
//            return food[0..<food.count*dictOfResults[item]]
//        }
//    }
}


