/**
 * Created by aps on 2019-07-24.
 */

public with sharing class DeleteAccounts implements Database.Batchable<sObject>, Database.Stateful {

    private Integer totalCount = 0;

    public DeleteAccounts() {
    }

    static public Id launch() {
        return Database.executeBatch(new DeleteAccounts(), 2000);
    }

    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT ID FROM ACCOUNT');
    }

    public void execute(Database.BatchableContext BC,
                        List<sObject> scope) {
        delete scope;
        totalCount += scope.size();
    }

    public void finish(Database.BatchableContext BC) {
        system.debug('totalCount=' + totalCount);
    }
}