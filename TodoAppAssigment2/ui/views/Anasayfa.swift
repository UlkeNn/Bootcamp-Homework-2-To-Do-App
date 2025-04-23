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
    
    var anasayfaViewModel = AnasayfaViewModel()//init metodu çalışacak bağlantı da kurulacak repo ile vm arasında
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self//Anasayfayı Delegate ile bağlama
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        _ = anasayfaViewModel.taskList.subscribe(onNext: { list in
            self.taskList = list
            self.tasksTableView.reloadData()
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)//burası tam bilmiyorum!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        print("ViewWillAppear Çalıştı")
        anasayfaViewModel.gorevleriYukle()
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
        anasayfaViewModel.ara(aramaKelimesi: searchText)//->VM->Repo bağlandı
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
                self.anasayfaViewModel.sil(id: t.task_id!)
                
                
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
