//
//  ViewController.swift
//  SideMenu2
//
//  Created by Suresh Murugaiyan on 8/18/17.
//  Copyright © 2017 dreamorbit. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MenuSelection {

    func selectedItem(sItem: String) {
        
        resetSideMenu()
        if selectedController == sItem {
            return
        }
        selectedController=sItem
        lbl_header.text=selectedController
        print("viewcontroller---->\(sItem)")
        
        if sItem == "Profile" {
            if let tempVC = profileVC {
                addChildViewController(tempVC)
                containerVCs.addSubview((tempVC.view)!)
                tempVC.view.frame=containerVCs.bounds
                tempVC.didMove(toParentViewController: self)
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                profileVC=storyboard.instantiateViewController(withIdentifier: "ProfileController") as? ProfileController
                addChildViewController(profileVC!)
                containerVCs.addSubview((profileVC?.view)!)
                profileVC?.view.frame=containerVCs.bounds
                profileVC?.didMove(toParentViewController: self)
            }
        }else if sItem == "News" {
            
            if let tempVC = newsVC {
                addChildViewController(tempVC)
                containerVCs.addSubview((tempVC.view)!)
                tempVC.view.frame=containerVCs.bounds
                tempVC.didMove(toParentViewController: self)
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                newsVC=storyboard.instantiateViewController(withIdentifier: "NewsController") as? NewsController
                addChildViewController(newsVC!)
                containerVCs.addSubview((newsVC?.view)!)
                newsVC?.view.frame=containerVCs.bounds
                newsVC?.didMove(toParentViewController: self)
            }
            
        }else if sItem == "Notifications" {
            
            if let tempVC = notificationVC {
                addChildViewController(tempVC)
                containerVCs.addSubview((tempVC.view)!)
                tempVC.view.frame=containerVCs.bounds
                tempVC.didMove(toParentViewController: self)
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                notificationVC=storyboard.instantiateViewController(withIdentifier: "NotificationsController") as? NotificationsController
                addChildViewController(notificationVC!)
                containerVCs.addSubview((notificationVC?.view)!)
                notificationVC?.view.frame=containerVCs.bounds
                notificationVC?.didMove(toParentViewController: self)
            }
            
        }else if sItem == "Home" {
            
            if let tempVC = homesVC {
                addChildViewController(tempVC)
                containerVCs.addSubview((tempVC.view)!)
                tempVC.view.frame=containerVCs.bounds
                tempVC.didMove(toParentViewController: self)
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                homesVC=storyboard.instantiateViewController(withIdentifier: "HomeController") as? HomeController
                addChildViewController(homesVC!)
                containerVCs.addSubview((homesVC?.view)!)
                homesVC?.view.frame=containerVCs.bounds
                homesVC?.didMove(toParentViewController: self)
            }
            
        }
//        let alert = UIAlertController(title: "Selected item", message: sItem, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        alert.addAction(okAction)
//        self.present(alert, animated: true, completion: nil)
        
    }
    
    let reduceWidth:CGFloat = 50.0
    
    var previuosVal,currentVal:CGFloat?
    var isSideMenuViewAdded:Bool? = false
    var isSideMenuShowing:Bool = false
    var alphaVal:CGFloat?
    var sideMenuWidth:CGFloat?
    
    var sideMenUView:SideMenuView?
    
    var profileVC:ProfileController?
    var newsVC:NewsController?
    var homesVC:HomeController?
    var notificationVC:NotificationsController?
    var selectedController:String!
    
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var containerVCs: UIView!
    @IBOutlet weak var lbl_header: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewBackground.isHidden=true
        
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(pannMenuAction(panGes:)))
        self.view.addGestureRecognizer(panGesture)
    }

    override func viewDidLayoutSubviews() {
        if isSideMenuViewAdded==false {
            isSideMenuViewAdded=true
            sideMenUView = UINib(nibName: "SidemenuView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? SideMenuView
            let xVal = self.view.frame.size.width-50
            alphaVal=1.0/xVal
            sideMenUView?.delegate=self
            sideMenUView!.frame=CGRect(x: -xVal, y: 0, width: xVal, height: self.view.frame.size.height)
            sideMenuWidth=sideMenUView?.frame.size.width
            self.view.addSubview(sideMenUView!)
            viewBackground.alpha=0
            selectedController="Home"
            lbl_header.text=selectedController
            
            // For home controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            homesVC=storyboard.instantiateViewController(withIdentifier: "HomeController") as? HomeController
            addChildViewController(homesVC!)
            containerVCs.addSubview((homesVC?.view)!)
            homesVC?.view.frame=containerVCs.bounds
            homesVC?.didMove(toParentViewController: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func menuAction(_ sender: Any) {
        viewBackground.isHidden=false
        //        self.viewBackground.alpha=1.0
        showSideMenu()
    }
    @IBAction func tapAction(_ sender: Any) {
        resetSideMenu()
    }
    func pannMenuAction(panGes:UIPanGestureRecognizer) {
        
        if panGes.state==UIGestureRecognizerState.began {
            
            print("began")
            
        }else if panGes.state==UIGestureRecognizerState.changed{
            //            print(panGes.translation(in: self.view))
            
            let tempPoint:CGPoint = panGes.translation(in: self.view)
            //            print(tempPoint)
            
            
            if tempPoint.x>0 {
                if currentVal==nil {
                    currentVal=tempPoint.x
                }else{
                    
                    
                    viewBackground.isHidden=false
                    
                    
                    previuosVal=currentVal
                    currentVal=tempPoint.x
                    
                    //                if (sideMenUView?.frame.origin.x)!<0 {
                    let travalVal = currentVal!-previuosVal!
                    //                    print(travalVal)
                    let tempVal = (sideMenUView?.frame.origin.x)!+travalVal
                    
                    if tempVal<0 {
                        //                        print("----------")
                        sideMenuMovingAnimation(tVal: tempVal)
                    }else{
                        //                        print("+++++++++++")
                        sideMenuMovingAnimation(tVal: 0)
                        isSideMenuShowing=true
                    }
                    
                    //                }
                    
                }
            }else if tempPoint.x<0 && isSideMenuShowing==true{
                
                if currentVal==nil {
                    currentVal=tempPoint.x
                }else{
                    
                    previuosVal=currentVal
                    currentVal=tempPoint.x
                    
                    //                if (sideMenUView?.frame.origin.x)!<0 {
                    let travalVal = currentVal!-previuosVal!
                    //                    print(travalVal)
                    let tempVal = (sideMenUView?.frame.origin.x)!+travalVal
                    
                    if tempVal<0 {
                        //                        print("----------")
                        sideMenuMovingAnimation(tVal: tempVal)
                    }else{
                        //                        print("+++++++++++")
                        sideMenuMovingAnimation(tVal: 0)
                        isSideMenuShowing=true
                    }
                    
                    //                }
                    
                }
            }
            
        }else if panGes.state==UIGestureRecognizerState.ended{
            print("ended")
            
            var tVal=self.view.frame.size.width-reduceWidth
            tVal = -tVal
            
            if isSideMenuShowing==false {
                
                if let tempK = currentVal {
                    if tempK > 0 {
                        let tempWidth:Double = Double((sideMenUView?.frame.size.width)!/2)
                        let tempX:Double = Double((sideMenUView?.frame.origin.x)!)
                        
                        let orX = (sideMenUView?.frame.origin.x)!
                        
                        let kVal = orX - tVal
                        
                        //                        print(kVal)
                        
                        if kVal<80 {
                            
                            showSideMenu()
                            
                        }else{
                            
                            if -tempWidth < tempX {
                                showSideMenu()
                            }else{
                                
                                resetSideMenu()
                            }
                        }
                    }
                }
                
            }else{
                if currentVal == nil {
                    resetSideMenu()
                }else{
                    let kTempVal2:CGFloat = 0
                    
                    if currentVal!<kTempVal2 {
                        resetSideMenu()
                    }else{
                        currentVal=nil
                        previuosVal=nil
                    }
                }
            }
            
        }else if panGes.state==UIGestureRecognizerState.cancelled{
            print("cancelled")
        }else if panGes.state==UIGestureRecognizerState.failed{
            print("failed")
        }
    }

    func sideMenuMovingAnimation(tVal:CGFloat) {
        
        let tempVal = sideMenuWidth!+tVal
        let tempAplha = tempVal*alphaVal!
        UIView.animate(withDuration: 0.1, animations: {
            
            self.sideMenUView!.frame=CGRect(x: tVal, y: 0, width: self.view.frame.size.width-self.reduceWidth, height: self.view.frame.size.height)
            self.viewBackground.alpha=tempAplha
        })
    }
    
    func resetSideMenu(){
        var tVal=self.view.frame.size.width-reduceWidth
        tVal = -tVal
        UIView.animate(withDuration: 0.2, animations: {
            
            self.sideMenUView?.frame.origin.x = tVal
            self.viewBackground.alpha=0
            
        }, completion: {(isFinished:Bool) in
            
            self.viewBackground.isHidden=true
            self.currentVal=nil
            self.previuosVal=nil
            self.isSideMenuShowing=false
        } )
    }

    func showSideMenu(){
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.sideMenUView?.frame.origin.x = 0
            self.viewBackground.alpha=1.0
            
        }, completion: {(isFinished:Bool) in
            
            self.currentVal=nil
            self.previuosVal=nil
            self.isSideMenuShowing=true
        } )
    }

}

