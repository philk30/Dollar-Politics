//
//  ViewController.swift
//  Dollar Politics
//
//  Created by Phillip Rusa on 12/9/17.
//  Copyright © 2017 Rusa. All rights reserved.
//

import UIKit

struct Candidate:Decodable {
    let response: Response
}

struct Response:Decodable {
    let candIndus: CandIndus
}

struct CandIndus:Decodable {
    let attributes: Attributes
}

struct Attributes:Decodable {
    let cand_name: String
    let cid: String
    let cycle: String
    let industry: String
    let chamber: String
    let party: String
    let state: String
    let total: String
    let indivs: String
    let pacs: String
    let rank: String
    let origin: String
    let source: String
    let last_updated: String
}


/*
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
*/

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBAction func Search(_ sender: UIButton) {
        self.performSegue(withIdentifier: "PoliticianTableSegue", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination1 = segue.destination as? PoliticianTableView{
            destination1.StateInput = SelectedState
        }
        
    }
    
    
    @IBOutlet weak var PickState: UIPickerView!
    
    var SelectedState = ""
    var full = [String]()
    var abb = [String]()
    
     var states = [ "AL", "AK", "AS", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FM", "FL", "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MH", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "MP", "OH", "OK", "OR", "PW", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "WY" ]
    
    let stateDictionary = [ "Alaska" : "AK", "Alabama" : "AL", "Arkansas" : "AR", "American Samoa" : "AS", "Arizona" : "AZ", "California" : "CA", "Colorado" : "CO", "Connecticut" : "CT", "District of Columbia" : "DC", "Delaware" : "DE", "Florida" : "FL", "Georgia" : "GA", "Guam" : "GU", "Hawaii" : "HI", "Iowa" : "IA", "Idaho" : "ID", "Illinois" : "IL", "Indiana" : "IN", "Kansas" : "KS", "Kentucky" : "KY", "Louisiana" : "LA", "Massachusetts" : "MA", "Maryland" : "MD", "Maine" : "ME", "Michigan" : "MI", "Minnesota" : "MN", "Missouri" : "MO", "Mississippi" : "MS", "Montana" : "MT", "North Carolina" : "NC", "North Dakota" : "ND", "Nebraska" : "NE", "New Hampshire" : "NH", "New Jersey" : "NJ", "New Mexico" : "NM", "Nevada" : "NV", "New York" : "NY", "Ohio" : "OH", "Oklahoma" : "OK", "Oregon" : "OR", "Pennsylvania" : "PA", "Puerto Rico" : "PR", "Rhode Island" : "RI", "South Carolina" : "SC", "South Dakota" : "SD", "Tennessee" : "TN", "Texas" : "TX", "Utah" : "UT", "Virginia" : "VA", "Virgin Islands" : "VI", "Vermont" : "VT", "Washington" : "WA", "Wisconsin" : "WI", "West Virginia" : "WV", "Wyoming" : "WY"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stateDictionary.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        full = Array(stateDictionary.keys)
        abb = Array(stateDictionary.values)
        full.sort()
        return full[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SelectedState = stateDictionary[full[row]]!
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PickState.delegate = self
        PickState.dataSource = self
        
        
        
        //let CID = String(8)
        //var CID_String = String(CID)
        
        
        
        //let jsonUrlString1 = "https://www.opensecrets.org/api/?method=candContrib&output=json&cid="+CID + "&cycle=2018&apikey=249ece4240d376bd9884613f18ed0430"
        
        let jsonUrlString = "https://www.opensecrets.org/api/?method=CandIndByInd&cid=N00007360&cycle=2018&ind=K02&output=json&apikey="
        func parseJsons (URLString:String) {
        
        guard let url = URL(string:jsonUrlString)else
        {return}
    
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            
            guard let data = data else {return}
            
            let stringdata = String(data:data, encoding: .utf8) //turning data into string for processing
            let newStringdata = stringdata?.replacingOccurrences(of: "@", with: "") //removed the instances of "@" in the json
            let newdata = newStringdata?.data(using: String.Encoding.utf8) //turning processed stirng back into data

            do {
                let candidate = try JSONDecoder().decode(Candidate.self, from: newdata!)
                //print(candidate.response.candIndus.attributes.cand_name)
                
            }catch let jsonErr {
                print("Error serializing json:", jsonErr)
                
            }
        }.resume()
            

        }
        
        parseJsons(URLString: jsonUrlString)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
