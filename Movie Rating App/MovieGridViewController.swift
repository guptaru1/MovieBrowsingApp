//
//  MovieGridViewController.swift
//  Movie Rating App
//
//  Created by Ruchika Gupta on 10/3/20.
//  Copyright © 2020 guptaru1. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
 
    

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        

        //To accomodatee for different phone screens/sizes
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        //controls line spacing bw rows
        layout.minimumLineSpacing = 4
        
        //To calculate the size of a single poster
        
        layout.minimumInteritemSpacing = 4
        
        //access width of the phone and if want 3 posters divide by 3
        //Multiply by n-1 to find the spacing
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2)/3
        //height taller than the width for an aspect ratio
        layout.itemSize = CGSize(width: width, height: width*3 / 2)
        
        //Called when the app is loaded
        let url = URL(string:
                        "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            //Casting as an array of dictionary
            //Get table of movies
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            //Reload data as you update the movies count after getting the data
            self.collectionView.reloadData()
            //
            print (self.movies)
           }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        //Not rows and cells
        let movie = movies[indexPath.item]
        //Constructing posterr url
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        //Checking if it is a proper a picture
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        //cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
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
