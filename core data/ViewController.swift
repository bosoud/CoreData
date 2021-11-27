//
//  ViewController.swift
//  core data
//
//  Created by Abdulwahab alkharraz on 26/11/2021.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    // container is DataBase get from AppDelegate
    var container: NSPersistentContainer!
    var context: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    @IBOutlet weak var DataTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard container != nil else {
            fatalError("No persistent container")
        }
        context = container.viewContext
        appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    @IBAction func SaveCoreData(_ sender: Any) {
        print("Saving Data..")
        let user = UserEntity(context: context)
        let array = ["Abdulwahab", "Hello World", "BoSoud", "my Core Data"]
        if DataTxt.text!.isEmpty {
            user.name = array.randomElement()!
        }else {
            user.name = DataTxt.text
        }
        DataTxt.text?.removeAll()
        appDelegate.saveContext()
        
        print(user.name as Any)
        
    }
    
    @IBAction func LoadCoreData() {
        
        print("Fetching Data..")
        
        if DataTxt.text!.isEmpty {
            do {
                let request = UserEntity.fetchRequest()
                request.returnsObjectsAsFaults = false
                let result = try context.fetch(request)
                for data in result as [NSManagedObject] {
                    let userName = data.value(forKey: "name") as! String
                    print("User Name is : \(userName)")
                }
            } catch {
                print("Fetching data Failed")
            }
        } else {

            do {
                let request = UserEntity.fetchRequest()
                request.predicate = NSPredicate(format: "name = %@", DataTxt.text!)
                request.returnsObjectsAsFaults = false
                let result = try context.fetch(request)
                for data in result as [NSManagedObject] {
                    let userName = data.value(forKey: "name") as! String
                    print("User Name is : \(userName)")
                }
            } catch {
                print("Fetching data Failed")
                
            }
        }
    }

    
    
    
}




