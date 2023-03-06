public class BulkRecordInsertFinalizer implements Finalizer{
    private List<sObject> recordsToInsert; 
    private Id bulkInsertStatusId;
    private Integer numOfTransactionInserts;

    public BulkRecordInsertQueueablePseudocode(List<sObject> recordsToInsert, Id bulkInsertStatusId, Integer numOfTransactionInserts) {
        1. Set all passed in variables to instance variables.
    }
    
    public execute(QueueableContext ctx){
        1. Make variable, recordsToProcess, which is a list
        2. Populate recordsToProcess with records from recordsToInsert until the size of recordsToProcess is numOfTransactionInserts
        3. Remove the records placed in recordsToProcess from recordsToInsert
        4. Insert all records in the recordsToProcess list, log and keep track of any errors
        5. Call System.attachFinalizer() method, passing in instance of BulkRecordInsertFinalizer, as well as the required parameters
        6. If recordsToInsert still has any records remaining, enqueue this queueable again, passing in all instance variables
        7. If there were any errors in the insertion of recordsToProcess, throw an Exception (This will be caught by the finalizer).
    }
}

