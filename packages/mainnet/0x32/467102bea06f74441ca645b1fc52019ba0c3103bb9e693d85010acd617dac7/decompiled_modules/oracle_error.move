module 0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::oracle_error {
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

