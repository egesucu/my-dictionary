//
//  homeViewController.swift
//  Meine Erinnerung
//
//  Created by Ege Sucu on 06.07.18.
//  Copyright © 2018 Ege Sucu. All rights reserved.
//

import UIKit
import CoreData

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWord = wordList[indexPath.row]
        selectedGermanWord = germanWordList[indexPath.row]
        performSegue(withIdentifier: "seeDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "word") {
            cell.textLabel?.text = wordList[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    
}


class HomeViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    private var wordList = [String]()
    private var germanWordList = [String]()
    private var selectedWord = ""
    private var selectedGermanWord = ""
    var appDelegate: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return AppDelegate()}
        return delegate
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "seeDetail"){
            let destination = segue.destination as! WordViewController
            destination.selectedWord = selectedWord
            destination.selectedGermanWord = selectedGermanWord
        } else if(segue.identifier == "addWord") {
        }
        
    }
    
    func fetchData(){
        wordList.removeAll(keepingCapacity: false)
        germanWordList.removeAll(keepingCapacity: false)
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "WordList")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            for data in result{
                let word = data.value(forKey: "word") as? String ?? ""
                let germanWord = data.value(forKey: "germanWord") as? String ?? ""
                wordList.append(word)
                germanWordList.append(germanWord)
            }
        } catch{
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
}

