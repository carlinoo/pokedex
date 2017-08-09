//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by mac on 06/08/2017.
//  Copyright © 2017 Carlos Gonzalez. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var PokemonNameLbl: UILabel!
    @IBOutlet weak var PokemonMainImage: UIImageView!
    @IBOutlet weak var DescriptionLbl: UITextView!
    @IBOutlet weak var TypeLbl: UILabel!
    @IBOutlet weak var HeightLbl: UILabel!
    @IBOutlet weak var WeightLbl: UILabel!
    @IBOutlet weak var DefenseLbl: UILabel!
    @IBOutlet weak var PokedexIDLbl: UILabel!
    @IBOutlet weak var AttackLbl: UILabel!
    @IBOutlet weak var NextEvolutionLbl: UILabel!

    var pokemon: Pokemon!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set info of pokemon label
        PokemonNameLbl.text = pokemon.name.capitalized
        PokemonMainImage.image = UIImage(named: String(pokemon.pokedexID))
        
        
        // When the info of the Pokemon is downloaded...
        pokemon.downloadPokemonDetail {
            self.updateUI()
        }
        

        // Do any additional setup after loading the view.
    }

    @IBAction func BackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Update the UI
    
    func updateUI() {
        HeightLbl.text = pokemon.height
        WeightLbl.text = pokemon.weight
        DefenseLbl.text = pokemon.defense
        PokedexIDLbl.text = String(pokemon.pokedexID)
        AttackLbl.text = pokemon.attack
        TypeLbl.text = pokemon.type
        DescriptionLbl.text = pokemon.description
    }
    
    

}
