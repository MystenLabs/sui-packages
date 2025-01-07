module 0xa884a68c09a4e1f198e4e9214b7cfb6fb56fc6cc6bce23db685bfc52ab4658e3::constants {
    public fun days_in_year() : u64 {
        365
    }

    public fun locked_str() : 0x1::string::String {
        0x1::string::utf8(b"locked")
    }

    public fun max_bps() : u16 {
        10000
    }

    public fun num_keeps_to_reserve() : u64 {
        500
    }

    public fun open_ended_str() : 0x1::string::String {
        0x1::string::utf8(b"open_ended")
    }

    public fun precision() : u256 {
        10000000000000
    }

    public fun times_token_decimals() : u64 {
        100000
    }

    // decompiled from Move bytecode v6
}

