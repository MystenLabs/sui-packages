module 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants {
    public(friend) fun exchange_price_rate_output_decimals() : u128 {
        100000000000000000
    }

    public(friend) fun exchange_prices_precision() : u128 {
        1000000000000
    }

    public(friend) fun four_decimals() : u64 {
        10000
    }

    public(friend) fun initial_exchange_price() : u64 {
        1000000000000
    }

    public(friend) fun max_i64() : u128 {
        9223372036854775807
    }

    public(friend) fun max_rate() : u64 {
        65535
    }

    public(friend) fun max_token_amount_cap() : u64 {
        1152921504606846975
    }

    public(friend) fun max_token_decimals() : u8 {
        9
    }

    public(friend) fun max_u64() : u128 {
        18446744073709551615
    }

    public(friend) fun min_decay_duration() : u64 {
        288
    }

    public(friend) fun min_operate_amount() : u64 {
        10
    }

    public(friend) fun min_token_decimals() : u8 {
        2
    }

    public(friend) fun position_status_active() : u8 {
        0
    }

    public(friend) fun position_status_not_set() : u8 {
        2
    }

    public(friend) fun position_status_paused() : u8 {
        1
    }

    public(friend) fun seconds_per_year() : u64 {
        31536000
    }

    public(friend) fun total_decay_duration() : u64 {
        3600
    }

    public(friend) fun twelve_decimals() : u128 {
        1000000000000
    }

    public(friend) fun version() : u64 {
        1
    }

    public(friend) fun x14() : u64 {
        16383
    }

    public(friend) fun x24() : u64 {
        16777215
    }

    // decompiled from Move bytecode v7
}

