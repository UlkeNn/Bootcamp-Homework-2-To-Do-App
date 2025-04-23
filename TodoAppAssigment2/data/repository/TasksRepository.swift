//
//  TasksRepository.swift
//  TodoAppAssigment2
//
//  Created by Ulgen on 21.04.2025.
//

import Foundation
import RxSwift

class TasksRepository {
    var taskList = BehaviorSubject<[Tasks]>(value: [Tasks]())//Rxswift kodu
    let db: FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniYolu = URL(fileURLWithPath: hedefYol).appendingPathComponent("todo_app.sqlite")
        db = FMDatabase(path: veritabaniYolu.path)
        //veritanına erişim sağlandı
    }
    
    
    
    
    func guncelle(tasks_id:Int,task_name:String){
        db?.open()
        
        do {
            try db?.executeUpdate("UPDATE toDos SET name = ? WHERE id = ?", values: [task_name,tasks_id])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        }
    
    func kaydet(task_name: String){
        
        db?.open()
        
        do {
            try db?.executeUpdate("INSERT INTO toDos (name) VALUES (?)", values: [task_name])
        }catch{
            print(error.localizedDescription)
        }
        
        
        
        db?.close()
    }
    func ara(aramaKelimesi: String){
        db?.open()
        do{
            var list = [Tasks]()
            
            //let result = try db!.executeQuery("SELECT * FROM toDos WHERE name LIKE ?", values: ["%\(aramaKelimesi)%"])
            let result = try db!.executeQuery("SELECT * FROM toDos WHERE name LIKE '%\(aramaKelimesi)%'", values: nil)
            
            
            while result.next(){
                let task_id = Int(result.string(forColumn: "id"))!
                let task_name = result.string(forColumn: "name")!
                
                let task = Tasks(task_id: task_id, task_name: task_name)
                list.append(task)
                
            }
            taskList.onNext(list)//Tetikleme(Triger)!!!!!!!!!!!!!!!!!!!!!!!!
            
            
        }catch {
            print(error.localizedDescription)
        }
        
        
        db?.close()
    }
    
    
    func sil(tasks_id:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM toDos WHERE id = ?", values: [tasks_id])
        }catch {
            print(error.localizedDescription)
        }
        
        
        db?.close()
        
    }
    func gorevleriYukle(){
        db?.open()
        
        
        do {
            var list = [Tasks]()
            let result = try db!.executeQuery("SELECT * FROM toDos", values: nil)
            
            while result.next(){
                let task_id = Int(result.string(forColumn: "id"))!
                let task_name = result.string(forColumn: "name")!
                
                let task = Tasks(task_id: task_id, task_name: task_name)
                list.append(task)
            }
            taskList.onNext(list)//Tetikleme(Triger)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        
    }
    
    
    
}
