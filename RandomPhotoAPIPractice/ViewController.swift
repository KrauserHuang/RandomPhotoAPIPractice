//
//  ViewController.swift
//  RandomPhotoAPIPractice
//
//  Created by Tai Chin Huang on 2020/12/25.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var bgTextField: UITextField!
    @IBOutlet weak var fgTextField: UITextField!
    @IBOutlet weak var inputTextField: UITextField!
    
    var size = ""
    var bgColor = ""
    var fgColor = ""
    var text = ""
    var urlStr = ""
//    var data: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //產生URL
    func makeUrl() -> String {
        size = sizeTextField.text!
        bgColor = bgTextField.text!
        fgColor = fgTextField.text!
        text = inputTextField.text!
        let urlStr = "https://dummyimage.com/\(size)/\(bgColor)/\(fgColor)&text=\(text)"
        return urlStr
    }
    
    @IBAction func showResult(_ sender: UIButton) {
        let urlStr = makeUrl()
        let url = URL(string: urlStr)
        let controller = SFSafariViewController(url: url!)
        present(controller, animated: true, completion: nil)
    }
    @IBAction func sizeInput(_ sender: UITextField) {
        if (sizeTextField.text?.contains("x")) != nil {
            size = sizeTextField.text!
        } else {
            size = "\(sizeTextField.text!)x\(sizeTextField.text!)"
            sizeTextField.text = size
//            let controller = UIAlertController(title: "Please follow the template", message: "請輸入長x寬", preferredStyle: .alert)
//            let action = UIAlertAction(title: "cancel", style: .cancel) { (_) in
//                self.sizeTextField.text = "600x400"
//            }
//            controller.addAction(action)
//            present(controller, animated: true, completion: nil)
        }
    }
    @IBAction func bgInput(_ sender: UITextField) {
        switch bgTextField.text?.count {
        case 1:
            bgColor = String(repeating: sender.text!, count: 6)
            bgTextField.text = bgColor
            buttonView.backgroundColor = UIColor(named: bgColor)
        case 2:
            bgColor = String(repeating: sender.text!, count: 3)
            bgTextField.text = bgColor
            buttonView.backgroundColor = UIColor(named: bgColor)
        case 3:
            bgColor = String(repeating: sender.text!, count: 2)
            bgTextField.text = bgColor
//            buttonView.backgroundColor = UIColor(named: bgColor)
            buttonView.backgroundColor = UIColor(hex: bgColor, alpha: 1)
        case 6:
            bgColor = bgTextField.text!
            buttonView.backgroundColor = UIColor(hex: bgColor, alpha: 1)
        default:
            let controller = UIAlertController(title: "Please enter no more than 6 words", message: "請不要輸入符號!", preferredStyle: .alert)
            let action = UIAlertAction(title: "cancel", style: .cancel) { (_) in
                self.bgTextField.text = "ccccccc"
                self.buttonView.backgroundColor = UIColor.gray
            }
            controller.addAction(action)
            present(controller, animated: true, completion: nil)
        }
    }
    @IBAction func fgInput(_ sender: UITextField) {
        switch fgTextField.text?.count {
        case 1:
            fgColor = String(repeating: sender.text!, count: 6)
            fgTextField.text = fgColor
            buttonView.setTitleColor(UIColor(named: fgColor), for: .normal)
        case 2:
            fgColor = String(repeating: sender.text!, count: 3)
            fgTextField.text = fgColor
            buttonView.setTitleColor(UIColor(named: fgColor), for: .normal)
        case 3:
            fgColor = String(repeating: sender.text!, count: 2)
            fgTextField.text = fgColor
//            buttonView.setTitleColor(UIColor(named: fgColor), for: .normal)
            buttonView.setTitleColor(UIColor(hex: fgColor, alpha: 1), for: .normal)
        case 6:
            fgColor = fgTextField.text!
            buttonView.setTitleColor(UIColor(hex: fgColor, alpha: 1), for: .normal)
        default:
            let controller = UIAlertController(title: "Please enter no more than 6 words", message: "請不要輸入符號!", preferredStyle: .alert)
            let action = UIAlertAction(title: "cancel", style: .cancel) { (_) in
                self.fgTextField.text = "000000"
                self.buttonView.tintColor = UIColor.black
            }
            controller.addAction(action)
            present(controller, animated: true, completion: nil)
        }
    }
    @IBAction func textInput(_ sender: UITextField) {
        buttonView.setTitle(sender.text, for: .normal)
        text = inputTextField.text!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBSegueAction func nextpage(_ coder: NSCoder) -> CustomeImageViewController? {
        let newUrlStr = makeUrl()
        let controller = CustomeImageViewController(coder: coder)
        controller?.urlStr = newUrlStr
        return controller
    }
}
//將hexcolor轉換成rgb讓button可以及時換顏色
extension UIColor {
    public convenience init?(hex: String, alpha: CGFloat = 1) {
        let r,g,b: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat(((hexNumber&0xFF0000)>>16) / 255)
                    g = CGFloat(((hexNumber&0x00FF00)>>8) / 255)
                    b = CGFloat((hexNumber&0x00FF00) / 255)

                    self.init(red: r, green: g, blue: b, alpha: alpha)
                    return
                }
            }
        }
        return nil
    }
}

extension UITextField {
    
}
