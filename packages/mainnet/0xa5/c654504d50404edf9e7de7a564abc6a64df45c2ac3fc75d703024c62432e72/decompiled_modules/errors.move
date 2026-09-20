module 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors {
    public fun already_bitten() : u64 {
        1
    }

    public fun bad_argument() : u64 {
        7
    }

    public fun collateral_gone() : u64 {
        2
    }

    public fun net_below_min() : u64 {
        3
    }

    public fun not_enough_seized() : u64 {
        5
    }

    public fun price_unavailable() : u64 {
        6
    }

    public fun repay_zero() : u64 {
        4
    }

    // decompiled from Move bytecode v7
}

