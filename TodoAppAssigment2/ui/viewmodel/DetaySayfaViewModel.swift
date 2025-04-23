//
//  DetaySayfaViewModel.swift
//  TodoAppAssigment2
//
//  Created by Ulgen on 21.04.2025.
//

import Foundation

class DetaySayfaViewModel {
    var tasksRepository = TasksRepository()
    
    func guncelle(task_id:Int,task_name:String){
        tasksRepository.guncelle(tasks_id:task_id, task_name:task_name)
        }
}
