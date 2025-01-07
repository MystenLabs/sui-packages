module 0x766042aa4fa1744e070eaaaf323161f97f4b9e2b68b4337f24f9ab43afca2d62::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<PAPA>(arg0, 13504350381133385648, b"papa", b"papa", b"Papa sui", b"https://images.hop.ag/ipfs/QmQLg1baonXESU5sGwQX7BV3BsertZn9JfASGNKhSTwRQJ", 0x1::string::utf8(b"https://x.com/papaonsui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/papasui"), arg1);
    }

    // decompiled from Move bytecode v6
}

