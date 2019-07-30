/**
 * Created by aps on 2019-07-24.
 */

public with sharing class UpdateAccounts implements Database.Batchable<sObject>, Database.Stateful {

    private final String fieldName;
    private final String fieldValue;
    private Integer totalCount = 0;

    public UpdateAccounts(String fieldName, String fieldValue) {
        this.fieldName = fieldName;
        this.fieldValue = fieldValue;
    }

    static public Id launch(String fieldName, String fieldValue, Integer batchSize) {
        return Database.executeBatch(new UpdateAccounts(fieldName, fieldValue), batchSize);
    }

    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT ' + fieldName + ' FROM ACCOUNT');
    }

    public void execute(Database.BatchableContext BC,
                        List<sObject> scope) {
        for (Sobject s : scope) {
            s.put(fieldName, fieldValue);
        }
        update scope;
        totalCount += scope.size();
    }

    public void finish(Database.BatchableContext BC) {
        system.debug('totalCount='+totalCount);
    }
}