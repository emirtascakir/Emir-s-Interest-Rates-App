//
//  PersonalCreditViewController.swift
//  Emir's Interest Rates App
//
//  Created by Emir TAŞÇAKIR on 24.08.2023.
//

import UIKit

class PersonalCreditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var result = [Result]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()


        tableView.delegate = self
        tableView.dataSource = self

        let apiManager = APIManager.shared
        apiManager.get(url: URL(string: "https://api.collectapi.com/credit/ihtiyacKredi")!) { data, error in
            if error != nil {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Hata", message: "Üzgünüz şu anda işlemi gerçekleştiremiyoruz. Lütfen daha sonra tekrar deneyin.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "Tamam", style: .default)
                    alert.addAction(okButton)
                    self.present(alert, animated: true)
                }
            } else {
                do {
                    let creditModel = try JSONDecoder().decode(CreditModel.self, from: data!)
                    self.result = creditModel.result
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personalCell", for: indexPath) as! PersonalCustomTableViewCell
        let credit = result[indexPath.row]
        cell.bankNameLabel.text = "Banka: \(credit.bank)"
        cell.creditNameLabel.text = "Kredi: \(credit.kredi)"
        cell.interestRateLabel.text = "Faiz Oranı: \(credit.faiz)"
        cell.minDueLabel.text = "Minimum Vade: \(credit.min)"
        cell.maxDueLabel.text = "Maksimum Vade: \(credit.max)"
        return cell
    }


}
