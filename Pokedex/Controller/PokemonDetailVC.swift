//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by David Murillo on 5/15/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit
import Alamofire

class PokemonDetailVC: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    var pokemon:Pokemon!
    let api = PokemonApi()
    
    override func viewWillAppear(_ animated: Bool) {
        api.getPokemon(url: URL_POKEMON + "/\(pokemon.pokedexId)/") { (pokeJSON) in
              if let pokeJ = pokeJSON{
                  self.setupUI(pokemon: pokeJ)
                  //print(pokeJ)
              }
          }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
    }
    
    func setupUI(pokemon:PokeJSON){
        descriptionLbl.text = pokemon.name
        weightLbl.text = String(pokemon.weight)
        heightLbl.text = String(pokemon.height)
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
