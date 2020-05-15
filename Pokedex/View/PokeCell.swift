//
//  PokeCell.swift
//  Pokedex
//
//  Created by David Murillo on 5/14/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!

    
    func configCell(pokemon:Pokemon){
        nameLbl.text = pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(pokemon.pokedexId)")
    }
    
}
