module 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants {
    public fun atomic() : u8 {
        0
    }

    public fun canceled() : u8 {
        4
    }

    public fun current_version() : u64 {
        1
    }

    public fun expired() : u8 {
        3
    }

    public fun filled() : u8 {
        2
    }

    public fun ice_berge() : u8 {
        1
    }

    public fun live() : u8 {
        0
    }

    public fun max_fan_out() : u64 {
        64
    }

    public fun max_fee() : u64 {
        100000
    }

    public fun max_fills() : u64 {
        100
    }

    public fun max_multiple() : u64 {
        1000
    }

    public fun max_open_orders() : u64 {
        100
    }

    public fun max_price() : u64 {
        9223372036854775807
    }

    public fun max_slice_size() : u64 {
        64
    }

    public fun max_u128() : u128 {
        340282366920938463463374607431768211455
    }

    public fun max_u64() : u64 {
        18446744073709551615
    }

    public fun min_price() : u64 {
        1
    }

    public fun min_size_default() : u64 {
        10000
    }

    public fun ord_limit() : u8 {
        1
    }

    public fun ord_market() : u8 {
        0
    }

    public fun partially_filled() : u8 {
        1
    }

    public fun self_matching_allowed() : u8 {
        0
    }

    public fun ten_days_ms() : u64 {
        864000000
    }

    public fun tick_size_default() : u64 {
        100
    }

    // decompiled from Move bytecode v6
}

