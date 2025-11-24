module 0x5f242832f991f81c7e92c380ff00bcce100ecb279aacb526715afa35d8bdb0cc::purchase_policy {
    struct PurchaseReceipt has store, key {
        id: 0x2::object::UID,
        seal_policy_id: 0x1::string::String,
        submission_id: 0x2::object::ID,
        purchaser: address,
        purchased_at_epoch: u64,
    }

    fun check_policy(arg0: vector<u8>, arg1: &PurchaseReceipt) : bool {
        arg0 == *0x1::string::as_bytes(&arg1.seal_policy_id)
    }

    public(friend) fun mint_receipt(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : PurchaseReceipt {
        PurchaseReceipt{
            id                 : 0x2::object::new(arg3),
            seal_policy_id     : arg0,
            submission_id      : arg1,
            purchaser          : arg2,
            purchased_at_epoch : 0x2::tx_context::epoch(arg3),
        }
    }

    public fun purchased_at_epoch(arg0: &PurchaseReceipt) : u64 {
        arg0.purchased_at_epoch
    }

    public fun purchaser(arg0: &PurchaseReceipt) : address {
        arg0.purchaser
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &PurchaseReceipt) {
        assert!(check_policy(arg0, arg1), 1);
    }

    public fun seal_policy_id(arg0: &PurchaseReceipt) : &0x1::string::String {
        &arg0.seal_policy_id
    }

    public fun submission_id(arg0: &PurchaseReceipt) : 0x2::object::ID {
        arg0.submission_id
    }

    // decompiled from Move bytecode v6
}

