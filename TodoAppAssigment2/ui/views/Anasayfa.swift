//
//  ViewController.swift
//  TodoAppAssigment2
//
//  Created by Ulgen on 18.04.2025.
//

import UIKit

class Anasayfa: UIViewController{
    
    @IBOutlet weak var tasksTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var taskList = [Tasks]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self//Anasayfayı Delegate ile bağlama
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        let t1 = Tasks(task_id: 1,task_name: "Yemek")
        let t2 = Tasks(task_id: 2,task_name: "Ödev")
        let t3 = Tasks(task_id: 3,task_name: "Temizlik")
        taskList.append(t1)
        taskList.append(t2)
        taskList.append(t3)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay"{
            if let task = sender as? Tasks{
                let gidilecekVC = segue.destination as! DetaySayfa
                gidilecekVC.task = task
            }
        }
    }
    
}
//Searchbarın protocol ve fonku
extension Anasayfa: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Task ara: \(searchText)")
    }
}

extension Anasayfa:  UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let t = taskList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksCell") as! TasksCell//labellara erişmek için hem id hem de class yazma
        cell.labelTaskName.text = t.task_name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let t = taskList[indexPath.row]
        print("Seçilen görev \(t.task_name!)")
        performSegue(withIdentifier: "toDetay", sender: t)
        tableView.deselectRow(at: indexPath, animated: true)//gri seçilmiş göstergesi kalkar!!!!!!!!
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil") {UIContextualAction, view, bool in
            let t = self.taskList[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(t.task_name!) adlı görev silindi", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            let evetAction = UIAlertAction(title: "evet", style: .destructive){action in
                print("Kisi sil: \(t.task_name!)")
                
                
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
