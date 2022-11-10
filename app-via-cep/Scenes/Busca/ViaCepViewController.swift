//
//  ViewController.swift
//  app-via-cep
//
//  Created by Italo cavalcanti on 09/11/22.
//

import UIKit

class ViaCepViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cepTextField: UITextField!
    
    var lista: ListaDeEnderecos?
    var endereco: Endereco?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "seeCepViewController" else { return }
        guard let destination = segue.destination as? CepViewController else {
            fatalError("Não foi possível executar a segue: \(segue.identifier!)")
        }
//        guard cepPreenchido() else {
            ViaCepAPI.buscaCep(cep: cepTextField.text!) { (endereco) in
                DispatchQueue.main.async {
                    destination.endereco = endereco
                }
//            }
//            return
        }
        
//        switch endereco {
//        case nil:
//        default:
//            destination.endereco = endereco
//        }
        
    }
    
    func realizarBusca(enviarPara destination: CepViewController) {
        guard cepPreenchido() else {
            ViaCepAPI.buscaCep(cep: cepTextField.text!) { (endereco) in
                DispatchQueue.main.async {
                    destination.endereco = endereco
                }
            }
            return
        }
    }
    
    func cepPreenchido() -> Bool {
        if let cep = cepTextField.text, !cep.isEmpty {
            return true
        }
        return false
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if endereco == nil && !cepPreenchido() {
//            return false
//        }
//        return true
//    }
}

extension ViaCepViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista?.lista.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "meusEnderecosViewCell") as? MeusEnderecosViewCell else {
            fatalError("Não foi possível obter célula para lista")
        }
        cell.endereco = lista?.lista[indexPath.row]
        return cell
    }
}

extension ViaCepViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        endereco = lista?.lista[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
