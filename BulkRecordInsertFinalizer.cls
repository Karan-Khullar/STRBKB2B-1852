public class BulkRecordInsertFinalizer implements Finalizer{
    private Id bulkInsertStatusId;
    private Integer recordsInserted;

    public BulkRecordInsertQueueablePseudocode(Id bulkInsertStatusId, Integer recordsInserted) {
        1. Set all passed in variables to instance variables.
    }

    public execute(FinalizerContext ctx){
        1. Query the Bulk_Record_Insert_Status__c record like so: 
            Bulk_Record_Insert_Status__c queriedStatus =
                [SELECT Id, Inserted_Amount__c FROM Bulk_Record_Insert_Status__c WHERE Id =: bulkInsertStatusId FOR UPDATE][0];

        2. Make an instance of the Bulk_Record_Insert_Status__c object like so:
            Bulk_Record_Insert_Status__c bulkRecordInsertStatus = 
                new Bulk_Record_Insert_Status__c(Id = bulkInsertStatusId, Inserted_Amount__c = queriedStatus.Inserted_Amount__c)
        
        3. Check if the Queueable failed via ctx.getResult(). 
           If it failed, update the bulkRecordInsertStatus record's Job_Failure__c field to true, and return out of this method
        
        4. Increment bulkRecordInsertStatus Inserted_Amount__c by recordsInserted, and update the record
    }
}
