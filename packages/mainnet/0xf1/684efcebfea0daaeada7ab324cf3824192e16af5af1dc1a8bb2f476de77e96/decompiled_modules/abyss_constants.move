module 0xf1684efcebfea0daaeada7ab324cf3824192e16af5af1dc1a8bb2f476de77e96::abyss_constants {
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
        1
    }

    // decompiled from Move bytecode v6
}

