//
//  MovieDetailViewController.swift
//  Flixr
//
//  Created by Andre Creighton on 10/24/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import SDWebImage
import UIKit

class MovieDetailViewController: UIViewController {

  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var titleOfMovie: UILabel!
  @IBOutlet weak var overviewOfMovie: UILabel!
  
  var movie = Movie()
 
  override func viewDidLoad() {
        super.viewDidLoad()
    let movieViewModel = MovieViewModel(movie: movie)
    
    backdropImageView.sd_setImage(with: movieViewModel.imageBackdropUrl, completed: nil)
    titleOfMovie.text = movieViewModel.title
    overviewOfMovie.text = movieViewModel.overview
    
  }
    
  @IBAction func closeButtonTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    
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
