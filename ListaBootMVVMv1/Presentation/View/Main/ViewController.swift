//
//  ViewController.swift
//  ListaBootMVVMv1
//
//  Created by ibautista on 3/11/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //Load Bootcamps Button
    @IBAction func LoadBootButton(_ sender: Any) {
        let vc = BootTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

