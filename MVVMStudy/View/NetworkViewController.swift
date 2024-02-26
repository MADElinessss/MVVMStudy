//
//  NetworkViewController.swift
//  MVVMStudy
//
//  Created by Madeline on 2/26/24.
//

import Alamofire
import SnapKit
import UIKit

class NetworkViewController: UIViewController {
    
    let segmentControl = UISegmentedControl(items: ["한국어", "영어"])
    let tableView = UITableView()
    
    let viewModel = NetworkViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.inputNetworkViewDidLoad.value = ()
        viewModel.outputMarketList.bind { _ in
            self.tableView.reloadData()
        }
        configureView()
        
    }
    
    func configureView() {
        
        navigationItem.title = "업비트 거래 가능 마켓"
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(segmentControl)
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(44)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
        
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
    }
    
    @objc func segmentChanged() {
        tableView.reloadData()
    }

}

extension NetworkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputMarketList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        if segmentControl.selectedSegmentIndex == 0 {
            cell.textLabel?.text = viewModel.outputMarketList.value[indexPath.row].korean_name
        } else {
            cell.textLabel?.text = viewModel.outputMarketList.value[indexPath.row].english_name
        }
        return cell
    }
    
    
}
