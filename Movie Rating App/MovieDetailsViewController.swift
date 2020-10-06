//
//  MovieDetailsViewController.swift
//  Movie Rating App
//
//  Created by Ruchika Gupta on 10/3/20.
//  Copyright © 2020 guptaru1. All rights reserved.
//

import UIKit
import Alamofire

class MovieDetailsViewController: UIViewController {
    

    @IBOutlet weak var backdropView: UIImageView!
    
    @IBOutlet weak var posterView: UIImageView!
        
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie : [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        
        synopsisLabel.sizeToFit()
        
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        //Checking if it is a proper a picture
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af_setImage(withURL: posterUrl!)
        
        
        let backdropPath = movie["backdrop_path"] as! String
        
        //Checking if it is a proper a picture
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        
        backdropView.af_setImage(withURL: backdropUrl!)
        

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
