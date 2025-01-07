module 0x9edc15c8c3fefae16211526cb7f859e49803fff3e103640436e7bcdd14562832::bltk {
    struct BLTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLTK>(arg0, 6, b"BLTK", b"BallotBucks", x"42616c6c6f744275636b732028424c544b2920697320796f757220676f2d746f20656c656374696f6e206d656d6520746f6b656e21204469766520696e746f20552e532e20706f6c697469637320776974682070726564696374696f6e732c20766f74696e672066756e2c20616e64206120706c617966756c207477697374206f6e2074686520656c6563746f72616c2070726f636573732020616c6c20706f77657265642062792063727970746f210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLTK_TF_6kr8_hu_Ab70_P5b9b_V_f5605a645e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

