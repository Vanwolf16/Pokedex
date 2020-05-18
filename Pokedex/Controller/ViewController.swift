//
//  ViewController.swift
//  Pokedex
//
//  Created by David Murillo on 5/13/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class ViewController: UIViewController{
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var musicBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filterPokemon = [Pokemon]()
    var musicPlayer = AVAudioPlayer()
    var inSearchMode = false
    
    //Second Data
    let api = PokemonApi()
    var pokemonRealData:Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSV()
        initAudio()
        
    }
    
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }catch let err as NSError{
            debugPrint(err.localizedDescription)
        }
        
    }
    
    //Parse CSV File
    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
            
        }catch let err as NSError{
            debugPrint(err.debugDescription)
        }
        
    }
    
    @IBAction func musicBtnClicked(_ sender: Any) {
        
        api.getPokemon(url: URL_POKEMON + "/\(4)/") { (pokeJSON) in
                     if let pokeJ = pokeJSON{
                         //self.setupUI(pokemon: pokeJ)
                        print(pokeJ.name)
                        
                     }
                 }
        
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            musicBtn.alpha = 0.2
        }else{
            musicPlayer.play()
            musicBtn.alpha = 1.0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.toPokeDetail{
            guard let pokeDetailVC = segue.destination as? PokemonDetailVC else {return}
            if let poke = sender as? Pokemon{
                pokeDetailVC.pokemon = poke
            }
        }
    }
    
    //Side note do it on DidSelect Row :)
    
    func setupUI(pokemon:PokeJSON){
        print(pokemon.name)
    }
    
}

extension ViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            myCollectionView.reloadData()
            //Hide Keyboard
            view.endEditing(true)
        }else{
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            
            filterPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            myCollectionView.reloadData()
            
        }
    }
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke:Pokemon!
        
        if inSearchMode{
            poke = filterPokemon[indexPath.item]
        }else{
            poke = pokemon[indexPath.item]
        }
        
        
        
        performSegue(withIdentifier: Identifier.toPokeDetail, sender: poke)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode{
            return filterPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell else {return UICollectionViewCell()}
        let poke: Pokemon!
        
        if inSearchMode{
            poke = filterPokemon[indexPath.item]
            cell.configCell(pokemon: poke)
        }else{
            poke = pokemon[indexPath.item]
            cell.configCell(pokemon: poke)
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
}
