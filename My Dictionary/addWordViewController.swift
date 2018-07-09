//
//  addWordViewController.swift
//  Meine Erinnerung
//
//  Created by Ege Sucu on 06.07.18.
//  Copyright © 2018 Ege Sucu. All rights reserved.
//

import UIKit
import CoreData

class addWordViewController: UIViewController {
    
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var germanWordTextField: UITextField!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func speichernButton(_ sender: Any) {
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "WordList", in: context)
        
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        let word : String = wordTextField.text!
        let germanWord : String = germanWordTextField.text!
        newEntity.setValue(word, forKey: "word")
        newEntity.setValue(germanWord, forKey: "germanWord")
        
        do{
            try context.save()
        } catch{
            print(error.localizedDescription)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}
