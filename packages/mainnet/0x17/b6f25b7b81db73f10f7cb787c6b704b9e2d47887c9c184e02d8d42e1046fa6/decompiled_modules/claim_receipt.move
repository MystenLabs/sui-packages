module 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::claim_receipt {
    struct ClaimReceipt has key {
        id: 0x2::object::UID,
        withdrawn_amount: u64,
        request_timestamp: u64,
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : ClaimReceipt {
        ClaimReceipt{
            id                : 0x2::object::new(arg2),
            withdrawn_amount  : arg0,
            request_timestamp : arg1,
        }
    }

    public(friend) fun transfer(arg0: ClaimReceipt, arg1: address) {
        0x2::transfer::transfer<ClaimReceipt>(arg0, arg1);
    }

    public(friend) fun destroy(arg0: ClaimReceipt) {
        let ClaimReceipt {
            id                : v0,
            withdrawn_amount  : _,
            request_timestamp : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun id(arg0: &ClaimReceipt) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun request_timestamp(arg0: &ClaimReceipt) : u64 {
        arg0.request_timestamp
    }

    public fun withdrawn_amount(arg0: &ClaimReceipt) : u64 {
        arg0.withdrawn_amount
    }

    // decompiled from Move bytecode v6
}

