module 0x514063805600a87750e516a564a01299be2e627f2f177d005a6916329fe01616::oracle_error {
    public(friend) fun ema_spot_price_too_different() : u64 {
        3
    }

    public(friend) fun oracle_price_not_found_error() : u64 {
        1
    }

    public(friend) fun oracle_stale_price_error() : u64 {
        4
    }

    public(friend) fun oracle_zero_price_error() : u64 {
        5
    }

    public(friend) fun unknown_oracle_base_token() : u64 {
        2
    }

    // decompiled from Move bytecode v6
}

