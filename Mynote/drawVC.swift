//
//  drawVC.swift
//  Mynote
//
//  Created by apple on 2017/7/10.
//  Copyright © 2017年 swift006. All rights reserved.
//

import UIKit

class drawVC: UIViewController {

        //let app = UIApplication.shared.delegate as! AppDelegate
    var vc1controller : ViewController?
   
    @IBOutlet weak var drawwing: drawwingVC!
    
    @IBAction func undodraw(_ sender: Any) {
        drawwing.undo()
    }
    
    @IBAction func savedraw(_ sender: Any) {
      let drawimg = drawwing.takeSnapshotOfView(view: drawwing)
        //app.img = drawimg
        self.vc1controller?.vc2image = drawimg
        print(self)

    }
       @IBAction func cleardraw(_ sender: Any) {
        drawwing.clear()
    }
    @IBAction func colorcontrol(_ sender: Any) {
    }
       @IBAction func fontsize(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
