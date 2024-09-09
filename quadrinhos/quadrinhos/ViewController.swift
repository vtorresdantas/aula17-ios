//
//  ViewController.swift
//  quadrinhos
//
//  Created by Usuário Convidado on 09/09/24.
//

import UIKit

var comic:Comic!=nil

class ViewController: UIViewController {
    
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var data: UILabel!
    
    @IBOutlet weak var titulo: UILabel!
    
    @IBOutlet weak var minhaImagem: UIImageView!
    
    
    @IBAction func exibir(_ sender: Any) {
        
        loadComic()
        
    }
    
    func loadComic(){
        let jsonUrlString = "https://xkcd.com/info.0.json"
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!){data, response, error in
            guard let data = data else {return}
            
            do {
                
                comic = try JSONDecoder().decode(Comic.self, from: data)
                
                let imagem = self.carregarImagem(urlImagem: comic.img)
                
                DispatchQueue.main.sync {
                    self.titulo.text = comic.title
                    self.id.text = String(comic.num)
                    self.data.text = comic.day + "/" + comic.month + "/" + comic.year
                    
                    self.minhaImagem.image = imagem
                }
                
                //print(comic.title)
                
            }catch let jsonError{
                print("Error serialization Json", jsonError)
            }
        }
        
        .resume()
        
    }
    
    func carregarImagem(urlImagem:String) -> UIImage?{
        
        guard let url = URL(string: urlImagem)
        else {
            print("Nao foi possivel criar a url")
            return nil
        }
        
        var image:UIImage? = nil
        
        do {
            let data = try Data(contentsOf: url, options: [])
            
            //criando a imagem
            image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
        
        return image
                
            
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

