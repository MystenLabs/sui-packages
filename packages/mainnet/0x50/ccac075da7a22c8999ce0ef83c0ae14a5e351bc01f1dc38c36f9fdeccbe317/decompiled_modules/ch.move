module 0x50ccac075da7a22c8999ce0ef83c0ae14a5e351bc01f1dc38c36f9fdeccbe317::ch {
    struct CH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CH>(arg0, 6, b"CH", b"Suitzerland", x"576520686176652063686f636f6c6174652c2057652068617665206d6f6e65792e0a0a5269636865737420636f756e747279206f6e2074686520626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730990601530.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

