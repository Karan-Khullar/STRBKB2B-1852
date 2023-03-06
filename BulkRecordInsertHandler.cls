public class BulkRecordInsertHandler {

    public static Id handleBulkInsert(List<sObject> recordsToInsert, Bulk_Insert_Metadata__mdt config){
        1. Make Bulk_Record_Insert_Status__c record and insert it. Store it in a local variable called "bulkInsertStatus"

        2. If config.Process_Records_Before_Queuable__c == true and recordsToInsert.size() > config.Frontend_Record_Amount_Cutoff__c
            1a. Insert the first config.Frontend_Record_Amount_Cutoff__c number of records from recordsToInsert, and then delete them
                from the list
            1b. Update bulkInsertStatus accordly

        3. If config.Parallel_Processing__c == true
            2a. Split recordsToInsert into multiple lists of size config.Records_Inserted_Per_Queuable__c
            2b. Loop over this new list of lists, and enqueue BulkRecordInsertQueueable for each one,
                passing in the current list, bulkInsertStatus record id, and config.Records_Inserted_Per_Queuable__c
                as constructor arguments.
        
        4. If config.Parallel_Processing__c == false
            3a. Enqueue a BulkRecordInsertQueueable, pass recordsToInsert, bulkInsertStatus record id, 
                and config.Records_Inserted_Per_Queuable__c as constructor arguments.
        
        5. Return bulkInsertStatus.Id
    }

}