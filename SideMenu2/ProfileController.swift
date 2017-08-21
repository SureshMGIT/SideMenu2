//
//  ProfileController.swift
//  SideMenu2
//
//  Created by Suresh Murugaiyan on 8/18/17.
//  Copyright © 2017 dreamorbit. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("viewDidLoad  ProfileController")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear  ProfileController")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func goToViewController(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let secondVC=storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        self.navigationController?.pushViewController(secondVC!, animated: true)
    }
}
