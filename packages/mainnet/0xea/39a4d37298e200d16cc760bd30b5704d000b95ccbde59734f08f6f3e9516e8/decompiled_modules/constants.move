module 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants {
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

