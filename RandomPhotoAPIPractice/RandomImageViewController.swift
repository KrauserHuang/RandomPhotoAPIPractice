//
//  RandomImageViewController.swift
//  RandomPhotoAPIPractice
//
//  Created by Tai Chin Huang on 2021/1/31.
//

import UIKit

class RandomImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var urlStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.setTitle("Dog", forSegmentAt: 0)
        segmentControl.setTitle("Cat", forSegmentAt: 1)
        fetchImage()
    }
    //透過segmentControl判斷該提供抓狗還抓貓的連結
    func chooseDogOrCat() {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            urlStr = "https://loremflickr.com/320/240/dog"
        case 1:
            urlStr = "https://loremflickr.com/320/240/cat"
        default:
            break
        }
    }
    
    func fetchImage() {
        chooseDogOrCat()
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }.resume()
        }
    }
    //更新畫面
    @IBAction func loadImage(_ sender: UIButton) {
        fetchImage()
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
