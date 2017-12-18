//
//  ViewController.swift
//  Dollar Politics
//
//  Created by Phillip Rusa on 12/9/17.
//  Copyright © 2017 Rusa. All rights reserved.
//

import UIKit


struct Candidate: Decodable{
    let response:CandIndus
}

struct CandIndus: Decodable {
    let candIndus:Attributes
}

struct Attributes:Decodable{
    let attributes:Atris
}

struct Atris: Decodable {
    let cand_name:String?
    let cid:String?
    let cycle:String?
    let industry:String?
    let chamber:String?
    let party:String?
    let state:String?
    let total: String?
    let indivs: String?
    let pacs:String?
    let rank: String?
    let origin:String?
    let source: String?
}


class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = "https://www.opensecrets.org/api/?method=CandIndByInd&cid=N00007360&cycle=2018&ind=K02&output=json&apikey="
        
        guard let url = URL(string:jsonUrlString)else
        {return}
    
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            
            guard let data = data else {return}
            
            let stringdata = String(data:data, encoding: .utf8) //turning data into string for processing
            let newStringdata = stringdata?.replacingOccurrences(of: "@", with: "") //removed the instances of "@" in the json
            let newdata = newStringdata?.data(using: String.Encoding.utf8) //turning processed stirng back into data

            do {
                let candidate = try JSONDecoder().decode(Candidate.self, from: newdata!)
                print(candidate.response.candIndus.attributes.cand_name ?? String())
            }catch let jsonErr {
                print("Error serializing json:", jsonErr)
                
            }
        }.resume()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
