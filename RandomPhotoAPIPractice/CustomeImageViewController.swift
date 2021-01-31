//
//  CustomeImageViewController.swift
//  RandomPhotoAPIPractice
//
//  Created by Tai Chin Huang on 2021/1/31.
//

import UIKit

class CustomeImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var urlStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    //將上一頁的連結傳送過來然後直接抓圖顯示
    func fetchImage() {
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data,
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }.resume()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
