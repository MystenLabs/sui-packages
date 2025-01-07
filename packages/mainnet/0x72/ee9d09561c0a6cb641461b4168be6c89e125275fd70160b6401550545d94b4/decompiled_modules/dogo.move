module 0x72ee9d09561c0a6cb641461b4168be6c89e125275fd70160b6401550545d94b4::dogo {
    struct DOGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGO>(arg0, 9, b"DOGO", b"Dogo Coin", x"427579696e67207468697320746f6b656e203d2057696c6c2068656c7020697420746f20537472617920646f6773204f7574207468657265202c204c6574277320676f2067757973202c206c657427732070756d70207468697320636f696e20746f20746865206d6f6f6e20f09f9a80f09f9a80f09f9a80202c2057652050726f6d69736520416c6c2050726f6669742077696c6c20676f20746f20537472617920646f67732061726f756e642074686520776f726c6420f09f9095f09f90b6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/739423c8-1eb4-48f1-adf1-d3c5bc46eff0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

