/**
 * Created by aps on 2019-07-24.
 */

@IsTest
private class DeleteAccounts_Test {

    @IsTest
    static void deleteWithLargeBatchSize() {
        createAccounts(2000);
        system.assertEquals(2000, [SELECT COUNT() FROM Account]);

        Test.startTest();
        DeleteAccounts.launch();
        Test.stopTest();

        system.assertEquals(0, [SELECT COUNT() FROM Account]);

    }

    private static void createAccounts(Integer numberAccounts) {
        Account[] accountsToInsert = new Account[]{};

        for (Integer i=1; i <= numberAccounts; i++) {
            accountsToInsert.add(new Account(Name = ('Account '+ i)));
        }

        insert accountsToInsert;
    }

}