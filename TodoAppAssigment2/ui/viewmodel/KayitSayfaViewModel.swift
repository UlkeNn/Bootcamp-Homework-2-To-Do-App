//
//  KayitSayfaViewModel.swift
//  TodoAppAssigment2
//
//  Created by Ulgen on 21.04.2025.
//

import Foundation

class KayitSayfaViewModel{
    var tasksRepository = TasksRepository()
    
    func kaydet(task_name: String){
        tasksRepository.kaydet(task_name: task_name)
    }
    
    
}
