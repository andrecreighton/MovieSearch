//
//  MainFeedViewController.swift
//  Flixr
//
//  Created by Andre Creighton on 10/23/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import UIKit

class MainFeedViewController: UIViewController {
  
  @IBOutlet weak var segmentedContol: UISegmentedControl!
  @IBOutlet weak var movieTableView: UITableView!
  
  fileprivate var selectedMovie = Movie()
  private var movieDB = MovieDatabase()
  private var movieViewModel = MovieViewModel(movie: Movie())
  private var movieViewModels = [MovieViewModel]()

  
    override func viewDidLoad() {
        super.viewDidLoad()

      registerCells()
      fetchData(.upcoming)
      
      movieTableView.dataSource = self
      movieTableView.delegate = self
      
    }

  
  func fetchData(_ ep : MovieDatabase.Endpoint){
    
      movieDB.getInfoWithEndPoint(endpoint: ep, params: nil) {[weak self] (success, arr) in
        guard let self = self else{return}
        if success {
         // print("movies : \(arr)")
          self.movieViewModels.removeAll()
          self.movieViewModels = arr.map({return MovieViewModel(movie: $0)})
          DispatchQueue.main.async {
              self.movieTableView.reloadData()
          }
        }else{
        print("nope")
        }
      
      }
  }
  
  @IBAction func segmentedTouched(_ sender: Any) {
    
    let index = segmentedContol.selectedSegmentIndex
  
    switch index {
    case 0:
      fetchData(.upcoming)
    case 1:
      fetchData(.topRated)
    case 2:
      fetchData(.nowPlaying)
    default:
      fetchData(.upcoming)
    }
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "detail"{
      let destinationVC = segue.destination as? MovieDetailViewController
      destinationVC?.movie = selectedMovie
    }
  }
  
}

extension MainFeedViewController : UITableViewDelegate, UITableViewDataSource {
  
  func registerCells(){
    
    movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "movie")
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedMovie = movieViewModels[indexPath.row].movie
    
    performSegue(withIdentifier: "detail", sender: nil)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    movieViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = movieTableView.dequeueReusableCell(withIdentifier: "movie", for: indexPath) as! MovieTableViewCell
    let model = movieViewModels[indexPath.row]
    cell.movieViewModel = model
        
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 145
  }
  
  
}
