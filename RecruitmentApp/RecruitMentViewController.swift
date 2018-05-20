//
//  ViewController.swift
//  RecruitmentApp
//
//  Created by Yuichiro Tsuji on 2018/05/16.
//  Copyright © 2018年 Yuichiro Tsuji. All rights reserved.
//

import UIKit
import Alamofire

class RecruitMentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    var companyImage: [String] = []
    var companyName: [String] = []
    var companyDescription: [String] = []
    var cellCount: Int = 0
    
    
    let apiURL = "https://www.wantedly.com/api/v1/projects?q=swift&page=0"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(cellCount)
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        if indexPath.row >= companyName.count {
            cell.textLabel!.text = ""
            cell.textLabel!.text = ""
            print(companyName.count)
        } else {
            //cellをカスタムして概要や写真を表示
            cell.textLabel!.text = companyName[indexPath.row]
//            cell.textLabel!.text = companyDescription[indexPath.row]
        }
        return cell
    }
    
    //TODO: jsonから表示するデータをperseするメソッド
    func loadData() {
        
        Alamofire.request(apiURL).validate().responseJSON {
            response in
            let result = try! JSONDecoder().decode(CompanyData.self, from: response.data!)
            
            //TODO: TotalPage数に合わせてapiURLのpageを変える
            print("TotalPage: \(result._metadata.total_pages)")
            self.cellCount = result._metadata.per_page * result._metadata.total_pages
            for data in result.data {
                self.companyImage.append(data.image?.original ?? "error")
                self.companyName.append(data.company?.name ?? "error")
                self.companyDescription.append(data.description ?? "error")
            }
            for i in result.data {
                print(i.company?.name! ?? "error")
            }
            
            self.tableView.reloadData()
            print("company : \(self.companyDescription.count)" )
            return
        }
    }
    
    func getImageFromUrl(sourceUrl: String) -> UIImage? {
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

