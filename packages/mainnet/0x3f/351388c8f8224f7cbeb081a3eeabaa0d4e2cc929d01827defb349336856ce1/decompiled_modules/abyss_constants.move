module 0x3f351388c8f8224f7cbeb081a3eeabaa0d4e2cc929d01827defb349336856ce1::abyss_constants {
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

