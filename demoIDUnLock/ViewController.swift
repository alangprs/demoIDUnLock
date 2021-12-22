//
//  ViewController.swift
//  demoIDUnLock
//
//  Created by will on 2021/12/22.
//

import UIKit
import LocalAuthentication



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func idUnlock(_ sender: UIButton) {
        
        let context = LAContext()
        // 宣告一個變數接收 canEvaluatePolicy 返回的錯誤
        var error: NSError?
        // 設置取消按鈕標題
        context.localizedCancelTitle = "取消"
        // 評估是否可以針對給定方案進行身份驗證
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            // 描述使用身份辨識的原因
            let reason = "使用生物辨識功能登入"
            // 指定登入方案
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (success, error) in
                if success {
                    DispatchQueue.main.async { [weak self] in
                        //成功時，執行alert內容
                        self?.showMessage(title: "登入成功", message: nil)
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        //失敗時，執行alert內容
                        self?.showMessage(title: "登入失敗", message: error?.localizedDescription)
                    }
                }
            }
        } else {
            showMessage(title: "登入失敗", message: error?.localizedDescription)
        }
        
    }
 
    func showMessage(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .cancel)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

