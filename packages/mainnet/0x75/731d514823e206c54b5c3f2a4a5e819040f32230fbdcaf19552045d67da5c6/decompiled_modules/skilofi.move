module 0x75731d514823e206c54b5c3f2a4a5e819040f32230fbdcaf19552045d67da5c6::skilofi {
    struct SKILOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKILOFI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SKILOFI>(arg0, 8572174414290577442, b"Ski Mask Lofi", b"SKILOFI", b"lofi wif a ski mask", b"https://images.hop.ag/ipfs/QmZGJkBhp991oUAqx19pm4zFu6k4d2Kmx4n7bVZqRFDqPu", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

