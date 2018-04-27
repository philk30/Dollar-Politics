//
//  PoliticianTableView.swift
//  Dollar Politics
//
//  Created by Phillip Rusa on 12/26/17.
//  Copyright © 2017 Rusa. All rights reserved.
//
import UIKit



class PoliticianTableView: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var legislatorslis = [Legislator]()
    var senateblock = [String]()
    var houseblock = [String]()
    var StateInput:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(StateInput!)
        downloadLegJson{
    
            self.tableView.reloadData()
        
        }
    
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return legislatorslis.count//rows are dependent on the number of data in data source
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell.textLabel?.text = legislatorslis[indexPath.row].attributes.firstlast
        //creating a blank table cell that is returned at the end
        //code for populating the cells.
        
       /* if (legislatorslis[indexPath.row].attributes.website.range(of: ".house.") != nil){
            if indexPath.section == 0{
            cell.textLabel?.text = legislatorslis[indexPath.row].attributes.firstlast}
            
        } else if (legislatorslis[indexPath.row].attributes.website.range(of: ".senate.") != nil){
            
            if indexPath.section == 1 {

                cell.textLabel?.text = legislatorslis[indexPath.row].attributes.firstlast}
            
        }*/
        return cell
    }
    
   /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "House" //creates a title for the table section. The title Senate will appear on top of the section of the table containing senators
        }else{
            return "Senate" //creates a title for the table section containing House representatives.
        }
    }*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMoneyChart", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MoneyChartViewController{
            destination.PolitFacts = legislatorslis[(tableView.indexPathForSelectedRow?.row)!].attributes.cid
            destination.PolitName = legislatorslis[(tableView.indexPathForSelectedRow?.row)!].attributes.firstlast

        }
        
    }
    
    func downloadLegJson(completed:@escaping () -> ()){
        let jsonUrlString = "https://www.opensecrets.org/api/?method=getLegislators&id="+StateInput!+"&output=json&apikey="
        
        guard let url = URL(string:jsonUrlString)else
        {return}
        
        
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            
            guard let data = data else {return}
            
            let stringdata = String(data:data, encoding: .utf8) //turning data into string for processing
            let newStringdata = stringdata?.replacingOccurrences(of: "@", with: "") //removed the instances of "@" in the json
            let newdata = newStringdata?.data(using: String.Encoding.utf8) //turning processed stirng back into data
            
            do {
                let legislatorslist = try JSONDecoder().decode(Legislators.self, from: newdata!)
                self.legislatorslis = legislatorslist.response.legislator
                DispatchQueue.main.async {
                    completed()
                }
            }catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
    }
    
    
    
    
    
}


