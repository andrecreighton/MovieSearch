//
//  MovieTableViewCell.swift
//  Flixr
//
//  Created by Andre Creighton on 10/23/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//
import SDWebImage
import UIKit

class MovieTableViewCell: UITableViewCell {
  
  var movieViewModel: MovieViewModel! {
    didSet{
      titleLabel.text = movieViewModel.title
      releaseDateLabel.text = movieViewModel.releaseDate
      overviewLabel.text = movieViewModel.overview
      posterImageView.sd_setImage(with: movieViewModel.imageUrl, completed: nil)
    }
  }

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!  
  @IBOutlet weak var overviewLabel: UILabel!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
