module 0xbdb67e76fc403abd3813d99beafae619d2ab2730ce5b535c281ec2559de0d216::btc21_token {
    struct BTC21 has copy, store {
        dummy_field: bool,
    }

    public fun decimals() : u8 {
        9
    }

    public fun name() : vector<u8> {
        b"BTC21"
    }

    public fun symbol() : vector<u8> {
        b"BTC21"
    }

    // decompiled from Move bytecode v6
}

