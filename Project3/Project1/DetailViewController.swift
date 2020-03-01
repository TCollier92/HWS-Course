//
//  DetailViewController.swift
//  Project1
//
//  Created by Tom Collier on 24/02/2020.
//  Copyright © 2020 Tom Collier. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage : String?
    var selectedTitle : String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = selectedImage
        {
            imageView.image = UIImage(named: image)
            
        }
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let unwrappedTitle = selectedTitle
        {
            title = unwrappedTitle
        }
        else
        {
            title = "Picture"
        }
        // Do any additional setup after loading the view.
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
