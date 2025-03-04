module 0x5680e9030c147b413a489f7891273acc221d49bd061c433e5771bc170fc37ac::referrer_logger {
    struct ReferrerSet has copy, drop {
        referrer_address: address,
        fee_rate_ref: u8,
    }

    public fun log_referrer(arg0: address, arg1: u8) {
        let v0 = ReferrerSet{
            referrer_address : arg0,
            fee_rate_ref     : arg1,
        };
        0x2::event::emit<ReferrerSet>(v0);
    }

    // decompiled from Move bytecode v6
}

