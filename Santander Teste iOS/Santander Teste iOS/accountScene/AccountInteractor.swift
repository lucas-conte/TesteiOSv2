//
//  AccountInteractor.swift
//  Santander Teste iOS
//
//  Created by Lucas Ferraciolli Assis on 17/06/19.
//  Copyright © 2019 Lucas Conte. All rights reserved.
//

import Foundation

protocol AccountBusinessLogic {
    func setUserAccount(userAccount: UserAccount)
    func fetchStatementList()
    func getStatementList() -> [Account.Statement]?
}

protocol AccountDataStore {
    var userAccount: UserAccount? { set get }
    var statementList: Account.Response? { set get }
}

class AccountInteractor: AccountBusinessLogic, AccountDataStore {
    var presenter: AccountPresentationLogic?
    var worker = AccountWorker()
    var userAccount: UserAccount?
    var statementList: Account.Response?
    
    func setUserAccount(userAccount: UserAccount) {
        self.userAccount = userAccount
        self.presenter?.presentUserAccountData(userAccount: userAccount)
    }
    
    func fetchStatementList() {
        self.worker.fetchStatements { (response) in
            self.statementList = response
        }
    }
    
    func getStatementList() -> [Account.Statement]? {
        return self.statementList?.statementList
    }
}
