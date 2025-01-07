module 0xc5a00518b74cf79854bbacfafef555e8b1804ed7e14c88833a35a46918c4cc96::tomoon {
    struct TOMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMOON, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TOMOON>(arg0, 2847952963746198952, b"TOMOON", b"TOMOON", b"TOMOON", b"https://images.hop.ag/ipfs/QmRXzDqGnM9m96owyqAbTVkaYudWwg3HZhgafEkC8j1XAn", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

