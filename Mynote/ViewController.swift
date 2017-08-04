//
//  ViewController.swift
//  Mynote
//
//  Created by apple on 2017/7/5.
//  Copyright © 2017年 swift006. All rights reserved.
//

import UIKit



class ViewController: UIViewController , UITextViewDelegate ,UINavigationControllerDelegate , UIImagePickerControllerDelegate {

    var vc2image:UIImage?
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textview: UITextView!
    private var btnCamera:UIButton?
    private var btnPain:UIButton?
    //let app = UIApplication.shared.delegate as! AppDelegate
        
    @IBOutlet weak var put: UIBarButtonItem!
    
    
    @IBAction func putdraw(_ sender: Any) {
        
        var attributedString : NSMutableAttributedString!
        attributedString = NSMutableAttributedString(attributedString: textview.attributedText)
        let textAttachment = NSTextAttachment()
        textAttachment.image = vc2image
        let oldWidth = textAttachment.image!.size.width
        let scaleFactor = oldWidth / (textview.frame.size.width - 200)//大小
        textAttachment.image = UIImage(cgImage: textAttachment.image!.cgImage!, scale: scaleFactor, orientation: .up)
        let attStringWithImage = NSAttributedString(attachment: textAttachment)
        attributedString.append(attStringWithImage)
        textview.attributedText = attributedString
        

        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //取得拍下的照片
        let image = info[UIImagePickerControllerOriginalImage] as!  UIImage
    
                
        //將相片存擋
        var attributedString : NSMutableAttributedString!
        attributedString = NSMutableAttributedString(attributedString: textview.attributedText)
        let textAttachment = NSTextAttachment()
        textAttachment.image = image
        let oldWidth = textAttachment.image!.size.width
        let scaleFactor = oldWidth / (textview.frame.size.width - 200)//大小
        textAttachment.image = UIImage(cgImage: textAttachment.image!.cgImage!, scale: scaleFactor, orientation: .up)
        let attStringWithImage = NSAttributedString(attachment: textAttachment)
        attributedString.append(attStringWithImage)
        textview.attributedText = attributedString
       

        dismiss(animated: true, completion: nil)
        let imagedata = UIImagePNGRepresentation(image)
        let compresedimage = UIImage(data: imagedata!)
        UIImageWriteToSavedPhotosAlbum(compresedimage!, nil, nil, nil)
        
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func btnpain(){
      
       let p2 =  self.storyboard?.instantiateViewController(withIdentifier: "drawVC") as! drawVC // 製作drawVC物件實體
        p2.vc1controller = self
            self.navigationController?.pushViewController(p2, animated: true)
    }
    
    func btncamera (){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePikerVC = UIImagePickerController()
            //設定相片來源為相機
            imagePikerVC.sourceType = .camera
            imagePikerVC.delegate = self
            show(imagePikerVC , sender:self)
            
        }
               print("拍照")
    }
    
    func keyboardChange (notification:Notification){
        let userInfo = notification.userInfo!
        let keyboardEndFrameScreenCoordinates = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = self.view.convert(keyboardEndFrameScreenCoordinates, to: view.window)
        if notification.name == Notification.Name.UIKeyboardWillHide{
            textview.contentInset = UIEdgeInsets.zero
        }else{
            textview.contentInset = UIEdgeInsetsMake(0, 0, keyboardEndFrame.height + 10, 0)
            
            
            
            
            
            textview.scrollIndicatorInsets = textview.contentInset
        }
        textview.scrollRangeToVisible(textview.selectedRange)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let mytb = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        
        btnPain = UIButton(type: UIButtonType.system)
        btnPain?.frame = CGRect(x: 60, y: 0, width: 40, height: 40)
        btnPain?.setImage(#imageLiteral(resourceName: "brush"), for: UIControlState.normal)
        mytb.addSubview(btnPain!)
        
        btnPain?.addTarget(self, action: #selector(btnpain), for: UIControlEvents.touchUpInside)

        
        
        
        btnCamera = UIButton(type: UIButtonType.system)
        btnCamera?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btnCamera?.setImage(#imageLiteral(resourceName: "camera.png"), for: UIControlState.normal)
        mytb.addSubview(btnCamera!)
        
        btnCamera?.addTarget(self, action: #selector(btncamera), for: UIControlEvents.touchUpInside)
        
        textview.inputAccessoryView = mytb
        self.textview.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardChange(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardChange(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        
        
        
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.textview.resignFirstResponder()
        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

