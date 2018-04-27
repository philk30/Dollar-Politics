//
//  AllStructs.swift
//  Dollar Politics
//
//  Created by Phillip Rusa on 12/24/17.
//  Copyright © 2017 Rusa. All rights reserved.
//

import Foundation
import UIKit

//Expenditure Struct//

struct Expenditures:Decodable {
    let response: Exp_Response
}

struct Exp_Response:Decodable {
    let indexp: [Indexp]
}

struct Indexp:Decodable {
    let attributes: Exp_Attributes
}

struct Exp_Attributes:Decodable {
    let cmteid: String
    let pacshort: String
    let suppopp: String
    let candname: String
    let district: String
    let amount: String
    let note: String
    let party: String
    let payee: String
    let date: String
    let origin: String
    let source: String
}
//End of Expenditure Structre

//*******Candidate Top Contributors********

struct TopContributors:Decodable{
    let response:Contributors
}

struct Contributors:Decodable{
    let contributors:TopContributor_Attributes 
    //let contributor:Contributor
}

struct TopContributor_Attributes:Decodable{
    let attributes:TopContributor_Candidate_Details
}

struct TopContributor_Candidate_Details:Decodable{
    //details of dictonary
    let cand_name: String?
    let cid: String?
    let cycle: String?
    let origin: String?
    let source: String?
    let notice: String?
}

struct Contributor:Decodable{
    let contributor:[Contributor_Attributes]
}

struct Contributor_Attributes:Decodable{
    let attributes: Contributor_Details
}

struct Contributor_Details:Decodable{
    //details of Contributor. Contributors could be many.
    let org_name: String?
    let total: String?
    let pacs: String?
    let indivs:String?
}
//**********End of Candidate Top Contributors*************

//****Legislators by State****

struct Legislators:Decodable {
    let response: Legislators_Response
}

struct Legislators_Response:Decodable {
    let legislator: [Legislator]
}

struct Legislator:Decodable {
    let attributes: Legislators_Attributes
}

struct Legislators_Attributes:Decodable {
    let cid: String
    let firstlast: String
    let lastname: String
    let party: String
    let office: String
    let gender: String
    let first_elected: String
    let exit_code: String
    let comments: String
    let phone: String
    let fax: String
    let website: String
    let webform: String
    let congress_office: String
    let bioguide_id: String
    let votesmart_id: String
    let feccandid: String
    let twitter_id: String
    let youtube_url: String
    let facebook_id: String
    let birthdate: String
}

//End of Legislators by State***


//Sector Contributors per Candidate

struct SectorContributions: Decodable {
    let response: Sector_Response
}

struct Sector_Response: Decodable {
    let sectors: Sectors_Contributions
    
}

struct Sectors_Contributions: Decodable {
    let attributes: SectorsAttributes
    let sector: [Sector_Details]
    
}

struct SectorsAttributes: Decodable {
    let cand_name: String
    let cid: String
    let cycle: String
    let origin: String
    let source: String
    let last_updated: String
    
}

struct Sector_Details: Decodable {
    let attributes: SectorAttributes
    
}

struct SectorAttributes: Decodable {
    let sector_name: String
    let sectorid: String
    let indivs: String
    let pacs: String
    let total: String
}

//End of Sector Contributions
