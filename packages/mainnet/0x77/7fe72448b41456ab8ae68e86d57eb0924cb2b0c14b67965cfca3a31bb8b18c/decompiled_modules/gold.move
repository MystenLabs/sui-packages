module 0x777fe72448b41456ab8ae68e86d57eb0924cb2b0c14b67965cfca3a31bb8b18c::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GOLD>(arg0, 14049159444473298213, b"gold", b"GOLD", b"a chemical element that is a valuable, shiny, yellow metal used to make coins and jewellery", b"https://images.hop.ag/ipfs/QmRKGFvT4gSGo12fKhHG9jHAohrBsewvSN7Wb8HEynawiz", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

