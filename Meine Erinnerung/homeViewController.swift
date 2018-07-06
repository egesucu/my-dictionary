//
//  homeViewController.swift
//  Meine Erinnerung
//
//  Created by Ege Sucu on 06.07.18.
//  Copyright © 2018 Ege Sucu. All rights reserved.
//

import UIKit
import CoreData

class homeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var wordList = [String]()
    private var germanWordList = [String]()
    private var selectedWord = ""
    private var selectedGermanWord = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        tableView.reloadData()
    }
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWord = wordList[indexPath.row]
        selectedGermanWord = germanWordList[indexPath.row]
        
       performSegue(withIdentifier: "seeDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "seeDetail"){
            let destination = segue.destination as! wordViewController
            destination.selectedWord = selectedWord
            destination.selectedGermanWord = selectedGermanWord
        } else if(segue.identifier == "addWord") {
        }
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "word")
        cell?.textLabel?.text = wordList[indexPath.row]
        return cell!
    }
    
    
    func fetchData(){
        wordList.removeAll(keepingCapacity: false)
        germanWordList.removeAll(keepingCapacity: false)
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WordList")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                wordList.append(data.value(forKey: "word") as! String)
                germanWordList.append(data.value(forKey: "germanWord") as! String)
            }
        } catch{
            print(error.localizedDescription)
        }
        
        
        
    }
    
   
    
    

   


}

