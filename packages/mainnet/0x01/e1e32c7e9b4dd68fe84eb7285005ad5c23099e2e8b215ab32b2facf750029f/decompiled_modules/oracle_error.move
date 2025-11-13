module 0x1e1e32c7e9b4dd68fe84eb7285005ad5c23099e2e8b215ab32b2facf750029f::oracle_error {
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

