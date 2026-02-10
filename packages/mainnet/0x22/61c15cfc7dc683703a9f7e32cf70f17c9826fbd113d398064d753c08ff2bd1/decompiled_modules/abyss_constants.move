module 0x2261c15cfc7dc683703a9f7e32cf70f17c9826fbd113d398064d753c08ff2bd1::abyss_constants {
    public(friend) fun max_protocol_fee() : u64 {
        200000000
    }

    public(friend) fun max_underlying_decimals() : u8 {
        9
    }

    public(friend) fun min_atoken_supply() : u64 {
        1000000
    }

    public(friend) fun min_underlying_decimals() : u8 {
        6
    }

    public(friend) fun version() : u64 {
        2
    }

    // decompiled from Move bytecode v6
}

