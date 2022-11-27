//
//  ViewController.swift
//  CreateWidget
//
//  Created by Issei Ueda on 2022/11/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        storeData(text: "メモを入力しよう")
    }

    @IBAction func btnStoreText(_ sender: Any) {
        storeData(text: txtText.text ?? "--")
    }
    
    func storeData(text : String) {
        let storedata = StoreData(showText: text)
        let primaryData = PrimaryData(storeData: storedata)
        primaryData.encodeData()
    }
}

