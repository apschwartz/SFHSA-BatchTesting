/**
 * Created by aps on 2019-07-24.
 */

@IsTest
private class UpdateAccounts_Test {

    @IsTest
    static void updateWithLargeBatchSize() {
        createAccounts(2000);

        Test.startTest();
        UpdateAccounts.launch('Industry', 'Electronics', 2000);
        Test.stopTest();

        Integer updatedAccounts = [SELECT COUNT() FROM Account WHERE Industry = 'Electronics'];
        system.assertEquals(2000, updatedAccounts);

    }

    private static void createAccounts(Integer numberAccounts) {
        Account[] accountsToInsert = new Account[]{};

        for (Integer i=1; i <= numberAccounts; i++) {
            accountsToInsert.add(new Account(Name = ('Account '+ i)));
        }

        insert accountsToInsert;
    }

}