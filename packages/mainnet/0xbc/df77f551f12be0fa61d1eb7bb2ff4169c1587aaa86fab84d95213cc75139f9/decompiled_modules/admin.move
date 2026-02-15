module 0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::admin {
    struct Admin has drop {
        dummy_field: bool,
    }

    public(friend) fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

