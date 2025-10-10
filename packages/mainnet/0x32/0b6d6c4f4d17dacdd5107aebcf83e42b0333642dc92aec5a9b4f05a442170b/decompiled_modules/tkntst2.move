module 0x320b6d6c4f4d17dacdd5107aebcf83e42b0333642dc92aec5a9b4f05a442170b::tkntst2 {
    struct TKNTST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKNTST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKNTST2>(arg0, 6, b"TKNTST2", b"Test Token AYU 2", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKNTST2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TKNTST2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

