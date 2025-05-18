module 0xf3a171772a1fa3e22c0211924ea8e26570f85103000a5642bd8fdddeeaa52df5::btc21_token {
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

