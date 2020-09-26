//
//  MoviesViewController.swift
//  Movie Rating App
//
//  Created by Ruchika Gupta on 9/23/20.
//  Copyright © 2020 guptaru1. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    
    @IBOutlet var tableView: UITableView!
    //Properties
    //Create array of dictionaries
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        
        super.viewDidLoad()

        print ("Hello")
        
        //Called when the app is loaded
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
            
            //
            self.tableView.reloadData()
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
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
    
    //Lets you work with the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
          
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //For particular row give cell
        //Gives you recyceld cell if a cell is ofofscrenn
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        //After looking at api
        //Cast title
        let title = movie["title"] as! String
        
        //Get the movies description after checking from api
        let synopsis = movie["overview"] as! String
        
        
        //cell.textLabel?.text = "row: \(indexPath.row)"
        cell.titleLabel.text = title
        //Make the cell's text equal to the synopsis
        cell.synopsisLabel.text = synopsis
        
        //Constructing posterr url
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        //Checking if it is a proper a picture
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        
        return cell
          
      }
      

}
