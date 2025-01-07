module 0x2392a6f0971142943aa47b9c721404cc024bbcd0e67b2e4f590866b4f2f7e10c::ttoken {
    struct TTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TTOKEN>(arg0, 707662227799874066, b"Test Token", b"TTOKEN", b"Simple as that - Test Token.", b"https://images.hop.ag/ipfs/Qmejc4gnX1pQYSTHqVzkDZcT26z7BvEJfn7d9c5655GgNq", 0x1::string::utf8(b"https://x.com"), 0x1::string::utf8(b"https://donotbuythetoken.com"), 0x1::string::utf8(b"https://t.me"), arg1);
    }

    // decompiled from Move bytecode v6
}

