module 0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::configuration {
    struct Configuration has store, key {
        id: 0x2::object::UID,
        lender_fee_percent: u64,
        borrower_fee_percent: u64,
        min_health_ratio: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            id                   : 0x2::object::new(arg0),
            lender_fee_percent   : 0,
            borrower_fee_percent : 0,
            min_health_ratio     : 0,
        };
        0x2::transfer::share_object<Configuration>(v0);
    }

    public fun borrower_fee_percent(arg0: &Configuration) : u64 {
        arg0.borrower_fee_percent
    }

    public fun lender_fee_percent(arg0: &Configuration) : u64 {
        arg0.lender_fee_percent
    }

    public(friend) fun update(arg0: &mut Configuration, arg1: u64, arg2: u64, arg3: u64) {
        arg0.lender_fee_percent = arg1;
        arg0.borrower_fee_percent = arg2;
        arg0.min_health_ratio = arg3;
    }

    // decompiled from Move bytecode v6
}

