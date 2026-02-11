module 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_constants {
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

