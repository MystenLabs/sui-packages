module 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error {
    public fun already_closed(arg0: u64) : u64 {
        abort arg0
    }

    public fun capacity_violation(arg0: u64) : u64 {
        abort arg0
    }

    public fun invalid_amount(arg0: u64) : u64 {
        abort arg0
    }

    public fun invalid_fee_amount(arg0: u64) : u64 {
        abort arg0
    }

    public fun invalid_sender(arg0: u64) : u64 {
        abort arg0
    }

    public fun invalid_token(arg0: u64) : u64 {
        abort arg0
    }

    public fun invalid_witness(arg0: u64) : u64 {
        abort arg0
    }

    public fun not_time_yet(arg0: u64) : u64 {
        abort arg0
    }

    public fun transaction_suspended(arg0: u64) : u64 {
        abort arg0
    }

    public fun zero_value(arg0: u64) : u64 {
        abort arg0
    }

    // decompiled from Move bytecode v6
}

