module 0xfeea31249847e993fc8c099cc91df9e566a537645665baa4160cd7069505cc1c::btc21_token {
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

