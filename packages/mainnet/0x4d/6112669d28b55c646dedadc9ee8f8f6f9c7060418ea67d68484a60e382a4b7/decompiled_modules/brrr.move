module 0x4d6112669d28b55c646dedadc9ee8f8f6f9c7060418ea67d68484a60e382a4b7::brrr {
    struct BRRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRRR, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<BRRR>(arg0, 8964742017651359946, b"BRRR", b"BRRR", b"Money Printer Go Brrr", b"https://images.hop.ag/ipfs/QmbZ6rYWvXyf19Ag8h7LEXkdrx9PAECqyCtjrfEqv6rN55", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

