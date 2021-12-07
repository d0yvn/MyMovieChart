//
//  DetailViewController.swift
//  MyMovieChart
//
//  Created by doyun on 2021/10/12.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var mvo:MovieVO?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        //WKNavigationDelegate
        webView.uiDelegate = self
        // WKUIDelegate 객체 지정
        
        let naviBar = navigationItem
        naviBar.title = mvo?.title
        
        if let url = mvo?.detail {
            if let urlObj = URL(string: url) {
                let req = URLRequest(url: urlObj)
                webView.load(req)
            } else {
                let alert = UIAlertController(title: "오류", message: "잘못된 URL입니다.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "확인", style: .cancel) { _ in
                    _ = self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(cancelAction)
                present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "필수 파라미터가 누락되었습니다.", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "확인", style: .cancel) { _ in
                _ = self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func alert(_ message:String,onClick:(()->Void)? = nil) {
        let controller = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { _ in
            onClick?()
        }))
        DispatchQueue.main.async {
            self.present(controller, animated: true, completion: nil)
        }
    }

}

extension DetailViewController : WKNavigationDelegate,WKUIDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.spinner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        
        alert("상세페이지를 읽어오지 못했습니다.") {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        
        alert("상세페이지를 읽어오지 못했습니다.") {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}
