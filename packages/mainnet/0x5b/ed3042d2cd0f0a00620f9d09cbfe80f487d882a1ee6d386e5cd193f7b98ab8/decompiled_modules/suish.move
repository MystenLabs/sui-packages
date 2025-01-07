module 0x5bed3042d2cd0f0a00620f9d09cbfe80f487d882a1ee6d386e5cd193f7b98ab8::suish {
    struct SUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUISH>(arg0, 17345985366319466311, b"Suish", b"SUISH", b"Suish- Just Buy it.", b"https://images.hop.ag/ipfs/QmSi2EMT4gSxGSAgGjqn3T7MxHaRt5gwB25eLVrsHR2i1G", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

