//
//  ViewController.swift
//  LBMaskTextField
//
//  Created by Lucas Bordini Ribeiro de Araujo on 06/11/18.
//  Copyright © 2018 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var telephone: UITextField!
    @IBOutlet weak var document: UITextField!
    @IBOutlet weak var designable: LBMaskedTextField!
    
    let phoneMask = LBMaskTextField(mask: "+1 (000) 000-0000")
    let docMask = LBMaskTextField(mask: "000.000.000-##")

    override func viewDidLoad() {
        super.viewDidLoad()
        telephone.delegate = phoneMask
        document.delegate = docMask
    }
    
    @IBAction func printValues(_ sender: Any) {
        print(phoneMask.getValue())
        print(docMask.getValue())
        print(designable.getValue())
    }
    
}

