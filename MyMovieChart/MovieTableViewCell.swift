//
//  MovieTableViewCell.swift
//  MyMovieChart
//
//  Created by doyun on 2021/09/30.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var title : UILabel!
    @IBOutlet var desc : UILabel!
    @IBOutlet var opendate : UILabel!
    @IBOutlet var rating : UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
