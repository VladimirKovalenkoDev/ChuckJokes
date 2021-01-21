//
//  JokeController.swift
//  ChuckJokes
//
//  Created by Владимир Коваленко on 21.01.2021.
//

import UIKit

class JokeController: BaseController {
    // MARK: - Properties
    private let tableView = UITableView()
    private var results = [Joke]()
    private var searchManager = SearchManager()
    // MARK: - UI elements
    private var bottomView: UIView =  {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        return view
    }()
    private var loadButton: UIButton = {
    let button = UIButton()
    button.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
    button.layer.cornerRadius = 17
    button.setTitle("Load", for: .normal)
    button.addTarget(self, action:  #selector(performLoad), for: .touchUpInside)
    return button
}()
    private var numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholderRect(forBounds: CGRect(x: 13, y: 160.39, width: 248, height: 19))
        textField.placeholder = "Input count..."
        textField.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.textAlignment = .center
        textField.font = UIFont(name: "Roboto-Regular", size: 17)
        return textField
    }()
    private var enterLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter number of jokes"
        label.textColor = .lightGray
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEnter()
        setUpBottom()
        searchManager.delegate = self
        numberTextField.delegate = self
        tabLabel.text = "Jokes"
    }
    // MARK: - set up of element, making constraints
    private func setUpTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(88)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-200)
        }
        
    }
    private func setUpBottom(){ // sets up bottom element
        view.addSubview(bottomView)
        bottomView.addSubview(numberTextField)
        bottomView.addSubview(loadButton)
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        numberTextField.snp.makeConstraints { (make) in
            make.top.equalTo(bottomView)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
            make.width.equalTo(127)
        }
        loadButton.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(74)
            make.top.equalTo(numberTextField.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            
        }
        
    }
    private func setUpEnter(){ // makes label when app launch
        view.addSubview(enterLabel)
        enterLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    @objc func performLoad(_ sender: UIButton!){
        enterLabel.removeFromSuperview()
        if let number = numberTextField.text {
            self.spinner.startAnimating()
            self.spinner.hidesWhenStopped = false
            searchManager.loadJokes(number: number)
        }
    }
}
// MARK: - SearchManagerDelegate/Network
extension JokeController: SearchManagerDelegate {
    func didSearch(_ searchManager: SearchManager, searchItems: Value) {
        DispatchQueue.main.async {
            self.setUpTableView()
            self.spinner.stopAnimating()
            self.spinner.hidesWhenStopped = true
            self.results = searchItems.value
            self.tableView.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.spinner.hidesWhenStopped = true
            self.tableView.removeFromSuperview()
            self.setUpEnter()
            let alertController = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in}
            alertController.addAction(cancel)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension JokeController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row].joke
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 11
        cell.textLabel?.textAlignment = .center
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
// MARK: - UITextFieldDelegate
extension JokeController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        numberTextField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        numberTextField.resignFirstResponder()
        return true
        }
}
