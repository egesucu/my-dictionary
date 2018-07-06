//
//  wordViewController.swift
//  Meine Erinnerung
//
//  Created by Ege Sucu on 06.07.18.
//  Copyright © 2018 Ege Sucu. All rights reserved.
//

import UIKit

class wordViewController: UIViewController {
    
    var selectedWord = ""
    var selectedGermanWord = ""
    
    @IBOutlet weak var word: UILabel!
    @IBOutlet weak var germanWord: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        word.text = selectedWord
        germanWord.text = selectedGermanWord
    }

    
}
