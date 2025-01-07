module 0x586ba574ced1acbf108ca86b69fa0d428dc08d2739b00de1943fe0fddf5c7a4e::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DINO>(arg0, 3314171710145578396, b"HopDino", b"DINO", x"547769747465723a2068747470733a2f2f782e636f6d2f486f7044696e6f5375690a576562736974653a2068747470733a2f2f64696e6f6d656d65636f696e2e636f6d2f0a54656c656772616d3a2068747470733a2f2f742e6d652f486f7044696e6f537569", b"https://images.hop.ag/ipfs/QmbGUEdWeJ7cFNoCjA9pHAn8pedbQvbwtkn5QU3ptksX4w", 0x1::string::utf8(b"https://x.com/HopDinoSui"), 0x1::string::utf8(b"https://dinomemecoin.com/"), 0x1::string::utf8(b"https://t.me/HopDinoSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

