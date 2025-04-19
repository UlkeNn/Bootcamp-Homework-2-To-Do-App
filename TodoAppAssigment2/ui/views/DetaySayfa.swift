//
//  DetaySayfa.swift
//  TodoAppAssigment2
//
//  Created by Ulgen on 18.04.2025.
//

import UIKit

class DetaySayfa: UIViewController {
    
    @IBOutlet weak var tfTask: UITextField!
    
    var task: Tasks?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = task {
            tfTask.text = task.task_name
        }
        
        
    }
    

    @IBAction func buttonGuncelle(_ sender: Any) {
        if let tn = tfTask.text,let t = task{
            guncelle(task_id: t.task_id!, task_name: tn)
        }

        
        
    }
    
    func guncelle(task_id: Int,task_name: String){
        print("görev guncellendi: \(task_id)-\(task_name)")
    }
    
}
