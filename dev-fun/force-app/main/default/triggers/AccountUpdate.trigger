//Post chatter message on a specific group with account information 
//when specific criteria on Account is met.
trigger AccountUpdate on Account(after update) {  
    List<FeedItem> posts = new List<FeedItem>();
    
    //Bulk identify the accounts that match the criteria
    List<Account> updatedAccnts = [SELECT Id, Name  FROM Account WHERE Id IN :Trigger.new and Rating = 'Hot'];
    
    //Identify the chatter group where the post will be made
    CollaborationGroup chatterGroup = [SELECT Id FROM CollaborationGroup WHERE Name = 'Astro Accounts' LIMIT 1];
    
    //Iterate over the accounts, post chatter message with accnt info.
    for (Account acct : updatedAccnts) {
        String status = acct.Id + ' ' + acct.Name + ' This Account is HOT! ';
        FeedItem msg = new FeedItem(
            ParentId = chatterGroup.Id,
            Title = acct.Name,
            Body = status
        );
        posts.add(msg);
    }
    insert posts;
}