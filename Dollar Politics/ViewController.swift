//
//  ViewController.swift
//  Dollar Politics
//
//  Created by Phillip Rusa on 12/9/17.
//  Copyright © 2017 Rusa. All rights reserved.
//

import UIKit


struct Candidate: Decodable{
    let response:[CandIndus]
}

struct CandIndus: Decodable {
    let candIndus:[Attributes]
}

struct Attributes:Decodable{
    let attributes:[Atris]
}

struct Atris: Decodable {
    let cand_name:String?
    let cid:String?
    let cycle:String?
    let industry:String?
    let chamber:String?
    let party:String?
    let state:String?
    let total: Int?
    let indivs: Int?
    let pacs:Int?
    let rank: Int?
    let origin:String?
    let source: String?
}


class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = "https://www.opensecrets.org/api/?method=CandIndByInd&cid=N00007360&cycle=2018&ind=K02&output=json&apikey=[]"
        
        guard let url = URL(string:jsonUrlString)else
        {return}
    
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            
            guard let data = data else {return}
            
            let stringdata = String(data:data, encoding: .utf8)
            let newStringdata = stringdata?.replacingOccurrences(of: "@", with: "")
            let newdata = newStringdata?.data(using: String.Encoding.utf8)

            do {
                let candidate = try JSONDecoder().decode(Candidate.self, from: newdata!)
                print(candidate)
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
