//
//  AnasayfaViewModel.swift
//  TodoAppAssigment2
//
//  Created by Ulgen on 21.04.2025.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var tasksRepository = TasksRepository()
    var taskList = BehaviorSubject<[Tasks]>(value: [Tasks]())//Rxswift kodu
    
    init () {
        //Burayı unutma
        veritabaniKopyala()
        taskList = tasksRepository.taskList//Bağlandığında otomatik çalışacak
        //gorevleriYukle()//buna bak!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    }
    
    func ara(aramaKelimesi: String) {
        tasksRepository.ara(aramaKelimesi: aramaKelimesi)
    }
    func sil(id: Int) {
        tasksRepository.sil(tasks_id: id)
        gorevleriYukle()
    }
    
    func gorevleriYukle() {
        tasksRepository.gorevleriYukle()
    }
    func veritabaniKopyala(){
            let bundleYolu = Bundle.main.path(forResource: "todo_app", ofType: ".sqlite")//sqlite'a erişim
            let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            // uygulama içindeki dosya yoluna erişiyor
            let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("todo_app.sqlite")//hedef yolun sonuna koyalama yap
            let fileManager = FileManager.default//kopyalandı mı kontrolü
            if fileManager.fileExists(atPath: kopyalanacakYer.path){
                print("Veritabanı zaten var")
            }else{
                do{
                    try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                }catch{}
            }
        }
}
