module 0x36f04801453287dc5b242942264548359f2ad88cee5276d93c405ac4b09aea7d::btc21_token {
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

