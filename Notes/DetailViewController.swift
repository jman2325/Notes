//
//  DetailViewController.swift
//  Notes
//
//  Created by Jacob Bailey on 6/23/17.
//  Copyright © 2017 Jacob Bailey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var text: String = ""
    var masterView: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        textView.text = text
        textView.becomeFirstResponder()
        
    }
    
    func setText(text: String) {
        self.text = text
        if isViewLoaded{
            textView.text = text
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        masterView.newRowText = textView.text
    }

    
}




































































































