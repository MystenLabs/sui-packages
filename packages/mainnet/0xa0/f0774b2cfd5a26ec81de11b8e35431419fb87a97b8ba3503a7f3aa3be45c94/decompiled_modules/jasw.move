module 0xa0f0774b2cfd5a26ec81de11b8e35431419fb87a97b8ba3503a7f3aa3be45c94::jasw {
    struct JASW has drop {
        dummy_field: bool,
    }

    fun init(arg0: JASW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JASW>(arg0, 6, b"JASW", b"JASW by SuiAI", b"JASW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/your_paragraph_text_18162522681_e7ea2e92c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JASW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JASW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

