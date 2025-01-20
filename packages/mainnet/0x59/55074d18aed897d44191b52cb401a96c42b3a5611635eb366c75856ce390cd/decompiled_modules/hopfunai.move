module 0x5955074d18aed897d44191b52cb401a96c42b3a5611635eb366c75856ce390cd::hopfunai {
    struct HOPFUNAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFUNAI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPFUNAI>(arg0, 8541020448313372202, b"HOPFUNAI", b"HOPFUNAI", b"HOPFUNAI", b"https://images.hop.ag/ipfs/QmRiZJ79bNnbRpgiJ1t1WBxsoEj6uGDX9sk5m4dabVvbvG", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

