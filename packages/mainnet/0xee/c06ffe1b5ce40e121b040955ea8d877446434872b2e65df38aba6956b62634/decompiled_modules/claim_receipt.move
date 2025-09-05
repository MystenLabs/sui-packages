module 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::claim_receipt {
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

