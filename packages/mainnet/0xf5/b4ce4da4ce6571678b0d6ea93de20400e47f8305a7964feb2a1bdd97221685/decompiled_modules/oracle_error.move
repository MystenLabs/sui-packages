module 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::oracle_error {
    public(friend) fun ema_spot_price_too_different() : u64 {
        3
    }

    public(friend) fun invalid_delay_tolerance() : u64 {
        6
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

