//
//  LocalStorageController.swift
//  Conscious
//
//  Created by Thomas Cowern New on 1/25/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation

//func fileURL() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let documentsDirectory = paths[0]
//        let fileName = "actionplandetail.json"
//        let fullURL = documentsDirectory.appendingPathComponent(fileName)
//
//        print(fullURL)
//
//        return(fullURL)
//    }
//
//    func saveToPersistentStore() {
//        let encoder = JSONEncoder()
//        do {
//            let data = try encoder.encode(ActionPlanDetail)
//            try data.write(to: fileURL())
//        } catch {
//            print("Error: \(#function): \(error) : \(error.localizedDescription)")
//        }
//    }
//
//    func loadFromPersistenceStore() -> [ActionPlanDetail] {
//        do {
//            let data = try Data(contentsOf: fileURL())
//            let decoder = JSONDecoder()
//            let alarms = try decoder.decode([ActionPlanDetail].self, from: data)
//            return alarms
//        } catch  {
//            print("Error: \(#function): \(error) : \(error.localizedDescription)")
//        }
//
//        return []
//    }

