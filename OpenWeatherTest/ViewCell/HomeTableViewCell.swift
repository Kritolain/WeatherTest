//
//  HomeTableViewCell.swift
//  OpenWeatherTest
//
//  Created by Carolain Lenes Beltran on 19/11/19.
//  Copyright © 2019 Carolain Lenes Beltran. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconWeatherCity: UIImageView!
    @IBOutlet weak var tempMinMaxCityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadDataCity(_ weatherVO : WeatherVO){
        self.cityNameLabel.text = weatherVO.name
        self.descriptionLabel.text = weatherVO.weather![0].weatherDescription
        self.tempMinMaxCityLabel.text = String(weatherVO.main!.tempMin!) + " / " + String(weatherVO.main!.tempMax!)
                
        let url = URL(string: Globals().urlIcon + weatherVO.weather![0].icon! + "@2x.png")
              
        self.iconWeatherCity?.af_setImage(withURL: url!, placeholderImage: nil, filter: nil, imageTransition: UIImageView.ImageTransition.crossDissolve(0.5), runImageTransitionIfCached: true) { (response) in
                  guard response.value != nil else {
                      return
                  }
                  let image = response.value
                  let size = CGSize(width: 80, height: 80)
                  let roundedImage = image?.af_imageRoundedIntoCircle()
                  let scaledImage = roundedImage?.af_imageScaled(to: size)
                  DispatchQueue.main.async {
                      self.iconWeatherCity?.image = scaledImage
                  }
              }
     }

}
