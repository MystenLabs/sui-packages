module 0xc26726f84d8949359edf2ff5d161bef0c7aa7ce154a7dbc632b903e6343cdee1::pls {
    struct PLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PLS>(arg0, 8698446585998287960, b"purr", b"pls", b"hy[p]e", b"https://images.hop.ag/ipfs/QmNgUBU6ttED8TUZ5xR8hYgpeywAywB6k7XYZQ7DQ6nXtK", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

