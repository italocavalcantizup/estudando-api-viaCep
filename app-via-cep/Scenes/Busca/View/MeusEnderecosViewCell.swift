//
//  MeusEnderecosViewCell.swift
//  app-via-cep
//
//  Created by Italo cavalcanti on 10/11/22.
//

import UIKit

class MeusEnderecosViewCell: UITableViewCell {

    @IBOutlet weak var apelidoLabel: UILabel!
    @IBOutlet weak var setaLabel: UIImageView!
    
    var endereco: Endereco? {
        didSet {
            guard let apelido = endereco?.apelido else { return }
            apelidoLabel.text = apelido
        }
    }
    
}
