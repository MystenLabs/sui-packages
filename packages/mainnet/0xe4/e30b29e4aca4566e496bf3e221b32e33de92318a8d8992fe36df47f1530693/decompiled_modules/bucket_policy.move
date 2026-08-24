module 0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::bucket_policy {
    struct BucketPolicy has store, key {
        id: 0x2::object::UID,
        owner: address,
        seal_policy_id: address,
    }

    public fun create(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : BucketPolicy {
        BucketPolicy{
            id             : 0x2::object::new(arg1),
            owner          : 0x2::tx_context::sender(arg1),
            seal_policy_id : arg0,
        }
    }

    public fun seal_approve(arg0: vector<u8>, arg1: &BucketPolicy, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 0);
    }

    // decompiled from Move bytecode v7
}

