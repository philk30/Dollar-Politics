//
//  MoneyChartViewController.swift
//  Dollar Politics
//
//  Created by Phillip Rusa on 3/6/18.
//  Copyright © 2018 Rusa. All rights reserved.
//

import Foundation
import UIKit
import Charts


class MoneyChartViewController: UIViewController{
    
   @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var Test: UILabel!
    
    var PolitFacts:String?
    var PolitName:String?
    var SectorMoney = [Sector_Details]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Test.text = PolitName

        downloadSectorsJson {
            var MoneytotalsInt:[Double]

            var MoneyTotals:[String]=[]
            var SectorNames:[String]=[]
            
            for i in 0...5{
                MoneyTotals.append(self.SectorMoney[i].attributes.total)
                SectorNames.append(self.SectorMoney[i].attributes.sector_name)
            }
            

            MoneytotalsInt = MoneyTotals.map { Double($0)!}
            print(MoneyTotals)
            print(SectorNames)
            print(MoneytotalsInt)
            
            var dataEntry=[PieChartDataEntry]()
            for d in 0...5 {
                let entry = PieChartDataEntry(value: Double(MoneytotalsInt[d]),label:SectorNames[d])
                dataEntry.append(entry)
            }
            
            let chartDataSet = PieChartDataSet(values: dataEntry, label: "")
            chartDataSet.colors = ChartColorTemplates.material()
            chartDataSet.sliceSpace = 2
            chartDataSet.selectionShift = 5
            let chartData = PieChartData(dataSet: chartDataSet)
            
            self.pieChart.data = chartData
            self.pieChart.drawEntryLabelsEnabled = false
            self.pieChart.usePercentValuesEnabled = true

            
        }
 

    }
 

    

    func downloadSectorsJson(completed:@escaping () -> ()){
        
        print(PolitFacts!)
        let urlstring_sectors = "https://www.opensecrets.org/api/?method=candSector&cid="+PolitFacts!+"&output=json&cycle=2012&apikey="
        
        
        guard let url = URL(string:urlstring_sectors)else
        {return}
        
        
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            
            guard let data = data else {return}
            
            let stringdata = String(data:data, encoding: .utf8) //turning data into string for processing
            let newStringdata = stringdata?.replacingOccurrences(of: "@", with: "") //removed the instances of "@" in the json
            let newdata = newStringdata?.data(using: String.Encoding.utf8) //turning processed stirng back into data
            
            do {
                let sector_json = try JSONDecoder().decode(SectorContributions.self, from: newdata!)
                self.SectorMoney = sector_json.response.sectors.sector
                DispatchQueue.main.async {
                    completed()
                }
            }catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
        
    }
    
}


