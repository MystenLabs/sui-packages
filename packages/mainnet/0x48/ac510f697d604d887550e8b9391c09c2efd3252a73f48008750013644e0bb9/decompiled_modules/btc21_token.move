module 0x48ac510f697d604d887550e8b9391c09c2efd3252a73f48008750013644e0bb9::btc21_token {
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

