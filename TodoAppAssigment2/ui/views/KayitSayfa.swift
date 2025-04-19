//
//  KayitSayfa.swift
//  TodoAppAssigment2
//
//  Created by Ulgen on 18.04.2025.
//

import UIKit

class KayitSayfa: UIViewController {
    
    
    @IBOutlet weak var taskTextfield: UITextField!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func buttonKaydet(_ sender: Any) {
        if let tn = taskTextfield.text{
            kaydet(task_name: tn)
        }
           
        
    }
    
    
    
    func kaydet(task_name: String){
        print("görev kaydet: \(task_name)")
    }
    
    
    
    

}





