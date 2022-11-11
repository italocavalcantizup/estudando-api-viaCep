//
//  CepViewController.swift
//  app-via-cep
//
//  Created by Italo cavalcanti on 09/11/22.
//

import UIKit

class CepViewController: UIViewController {
    
    @IBOutlet weak var cepTextField: UITextField!
    @IBOutlet weak var logradouroTextField: UITextField!
    @IBOutlet weak var bairroTextField: UITextField!
    @IBOutlet weak var localidadeTextField: UITextField!
    @IBOutlet weak var ufTextField: UITextField!

    @IBOutlet weak var numeroTextField: UITextField!
    @IBOutlet weak var complementoTextField: UITextField!
    @IBOutlet weak var apelidoLabel: UITextField!
    
    @IBOutlet weak var botaoSalvar: UIButton!
        
    var endereco: Endereco?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let endereco = endereco {
            setupViews(com: endereco)
        }
    }
    
    private func setupViews(com endereco: Endereco) {
        cepTextField.text = endereco.cep
        logradouroTextField.text = endereco.logradouro
        bairroTextField.text = endereco.bairro
        localidadeTextField.text = endereco.localidade
        ufTextField.text = endereco.uf
        validaEPreencheCamposOpcionais(com: endereco)
    }
    
    func validaEPreencheCamposOpcionais(com endereco: Endereco) {
        if let apelido = endereco.apelido {
            apelidoLabel.text = apelido
        }
        
        if let numero = endereco.numero {
            numeroTextField.text = String(describing: numero)
        }
        
        if let complemento = endereco.complemento {
            complementoTextField.text = complemento
        }
    }
    
    @IBAction func salvarBotaoPressionado(_ sender: UIButton) {
        switch camposPreenchidos() {
        case (false, let mensagem):
            exibirAlerta(title: "Ops!", mensagem: mensagem)
        default:
            self.dismiss(animated: true)
        }
    }
    
    func camposPreenchidos() -> (Bool, String?) {
        guard let numero = numeroTextField.text, !numero.isEmpty else {
            return (false, "Preencha o campo número")
        }
        guard let apelido = apelidoLabel.text, !apelido.isEmpty else {
            return (false, "Preencha o apelido")
        }
        endereco?.numero = Int(numero)
        endereco?.apelido = apelido
        return (true, nil)
    }
    
    func exibirAlerta(title: String?, mensagem: String?) {
        let alert = UIAlertController(title: title, message: mensagem, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }
    
}
