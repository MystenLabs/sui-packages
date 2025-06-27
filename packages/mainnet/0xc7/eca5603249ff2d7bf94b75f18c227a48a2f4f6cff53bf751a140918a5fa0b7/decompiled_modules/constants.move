module 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants {
    public fun basis_point_max() : u256 {
        10000
    }

    public fun callback_success() : vector<u8> {
        x"5a5e2979256c8bf5f0c7403d3d5b5b2cf0a4301d2b2e3a91fd68767f96c6a5ea"
    }

    public fun max_fee() : u256 {
        100000000000000000
    }

    public fun max_liquidity_per_bin() : u256 {
        65251743116719673010965625540244653191619923014385985379600384103134737
    }

    public fun max_protocol_share() : u256 {
        2500
    }

    public fun precision() : u256 {
        1000000000000000000
    }

    public fun scale() : u256 {
        340282366920938463463374607431768211456
    }

    public fun scale_offset() : u8 {
        128
    }

    public fun squared_precision() : u256 {
        1000000000000000000000000000000000000
    }

    // decompiled from Move bytecode v6
}

