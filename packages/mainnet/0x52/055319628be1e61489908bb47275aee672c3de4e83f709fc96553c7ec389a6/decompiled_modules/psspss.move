module 0x52055319628be1e61489908bb47275aee672c3de4e83f709fc96553c7ec389a6::psspss {
    struct PSSPSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSSPSS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<PSSPSS>(arg0, 11701545743660685154, b"Suicat", b"PssPss", b"A test token", b"https://images.hop.ag/ipfs/QmW2b7BDAekVWvGLDwWAjevqbjK2KNC6j25N3z9VwURfz9", 0x1::string::utf8(b"https://x.com"), 0x1::string::utf8(b"https:/t.me"), 0x1::string::utf8(b"https:/t.me/"), arg1);
    }

    // decompiled from Move bytecode v6
}

