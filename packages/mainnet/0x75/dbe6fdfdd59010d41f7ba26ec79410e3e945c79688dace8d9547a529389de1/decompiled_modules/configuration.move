module 0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::configuration {
    struct Configuration has store, key {
        id: 0x2::object::UID,
        start_claim_timestamp: u64,
        end_claim_timestamp: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            id                    : 0x2::object::new(arg0),
            start_claim_timestamp : 0,
            end_claim_timestamp   : 0,
        };
        0x2::transfer::share_object<Configuration>(v0);
    }

    public fun get_end_claim_timestamp(arg0: &Configuration) : u64 {
        arg0.end_claim_timestamp
    }

    public fun get_start_claim_timestamp(arg0: &Configuration) : u64 {
        arg0.start_claim_timestamp
    }

    public(friend) fun update(arg0: &mut Configuration, arg1: u64, arg2: u64) {
        arg0.start_claim_timestamp = arg1;
        arg0.end_claim_timestamp = arg2;
    }

    // decompiled from Move bytecode v6
}

