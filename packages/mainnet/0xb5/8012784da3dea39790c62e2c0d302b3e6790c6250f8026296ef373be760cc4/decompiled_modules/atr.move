module 0xb58012784da3dea39790c62e2c0d302b3e6790c6250f8026296ef373be760cc4::atr {
    struct ATR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATR>(arg0, 6, b"ATR", b"Aterna", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ATR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

