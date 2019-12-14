//
//  MovieSearchViewController.swift
//  Flixr
//
//  Created by Andre Creighton on 11/22/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {


  private var searchResultValue = ""
  private var movieViewModels = [MovieViewModel]()
  private var movieDB = MovieDatabase()
  fileprivate var selectedMovie = Movie()
  
  
  @IBOutlet weak var movieListTableView: UITableView!
  @IBOutlet weak var animatedFrontView: UIView!
  @IBOutlet weak var movieSearchBar: UISearchBar!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    movieSearchBar.delegate = self
    movieListTableView.delegate = self
    movieListTableView.dataSource = self
    registerCells()
        // Do any additional setup after loading the view.
    }
    
  @IBAction func whenBackTapped(_ sender: Any) {
    
    self.dismiss(animated: true, completion: nil)
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "detail"{
      let destinationVC = segue.destination as? MovieDetailViewController
      destinationVC?.movie = selectedMovie
    }
  }

  
}

extension MovieSearchViewController : UITableViewDelegate, UITableViewDataSource {
  
  func registerCells(){
    
    movieListTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "movie")
    
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedMovie = movieViewModels[indexPath.row].movie
    
    performSegue(withIdentifier: "detail", sender: nil)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return movieViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = movieListTableView.dequeueReusableCell(withIdentifier: "movie", for: indexPath) as! MovieTableViewCell
    let model = movieViewModels[indexPath.row]
    cell.movieViewModel = model
        
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 145
  }
  
}

extension MovieSearchViewController : UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    if let result = searchBar.text {
      searchResultValue = result
      print(searchResultValue)
      
     // TODO: Funtionality
      
      let params = ["query" : searchResultValue]
      movieDB.getInfoWithEndPoint(endpoint: .movieSearch, params: params) { (result) in
          
        switch result {
        case .success(let movies):
          self.movieViewModels = movies.map({return MovieViewModel(movie: $0)})
          DispatchQueue.main.async {
              
            if self.movieViewModels.count == 0 {
              self.noResultsFound()
            }
            
            self.movieListTableView.reloadData()
            self.animatedFrontView.alpha = 0
            self.movieSearchBar.resignFirstResponder()
          }
        case .failure(let err):
          print(err.localizedDescription)
        }
      }
    }
    
    if searchBar.text == "" {
      alertNoTextInSearch()
    }
    
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
    searchBar.resignFirstResponder()
    searchBar.text = ""
    
  }
  
  func noResultsFound(){
    
    let alertVC = UIAlertController(title: "Sorry", message: "No Results Found.", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "Okay", style: .default) { (_) in
      
      self.movieSearchBar.becomeFirstResponder()
    }

    alertVC.addAction(okAction)
    present(alertVC, animated: true, completion: nil)
    
    
  }
  
  func alertNoTextInSearch(){
    
    let alertVC = UIAlertController(title: "👀", message: "Please enter a search value.", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "Okay", style: .default) { (_) in
      
      self.movieSearchBar.becomeFirstResponder()
    }

    alertVC.addAction(okAction)
    present(alertVC, animated: true, completion: nil)
    
    
  }
  
}
