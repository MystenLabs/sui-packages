module 0x772ac8a6699e8152a50b6bb3276c0b4a66566cbb2cb0a794e90415f2c32f3ab6::bucket_policy {
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

