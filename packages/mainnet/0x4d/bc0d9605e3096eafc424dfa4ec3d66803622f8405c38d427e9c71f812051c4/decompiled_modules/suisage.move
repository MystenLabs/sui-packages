module 0x4dbc0d9605e3096eafc424dfa4ec3d66803622f8405c38d427e9c71f812051c4::suisage {
    struct SUISAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUISAGE>(arg0, 6363405015588739743, b"Suisage Party", b"SUISAGE ", b"Big Blue suisage party", b"https://images.hop.ag/ipfs/QmUDwYcMBh2KbUaLFfTJY6YPGZc9qCzFRZR52hoh1dgdUX", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

